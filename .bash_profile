# .bash_profile
# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# prevent running inside a running x session and only start on vt 1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec startx
fi
