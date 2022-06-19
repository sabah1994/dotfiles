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
    brew install reattach-to-user-namespace
}

install_packages(){
    echo "==================================="
    echo "Installing Packages"
    echo "neovim"
    echo "nodejs"
    echo "tmux"
    echo "git"
    echo "ripgrep"
    echo "==================================="
    $1 install neovim
    $1 install nodejs
    $1 install tmux
    $1 install git
    $1 install ripgrep
    sudo npm -g install tree-sitter-cli
    sudo npm -g install tree-sitter
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
    ln -s ~/dotfiles/nvim ~/.config/nvim

    echo "==================================="
    echo "Vim and neovim setup complete"
    echo "Once this process is complete open vim and run :PlugInstall"
    echo "==================================="
}

install_zsh() {
    echo "==================================="
    echo "Installing oh-my-zsh"
    echo "WARNING: if oh-my-zsh is not installed, this script will end here. Simply run this script again"
    sleep 5
    rm -rf ~/.oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
    echo "WAITING FOR oh-my-zsh to finish installing"
    sleep 15

    echo "==================================="
    echo "Executing rest of zsh related setup "
    echo "==================================="
    # Link .zshrc file
    ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
    # auto suggestion plugin
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # fzf download and setup
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install

    #fzf-tab (replaces zsh default tab completion with fuzzy finder)
    git clone https://github.com/Aloxaf/fzf-tab.git ~/.fzf-tab
    #sourced in ~/.zshrc

    # set font for terminal
}

download_and_setup_powerleveltheme(){
    echo "==================================="
    echo "installing and seting up P10k theme"
    echo "==================================="
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    ln -sf ~/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
}

install_font(){
    if [ "$1" == "Linux" ]
    then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
        echo "==================================="
        echo "JetBrains Mono font installed, Set it in terminal preference"
        echo "==================================="
        return
    fi
    echo "==================================="
    echo "Please visit https://www.jetbrains.com/lp/mono/ and install the font"
    echo "==================================="
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
download_and_setup_powerleveltheme
install_font $machine
