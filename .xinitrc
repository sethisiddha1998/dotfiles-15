#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

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
#
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session ~/.xstart
setxkbmap it
if [ -f /etc/exherbo-release ]; then
  exec i3
else
  xrandr --setprovideroutputsource modesetting NVIDIA-0
  xrandr --auto
  safeeyes &
  nm-applet &
  # redshift-gtk &
  xset m 0 0
  exec startxfce4
fi
