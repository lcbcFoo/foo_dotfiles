#!/bin/bash

ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question
    read -p "$1 [$prompt] " REPLY

    # Default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}


# Check dir
dir=`pwd`
if [ ! -e "${dir}/$(basename $0)" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."
cd ../

# Base and pikaur
ask "Install base packages and pikaur?" Y && {
    
    # Update
    echo "Updating pacman"
    sudo pacman -Syyuu

    # Base 
    echo "Installing base, base-devel, git, python"
    sudo pacman -S base base-devel git python --needed --noconfirm

    echo "Changing to linux-lts"
    sudo pacman -S linux-lts --needed --noconfirm
    sudo pacman -R linux

    # Pikaur 
    echo "Installing pikaur"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/pikaur.git
    cd pikaur
    makepkg -fsri
    cd ../
    rm pikaur -rf

    echo "Installing other basic packages"
    pikaur --noconfirm --needed curl grub networkmanager network-manager-applet dhclient
    sudo cp networkmanager_conf/dhcp-client.conf /etc/NetworkManager/conf.d/dhcp-client.conf 
}

# SDDM and Cinnamon
ask "Install SDDM and cinnamon stuff?" Y && {
    
    # Base 
    echo "Installing SDDM"
    sudo pacman -S sddm sddm-config-editor-git sddm-theme-gracilis-git --needed --noconfirm

    # Base 
    echo "Installing Cinnamon"
    sudo pacman -S cinnamon --needed --noconfirm
}

# Optional packages
ask "Install optional packages?" Y && {
    
    echo "Installing listed optional packages"
    pikaur -S --needed --noconfirm \
        vim terminator powerline powerline-fonts-git chromium pavucontrol \
        python-virtualenv python-pip python-setuptools python-wheel

}


ask "Install symlink for .vimrc?" Y && {
    ln -sfn ${dir}/vim/.vimrc ${HOME}/.vimrc 
    mkdir ${HOME}/.vim
    mkdir ${HOME}/.vim/bundle

    ask "Install vundle and vim plugins now? (will install clang package)" Y && {
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        echo "Installing vim plugins"
        vim a.txt -c "PluginInstall" -c "q" -c "q"
        
        # YCM plugin
        sudo pacman -S clang --needed --noconfirm

        cd $HOME/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer --system-libclang --quiet
        cd $dir
        cp YCM/ycm_extra_conf.py $HOME/.ycm_extra_conf.py
    }
}


ask "Install base16 shell (for shell colors and themes)?" Y && {
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
}

ask "Install and configure oh-my-zsh?" Y && {
    rm $HOME/.oh-my-zsh -rf
    mv $HOME/.zshrc $HOME/.zshrc_local
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ln -sfn ${dir}/zsh/.zshrc ${HOME}/.zshrc 
}

cd setup
echo "Done!"

