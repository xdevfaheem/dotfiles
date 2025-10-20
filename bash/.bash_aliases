# ~/.bash_aliases

# ========================
# General Aliases
# ========================
alias la="ls -lah"      # List files with details, including hidden files
alias l="ls -CF"        # Compact file listing
alias c="clear"         # Clear the terminal screen
alias h="history"       # Show command history

# ========================
# Git Aliases
# ========================
alias gst="git status"  # Check the status of the Git repository
alias gco="git checkout" # Switch branches or restore files
alias ga="git add ."    # Add all changes
alias gc="git commit -m" # Commit with a message
alias gp="git push"     # Push changes to remote

# ========================
# System Management
# ========================
alias reboot="sudo reboot"        # Reboot the system
alias poweroff="sudo poweroff"    # Shut down the system
alias start_uwsm="uwsm check may-start && exec uwsm start -- hyprland-uwsm.desktop" # Enter into Hyprland with uwsm
alias rm='echo "This is not the command you are looking for, its trash-put"; false'


# ========================
# Development Tools
# ========================
alias v="vim"            # Open Vim
alias invim='nvim $(fzf --preview "cat {} --show-tabs" --preview-window border-vertical)' # interactive nvim
alias py="python3"       # Shortcut for Python 3

# ========================
# Custom Commands
# ========================
alias free="free -h"      # Display memory usage in human-readable format
alias path='echo $PATH'   # Print the current PATH

