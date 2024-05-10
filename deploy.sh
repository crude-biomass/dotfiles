#!/bin/bash

BASHRC=true
TMUX=true
NVIM=true

HOME_DIR=$HOME
CONFIG_DIR="$HOME_DIR/.config"

# Text style
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Color codes 
GREEN='\033[1;32m'
BLUE='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NO_COLOR='\033[0'

logo() {
    echo -e "${BOLD}${GREEN}"
    cat << 'EOF'
 __   __  ___       __        _______    _______   ______    _______    _______  ___________  ______     _______
|"  |/  \|  "|     /""\      /"      \  /"     "| /" _  "\  /"     "|  |   __ "\("     _   ")/    " \   /"      \
|'  /    \:  |    /    \    |:        |(: ______)(: ( \___)(: ______)  (. |__) :))__/  \\__/// ____  \ |:        |
|: /'        |   /' /\  \   |_____/   ) \/    |   \/ \      \/    |    |:  ____/    \\_ /  /  /    ) :)|_____/   )
 \//  /\'    |  //  __'  \   //      /  // ___)_  //  \ _   // ___)_   (|  /        |.  | (: (____/ //  //      /
 /   /  \\   | /   /  \\  \ |:  __   \ (:      "|(:   _) \ (:      "| /|__/ \       \:  |  \        /  |:  __   \
|___/    \___|(___/    \___)|__|  \___) \_______) \_______) \_______)(_______)       \__|   \"_____/   |__|  \___)
EOF

    echo -e "${NORMAL}${NO_COLOR}"
}

help_message() {
    echo -e "
${BOLD}Usage:${NORMAL}
    deploy.sh [command]
${BOLD}Commands:${NORMAL}
    ${BOLD}start${NORMAL} - start deploy
    ${BOLD}help${NORMAL} - print this message
    "
}


start_deploy() {
    logo
    
    # Bashrc
    if [ $BASHRC == true ]; then
        echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Copying bashrc ..."
        cp -r configs/.bashrc $HOME_DIR
        echo -e "${BOLD}${GREEN}OK:${NORMAL} Bashrc has been copied!"
    fi

    # Tmux 
    if [ $TMUX == true ]; then
        echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Configuring tmux..."
        if ! command -v tmux &> /dev/null 
        then
            echo -e "${BOLD}${RED}ERROR:${NORMAL} Tmux could not be found!!!"
            exit 1
        fi
        if ! command -v git &> /dev/null 
        then
            echo -e "${BOLD}${RED}ERROR:${NORMAL} Git could not be found!!!"
            exit 1
        fi
        cp configs/.tmux.conf $HOME_DIR
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        tmux new -s config \; detach 
        tmux run-shell "$HOME/.tmux/plugins/tpm/bindings/install_plugins"
        tmux kill-session -t config
        echo -e "${BOLD}${GREEN}OK:${NORMAL} Tmux has been successfully configured!"
    fi

    # Neovim
    if [ $NVIM == true ]; then
        if ! command -v tmux &> /dev/null 
        then
            echo -e "${BOLD}${RED}ERROR:${NORMAL} Tmux could not be found!!!"
            exit 1
        fi
        if ! command -v git &> /dev/null 
        then
            echo -e "${BOLD}${RED}ERROR:${NORMAL} Git could not be found!!!"
            exit 1
        fi
        echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Configuring neovim..."
        cp -r configs/nvim $CONFIG_DIR
        echo -e "${BOLD}${GREEN}OK:${NORMAL} Neovim has been successfully configured!"
    fi
}

case $1 in
    "start")
        start_deploy
        ;;
    "help")
        help_message
        ;;
    *)
        help_message
        ;;
esac

