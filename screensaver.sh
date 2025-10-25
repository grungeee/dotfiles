#!/bin/bash
# if pgrep -x "cbonsai" > /dev/null
# then
#     pkill cbonsai
# else
#     kitty --class=screensaver cbonsai -li
# fi
#
#!/bin/bash

if pgrep -x "cbonsai" > /dev/null
then
    pkill cbonsai
else
    kitty --class=screensaver cbonsai -li -t 0,1 -L 50 -c "0,1" -m "Even in death I serve the Omnissiah."
fi

