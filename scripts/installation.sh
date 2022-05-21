#!/bin/bash
what_os(){
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
    echo "$machine"
}

install_homebrew(){
    which -s brew
    if [[ $? != 0 ]] ; then
        echo "==================================="
        echo "Installing Homebrew"
        echo "==================================="
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

install_packages(){
    echo "==================================="
    echo "Installing Packages"
    echo "neovim"
    echo "nodejs"
    echo "tmux"
    echo git
    echo "==================================="
    $1 install neovim
    $1 install nodejs
    $1 install tmux
    # $1 install git
}

setup_tmux() {
    echo "==================================="
    echo "Linking tmux config"
    echo "==================================="

    if [ "$machine" == "Mac" ]
    then
        echo "Installing reattach-to-user-namespace"
        brew install reattach-to-user-namespace
    fi
    cd ~/

    touch ~/.tmux.conf
    ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
}

clone_dot_files(){
    rm -rf ~/dotfiles
    cd ~
    git clone git@github.com:sabah1994/dotfiles.git
}
setup_vim(){
    echo "==================================="
    echo "Downlading plug manager"
    echo "==================================="
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    echo "==================================="
    echo "Create python3 venv with necessary pacakges"
    echo "==================================="
    rm -rf ~/vim_venv
    python3 -m venv ~/vim_venv
    source ~/vim_venv/bin/activate
    pip install black neovim

    echo "==================================="
    echo "Creating Symlinks for Vim"
    echo "==================================="
    mkdir -p ~/.config/nvim/plug-config
    ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
    ln -sf ~/dotfiles/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
    ln -sf ~/dotfiles/nvim/plug-config/coc.vim ~/.config/nvim/plug-config/coc.vim
    
    echo "==================================="
    echo "Vim and neovim setup complete"
    echo "Once this process is complete open vim and run :PlugInstall"
    echo "==================================="
}

install_zsh() {
    echo "==================================="
    echo "Installing oh-my-zsh"
    echo "==================================="
    # remove exissting and download oh-my-zsh
    rm -rf ~/.oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &

    echo "==================================="
    echo "Executing rest of zsh related setup "
    echo "==================================="
    # Link .zshrc file
    ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
    # auto suggestion plugin
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # fzf download and setup
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # set font for terminal
    # preserve powerlevel10k dotfile
    # version control zshrc
}

machine=$(what_os)
if [ "$machine" == "Mac" ]
then
    echo "Machine Identifies as Mac"
    install_homebrew
    install_prefix="brew "
elif [[ "$machine" == "Linux" ]]; then
    echo "Machine Identified as Linux"
    install_prefix="sudo apt "
else
    echo "Machine not identified, exiting"
    exit 1
fi


clone_dot_files
install_packages "$install_prefix"
setup_vim
setup_tmux
install_zsh
