#######################
# Some global variable
#######################
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export ZSH_DISABLE_COMPFIX=true
export EDITOR="vim"
export VISUAL="vim"
RED_TEXT='\033[31m'
YELLOW_TEXT='\033[33m'
CYAN_TEXT='\033[36m'
GREEN_TEXT='\033[32m'
ORIGIN_TEXT='\033[0m'
umask 0002
#######################
# Tmux Settings
#######################

if check_output=$(type tmux);then
#    if [ -z "$TMUX" ];then
#        exec tmux
#    else
#        tmux source-file "$HOME/.tmux.conf"
#    fi
else
    echo -e "${RED_TEXT}${check_output}${ORIGIN_TEXT}"
fi
#######################
# Command settings
#######################

git config --global user.name "Furrybear";
git config --global user.email "fbcll@outlook.com";
alias gitpush='git add .;git status;git commit -m "Some change.";git push';
echo -e "${GREEN_TEXT}Alias ${YELLOW_TEXT}gitpush ${GREEN_TEXT}was set${ORIGIN_TEXT}";


if check_output=$(type trash-put);then
    alias tp='trash-put'
    echo -e "${GREEN_TEXT}Alias ${YELLOW_TEXT}tp ${GREEN_TEXT}was set${ORIGIN_TEXT}" 
else
    echo -e "${RED_TEXT}${check_output}${ORIGIN_TEXT}"
fi
alias su='cygstart --action=runas mintty -'
alias sudo='sudo'
alias v='ssh bear-vm'
if [ -d "$HOME/bear-local/code" ];then
    alias cdcode="cd $HOME/bear-local/code"
    echo -e "${GREEN_TEXT}Alias ${YELLOW_TEXT}cdcode ${GREEN_TEXT}was set${ORIGIN_TEXT}"
fi
#######################
# Oh-my-zsh Settings
#######################
if [ ! -d $ZSH ];then
    #git clone https://github.com/robbyrussell/oh-my-zsh.git "$ZSH"
fi
if [ -d $ZSH ];then
    ZSH_THEME="ys"
    ZSH_THEME_RANDOM_CANDIDATES=( "ys" )
    # ENABLE_CORRECTION="true"
    # DISABLE_UNTRACKED_FILES_DIRTY="true"
    # HIST_STAMPS="mm/dd/yyyy"
    plugins=(git z)
    source $ZSH/oh-my-zsh.sh
    source $ZSH/plugins/z/z.sh
else
    echo -e "${RED_TEXT}Oh-my-zsh is not installed!${ORIGIN_TEXT}"
fi

#######################
# Language Environment Settings
#######################
#export LANG=zh_CN.UTF-8
#export LC_ALL=zh_CN.UTF-8

#######################
# Zsh Settings
#######################
unsetopt AUTO_CD

#######################
#  Settings
#######################
#if [ ! -d "$HOME/scripts" ] && hash git;then
#    echo -e "${RED_TEXT}Directory scripts does not exist.${ORIGIN_TEXT}"
#    git clone https://github.com/furrybear/scripts.git "$HOME/scripts"
#fi
#######################
# Machine-Specified Settings
#######################
if [ -d "$HOME/bear-local/zshrc" ]; then
  for i in $HOME/bear-local/zshrc/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
