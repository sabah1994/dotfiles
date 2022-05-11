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

install_vim(){
    echo "==================================="
    echo "Installing neovim and nodeJS"
    echo "==================================="
    $1 install neovim >&-
    $1 install nodejs >&-

}

install_tmux(){
    echo "==================================="
    echo "Installing tmux" 
    echo "==================================="
    $1 install tmux >&-
}
setup_tmux() {
    echo "==================================="
    echo "Linking tmux config"
    echo "==================================="

    cd ~/

    touch ~/.tmux.conf
    ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
}
install_misc(){
    echo "==================================="
    echo "installing misc"
    echo "==================================="
    $1 install git 
}

clone_dot_files(){
    cd ~
    git clone https://github.com/sabah1994/dotfiles.git
}
setup_vim(){
    echo "==================================="
    echo "Downlading plug manager"
    echo "==================================="

    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

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
install_vim "$install_prefix"
setup_vim
install_tmux "$install_prefix"
setup_tmux
install_misc "$install_prefix"
