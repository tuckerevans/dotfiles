#Basic startx file uncomment lines for more functionality

#feh --bg-fill !PATH_TO_WALLPAPER
xrdb -merge /home/tje/.Xresources
start-pulseaudio-x11 &
~/.screenSetup.sh
exec i3
exec twm
