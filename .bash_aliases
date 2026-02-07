# ~/.bash_aliases

alias rm='echo "This is not the command you are looking for, its trash-put"; false'
alias invim='nvim $(fzf --preview "cat {} --show-tabs" --preview-window border-vertical)' # interactive nvim
alias xi='sudo xbps-install -Sv'
alias xu='sudo xbps-install -Suv'
alias xr='sudo xbps-remove -Rov'
alias xq='sudo xbps-query'
