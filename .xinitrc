#!/bin/sh

prefix="/usr"
exec_prefix="${prefix}"
xrdb="xrdb"
xinitdir="/etc/X11/xinit"
xclock="xclock"
xterm="xterm"
twm="twm"
xmodmap="xmodmap"

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources="$xinitdir/.Xresources"
sysmodmap="$xinitdir/.Xmodmap"

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$sysresources"
    else
        "$xrdb" -nocpp -merge "$sysresources"
    fi
fi

if [ -f "$sysmodmap" ]; then
    "$xmodmap" "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$userresources"
    else
        "$xrdb" -nocpp -merge "$userresources"
    fi
fi

if [ -f "$usermodmap" ]; then
    "$xmodmap" "$usermodmap"
fi

# https://www.reddit.com/r/suckless/comments/137waqi/dbus_related_problem_only_with_dwm/
# https://github.com/bakkeby/dwm-flexipatch/issues/352#issuecomment-1536419696
# https://voidforums.com/viewtopic.php?p=26826#p26826
# apparently, in non-systemd distro we have to start the dbus daemon and activate env, in other case systemd does it, sike !
# [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && eval $(/usr/bin/dbus-launch --exit-with-x11 --sh-syntax)
# dbus-update-activation-environment --verbose --all

# start some nice programs

if [ -d "$xinitdir"/xinitrc.d ] ; then
	for f in "$xinitdir/xinitrc.d"/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

xset r rate 300 50
xset s 500

xss-lock -- slock &

dunst &
dwmblocks &
clipmenud &
redshift &

pipewire &

# https://www.reddit.com/r/voidlinux/comments/1dw4j52/how_to_start_a_dbus_session/
# https://superuser.com/questions/1730756/running-standalone-window-manager-without-a-d-bus-session-in-linux
# https://eternal.sbs/articles/distros/voidutilities/#installation-of-i3wm
exec dbus-run-session -- /usr/local/bin/dwm 2> ~/src/dwm/dwm.log
