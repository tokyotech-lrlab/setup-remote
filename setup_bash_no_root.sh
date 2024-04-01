# setup_bash_no_root.sh

USERNAME=$(whoami)

# linuxbrew

echo "########## Install Linuxbrew ##########"

git clone https://github.com/Homebrew/brew homebrew

eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"

# pyenv

echo "########## Install pyenv ##########"

if [ ! -d ~/.pyenv ]; then
   git clone https://github.com/pyenv/pyenv.git ~/.pyenv

   export PYENV_ROOT="$HOME/.pyenv"
   command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
   eval "$(pyenv init -)"

   echo '
   # pyenv
   export PYENV_ROOT="$HOME/.pyenv"
   command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
   eval "$(pyenv init -)"' >>~/.bashrc

fi

# config files

echo "########## Setup config files ##########"

CUR_DIR="$(
   cd $(dirname $0)
   pwd
)"

if [ ! -f ~/.bashrc ]; then
   mv ~/.bashrc ~/.bashrc.old
   echo "ln -nfs $CUR_DIR/files/.bashrc ~/"
   ln -nfs $CUR_DIR/files/.bashrc ~/
fi

if [ ! -f ~/.tmux.conf ]; then
   echo "ln -nfs $CUR_DIR/files/.tmux.conf ~/"
   ln -nfs $CUR_DIR/files/.tmux.conf ~/
fi

if [ ! -f ~/.bash_aliases ]; then
   echo "ln -nfs $CUR_DIR/files/.bash_aliases ~/"
   ln -nfs $CUR_DIR/files/.bash_aliases ~/
fi

# anaconda

echo "########## Install anaconda ##########"

if [ -z "$(which conda)" ]; then
   CONDA_VERSION=$(pyenv install -l | grep anaconda | tail -n 1 | sed 's/^ *\| *$//')
   echo Install $CONDA_VERSION
   pyenv install $CONDA_VERSION

   echo "
   # anaconda
   export CONDA_PATH=${HOME}/.pyenv/versions/${CONDA_VERSION}
   source \${CONDA_PATH}/etc/profile.d/conda.sh
   export PATH=\"\$CONDA_PATH/bin:\$PATH\"" >>~/.bashrc
fi

# fzf

echo "########## Install fzf ##########"

if [ -z "$(which fzf)" ]; then
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install

   echo "export FZF_DEFAULT_OPTS='--height 40% --reverse --border'" >>~/.bashrc
fi

echo "########## Install github ssh-key ##########"

if [ ! -f ~/.ssh/id_ed25519 ]; then
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C ""

   echo "Host github.com
         User git
         Port 22
         HostName github.com
         IdentityFile ~/.ssh/id_ed25519" >~/.ssh/config
fi

echo "~/.ssh/id_ed25519.pub: "
cat ~/.ssh/id_ed25519.pub
echo visit https://github.com/settings/ssh/new to add this ssh-key
