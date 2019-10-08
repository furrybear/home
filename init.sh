#!/bin/sh
##################################
# Function: Some initialization functions.
# Author: Furrybear<fbcll@outlook.com>
##################################

#----------------------
# Some global variable.
#----------------------
RED_TEXT='\033[31m'
YELLOW_TEXT='\033[33m'
CYAN_TEXT='\033[36m'
GREEN_TEXT='\033[32m'
ORIGIN_TEXT='\033[0m'

#----------------------
# Tool functions.
#----------------------
function query_user(){
    echo -e "Do you want to ${YELLOW_TEXT}$1${ORIGIN_TEXT}? [Y/n] " 
    read -r input

    case $input in
        [yY][eE][sS]|[yY])
            echo -e "The user input is ${GREEN_TEXT}yes${ORIGIN_TEXT} for \"${YELLOW_TEXT}$1${ORIGIN_TEXT}.\""
            return 0
            ;;
        [nN][oO]|[nN])
            echo -e "The user input is ${RED_TEXT}no${ORIGIN_TEXT} for \"${YELLOW_TEXT}$1${ORIGIN_TEXT}.\""
            return 1
            ;;
        *)
            echo "${RED_TEXT}Invalid input...${ORIGIN_TEXT}"
            return 1
            ;;
    esac 
}
#----------------------
# Functional functions.
#----------------------
function clone_oh_my_zsh(){
    if [ ! -d "$HOME/.oh-my-zsh" ];then
        query_user "clone oh-my-zsh to local" &&
        git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
    fi
}
function clone_submodule(){
   git submodule update --init --recursive 
}
function install_trash_cli(){
    if ! command -v trash-put > /dev/null 2>&1;then
        query_user "install trash-cli" &&
        pip3 install trash-cli
    fi
}
function install_tmux(){
    if ! command -v tmux > /dev/null 2>&1;then
        query_user "install tmux" &&
        yum install -y tmux
    fi
}
#----------------------
# Main.
#----------------------
clone_oh_my_zsh
clone_submodule
install_trash_cli
install_tmux
echo -e "${CYAN_TEXT}Done!${ORIGIN_TEXT}"
