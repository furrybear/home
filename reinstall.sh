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
function get_distro_name()
{
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    else
        DISTRO='unknow'
    fi
}
#----------------------
# Functional functions.
#----------------------
function install_zsh(){
    if ! command -v zsh > /dev/null 2>&1;then
        if query_user "install zsh";then
            sudo $PM install -y zsh 
        fi
    fi
}
function install_git(){
    if ! command -v git > /dev/null 2>&1;then
        if query_user "install git";then
            sudo $PM install -y git 
        fi
    fi
}
function clone_oh_my_zsh(){
    if [ ! -d "$HOME/.oh-my-zsh" ];then
        if query_user "clone oh-my-zsh to local";then
            git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
        fi
    fi
}
function install_trash_cli(){
    if ! command -v trash-put > /dev/null 2>&1;then
        if query_user "install trash-cli";then
            [ $PM -eq "yum" ] && sudo $PM install -y epel-release
            sudo $PM install -y python-pip
            sudo python -m pip install trash-cli
        fi
    fi
}
function install_tmux(){
    if ! command -v tmux > /dev/null 2>&1;then
        if query_user "install tmux";then
            sudo $PM install -y tmux
        fi
    fi
}
function install_docker(){
    if ! command -v docker > /dev/null 2>&1;then
        if query_user "install docker";then
            if [ $PM == "yum" ];then
                sudo yum install -y yum-utils
                sudo yum-config-manager \
                    --add-repo \
                        https://download.docker.com/linux/centos/docker-ce.repo
                sudo yum install -y docker-ce docker-ce-cli containerd.io
                sudo usermod -a -G docker $USER
            else
                echo "Package Manager $PM is not supported now."
            fi
        fi
    fi
}

function change_default_shell(){
    if command -v zsh > /dev/null 2>&1 && [ ! -d "$HOME/.oh-my-zsh" ];then
        if query_user "change default shell to zsh";then
            sudo chsh -s $(which zsh) $USER
        fi
    fi
}
#----------------------
# Main.
#----------------------
get_distro_name
if [ $DISTRO == "unknown" ];then echo "Unknown distribution!";exit 1;fi

install_git
install_zsh
clone_oh_my_zsh
install_trash_cli
install_tmux
install_docker
change_default_shell
echo -e "${CYAN_TEXT}Done!${ORIGIN_TEXT}"
