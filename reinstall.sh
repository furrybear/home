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
query_user(){
    printf "Do you want to ${YELLOW_TEXT}$1${ORIGIN_TEXT}? [Y/n]\n" 
    read -r input

    case $input in
        [yY][eE][sS]|[yY])
            printf "The user input is ${GREEN_TEXT}yes${ORIGIN_TEXT} for \"${YELLOW_TEXT}$1${ORIGIN_TEXT}.\"\n"
            return 0
            ;;
        [nN][oO]|[nN])
            printf "The user input is ${RED_TEXT}no${ORIGIN_TEXT} for \"${YELLOW_TEXT}$1${ORIGIN_TEXT}.\"\n"
            return 1
            ;;
        *)
            printf "${RED_TEXT}Invalid input...${ORIGIN_TEXT}\n"
            return 1
            ;;
    esac 
}
get_distro_name()
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
install_vim(){
    if ! command -v vim > /dev/null 2>&1;then
        if query_user "install vim";then
            sudo $PM install -y vim 
        fi
    fi
}
install_git(){
    if ! command -v git > /dev/null 2>&1;then
        if query_user "install git";then
            sudo $PM install -y git 
        fi
    fi
}
install_zsh(){
    if ! command -v zsh > /dev/null 2>&1;then
        if query_user "install zsh";then
            sudo $PM install -y zsh 
        fi
    fi
}
clone_oh_my_zsh(){
    if [ ! -d "$HOME/.oh-my-zsh" ];then
        if query_user "clone oh-my-zsh to local";then
            git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
        fi
    fi
}
install_trash_cli(){
    if ! command -v trash-put > /dev/null 2>&1;then
        if query_user "install trash-cli";then
            [ $PM = "yum" ] && sudo yum install -y epel-release && sudo yum install -y python-pip && sudo python -m pip install trash-cli
            [ $DISTRO = "Ubuntu" ] && sudo apt install -y trash-cli
        fi
    fi
}
install_tmux(){
    if ! command -v tmux > /dev/null 2>&1;then
        if query_user "install tmux";then
            sudo $PM install -y tmux
        fi
    fi
}
install_docker(){
    if ! command -v docker > /dev/null 2>&1;then
        if query_user "install docker";then
            if [ $PM = "yum" ];then
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

change_default_shell(){
    if command -v zsh > /dev/null 2>&1 && [ -d "$HOME/.oh-my-zsh" ];then
        if query_user "change default shell to zsh";then
            sudo chsh -s $(which zsh) $USER
        fi
    fi
}
#----------------------
# Main.
#----------------------
get_distro_name
if [ $DISTRO = "unknown" ];then echo "Unknown distribution!";exit 1;fi

install_vim
install_git
install_zsh
clone_oh_my_zsh
install_trash_cli
install_tmux
install_docker
change_default_shell
printf "${CYAN_TEXT}Done!${ORIGIN_TEXT}\n"
