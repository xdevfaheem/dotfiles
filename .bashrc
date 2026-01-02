# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# load env vars 
source ~/.bash_env

# to set vim key-bindings
set -o vi

# aliases
source ~/.bash_aliases

# customized shell prompt (https://stackoverflow.com/a/28938235)

export VIRTUAL_ENV_DISABLE_PROMPT=1

# color codes
BGREEN='\[\033[1;92m\]'
BBLUE='\[\033[1;94m\]'
BCYAN='\[\033[1;96m\]'
BOLD='\[\033[1m\]'
RESET='\[\033[0m\]'

# get the current conda env name ("", if no conda env is active) 
#CONDA_ENV='$(if [[ ! -z "$CONDA_DEFAULT_ENV" ]]; then echo "($CONDA_DEFAULT_ENV) "; fi)'

# get the current conda env name or venv name ("", if neither is active) 
ENV_NAME='$(if [[ ! -z "$CONDA_DEFAULT_ENV" ]]; then echo "($CONDA_DEFAULT_ENV) "; elif [[ ! -z "$VIRTUAL_ENV" ]]; then echo "($(basename $VIRTUAL_ENV)) "; fi)'

# primary prompt
PS1="\n${BGREEN}\u@\h${RESET} ${BBLUE}\$PWD${RESET} ${BCYAN}${ENV_NAME}${RESET}\n${BOLD}$ ${RESET}"
