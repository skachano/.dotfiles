#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard layout
setxkbmap jp

# Change the resolution to 1092x1080
xrandr --output eDP1 --auto &
# xrandr --output HDMI-1-0 --auto &
# sudo xrandr --auto &

# Compositor
picom &

# Wallpaper
nitrogen --restore &

# # Load time on the status bar
# while true; do
#    xsetroot -name "$(date)"
#    sleep 1min # update every second 
# done &

# slstatus &
statusbar &

# Notification server
dunst &

# Activate numlock on startup
numlockx &

# Keyboard layout manager fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &

export _JAVA_AWT_WM_NONREPARENTING=1

exec dwm
