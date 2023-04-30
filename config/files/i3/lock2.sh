#!/bin/bash

builtin cd "$HOME/.config/i3/"

import -silent -window root lock.png
notify-send --urgency low "Locking..."

# convert lock.png -scale 25% -blur 0x10 -scale 400% lock.png
convert lock.png -scale 25% -blur 0x4 -scale 400% lock.png
# convert lock.png -scale 50% -blur 0x6 -scale 200% lock.png

# convert lock.png -scale 10% -scale 1000% lock.png
# composite -gravity center pad.png lock.png lock.png

i3lock -i lock.png
