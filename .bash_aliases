# ~/.bash_aliases

alias rm='echo "This is not the command you are looking for, its trash-put"; false'
alias v="vim"            # Open Vim
alias invim='nvim $(fzf --preview "cat {} --show-tabs" --preview-window border-vertical)' # interactive nvim
alias cdwm="vim ~/.config/dwm/config.h"
alias mdwm="cd ~/.config/dwm; sudo make clean install; cd -"
alias codium="flatpak run com.vscodium.codium "
alias code="flatpak run com.visualstudio.code"
