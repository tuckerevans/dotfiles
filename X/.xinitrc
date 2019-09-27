#Basic startx file uncomment lines for more functionality

feh --bg-fill /home/tje/Pictures/Wallpapers/moon.png
xrdb -load /home/tje/.Xresources
start-pulseaudio-x11 &

# Set reverse scrolling
xinput set-button-map 13 1 2 3 5 4 

~/.screenSetup.sh
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
exec i3
