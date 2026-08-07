#!/usr/bin/env osascript

-- Toggle Hermes floating terminal.
-- - Found by session profile name (shells overwrite window titles)
-- - Exactly one window: create once, then show/hide
-- - Floated in AeroSpace by window-id (no focus race)

on floatHermesWindow()
    delay 0.3
    tell application "iTerm"
        set winId to id of front window
    end tell
    try
        do shell script "/opt/homebrew/bin/aerospace layout floating --window-id " & winId & " 2>/dev/null || true"
    end try
end floatHermesWindow

tell application "iTerm"
    set hermesWindow to missing value
    repeat with w in windows
        repeat with t in tabs of w
            repeat with s in sessions of t
                if profile name of s is "Hermes" then
                    set hermesWindow to w
                    exit repeat
                end if
            end repeat
            if hermesWindow is not missing value then exit repeat
        end repeat
        if hermesWindow is not missing value then exit repeat
    end repeat

    if hermesWindow is missing value then
        set hermesWindow to (create window with profile "Hermes")
        select hermesWindow
        activate
        delay 0.5
        my floatHermesWindow()
        return
    end if

    set isMini to miniaturized of hermesWindow

    if isMini then
        set miniaturized of hermesWindow to false
        select hermesWindow
        activate
        delay 0.3
        my floatHermesWindow()
    else
        set miniaturized of hermesWindow to true
    end if
end tell