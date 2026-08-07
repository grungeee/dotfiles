#!/bin/bash
# Toggle the Hermes scratchpad terminal (aerospace-scratchpad backed).
#
# Guarantees:
#   - exactly one iTerm2 "Hermes" profile window ever exists
#   - window is always centered on the main screen, ~50% larger than iTerm
#     default (80x25 -> 120x38 character grid, applied as pixel bounds)
#   - survives window being closed: next press recreates it fresh
#   - summon = floating, centered, focused; hide = back to .scratchpad
set -u

AS=/opt/homebrew/bin/aerospace
SP=/opt/homebrew/bin/aerospace-scratchpad
ID_FILE="${TMPDIR:-/tmp}/hermes-scratchpad-window-id"

# --- geometry: center of main screen, ~1.5x default terminal size ---------
center_window() {
    osascript <<'ASEOF'
tell application "Finder"
    set screenBounds to bounds of window of desktop
end tell
set screenW to item 3 of screenBounds
set screenH to item 4 of screenBounds

-- 50% larger than iTerm default (~80x25 chars ≈ 564x417 px on this setup)
set winW to round (screenW * 0.62)
set winH to round (screenH * 0.62)
set posX to round ((screenW - winW) / 2)
set posY to round ((screenH - winH) / 2)

tell application "iTerm"
    repeat with w in windows
        repeat with t in tabs of w
            repeat with s in sessions of t
                if profile name of s is "Hermes" then
                    set bounds of w to {posX, posY, posX + winW, posY + winH}
                    return true
                end if
            end repeat
        end repeat
    end repeat
    return false
end tell
ASEOF
}

# --- find aerospace window-id of the live Hermes window (no stale state) --
find_hermes_aero_id() {
    # iTerm-side: find the title of the window hosting a Hermes session.
    local hermes_title
    hermes_title=$(osascript <<'ASEOF'
tell application "iTerm"
    repeat with w in windows
        repeat with t in tabs of w
            repeat with s in sessions of t
                if profile name of s is "Hermes" then return name of w
            end repeat
        end repeat
    end repeat
    return ""
end tell
ASEOF
)
    [ -n "$hermes_title" ] || return 1

    # aerospace-side: find the iTerm2 window with that exact title.
    # JSON exposes only app-name, window-id, window-title (no layout key).
    $AS list-windows --all --json 2>/dev/null | python3 -c "
import json, sys
target = sys.argv[1]
for w in json.load(sys.stdin):
    if w.get('app-name') == 'iTerm2' and w.get('window-title') == target:
        print(w['window-id'])
        break
" "$hermes_title"
}

create_hermes_window() {
    osascript -e 'tell application "iTerm" to create window with profile "Hermes"' >/dev/null 2>&1
    sleep 0.8
    # the new window is focused; read its aerospace id directly
    $AS list-windows --focused --json 2>/dev/null | python3 -c "
import json, sys
d = json.load(sys.stdin)
w = d[0] if isinstance(d, list) and d else d
print(w.get('window-id',''))
"
}

# Close ALL Hermes windows except the one we keep (guard against duplicates
# left by earlier close-during-iterate bugs).
prune_duplicate_hermes_windows() {
    osascript <<'ASEOF' >/dev/null 2>&1
tell application "iTerm"
    set hermesWins to {}
    repeat with w in windows
        repeat with t in tabs of w
            repeat with s in sessions of t
                if profile name of s is "Hermes" then
                    set end of hermesWins to w
                    exit repeat
                end if
            end repeat
        end repeat
    end repeat
    -- keep the first, close the rest (iterate backwards over a snapshot list)
    if (count of hermesWins) > 1 then
        repeat with i from 2 to (count of hermesWins)
            try
                close (item i of hermesWins)
            end try
        end repeat
    end if
end tell
ASEOF
}

WIN_ID=$(find_hermes_aero_id)

if [ -n "$WIN_ID" ]; then
    # guard: if earlier runs left duplicates, keep one and close the rest
    prune_duplicate_hermes_windows
    # re-resolve in case the kept window differs from the floating match
    WIN_ID=$(find_hermes_aero_id)
    # exists: center it (in case it drifted), then toggle
    center_window >/dev/null 2>&1
    echo "$WIN_ID" > "$ID_FILE"
    exec "$SP" show iTerm2 -F "window-id=$WIN_ID"
fi

# missing (closed or first run): create fresh, park in scratchpad, show, center
WIN_ID=$(create_hermes_window)
if [ -z "$WIN_ID" ]; then
    echo "toggle-hermes-scratchpad: could not resolve window id" >&2
    exit 1
fi
echo "$WIN_ID" > "$ID_FILE"
"$SP" move iTerm2 -F "window-id=$WIN_ID" >/dev/null 2>&1
"$SP" show iTerm2 -F "window-id=$WIN_ID" >/dev/null 2>&1
sleep 0.3
center_window >/dev/null 2>&1