linux_install_vim(){
    echo "==================================="
    echo "Installing neovim and nodeJS"
    echo "==================================="
    sudo apt install neovim >&-
    sudo apt install nodejs >&-

}

linux_install_tmux(){
    echo "==================================="
    echo "Installing tmux" 
    echo "==================================="
    sudo apt install tmux >&-
}

linux_install_misc(){
    echo "==================================="
    echo "installing misc"
    echo "==================================="
    sudo apt install git >&-
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

clone_dot_files
linux_install_vim
setup_vim
# linux_install_tmux
# linux_install_misc
