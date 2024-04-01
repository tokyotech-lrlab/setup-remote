# Description: Setup bash environment

# config files

echo "Install config files ==========>"

CUR_DIR="$(
   cd $(dirname $0)
   pwd
)"

# .bashrc (overwrite)
if [ -f ~/.bashrc ]; then
   mv ~/.bashrc ~/.bashrc.old
fi

echo "ln -nfs $CUR_DIR/files/.bashrc ~/"
ln -nfs $CUR_DIR/files/.bashrc ~/

# .tmux.conf
if [ ! -f ~/.tmux.conf ]; then
   echo "ln -nfs $CUR_DIR/files/.tmux.conf ~/"
   ln -nfs $CUR_DIR/files/.tmux.conf ~/
fi

# .bash_aliases
if [ ! -f ~/.bash_aliases ]; then
   echo "ln -nfs $CUR_DIR/files/.bash_aliases ~/"
   ln -nfs $CUR_DIR/files/.bash_aliases ~/
fi

echo "====================> Done!!"

# pyenv

echo "Install pyenv ==========>"

if !(type pyenv > /dev/null 2>&1); then
   # install from source
   git clone https://github.com/pyenv/pyenv.git ~/.pyenv

else
   echo "pyenv is already installed."
fi

# add path to .bashrc
echo '
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"' >>~/.bashrc

source ~/.bashrc

echo "====================> Done!!"

# anaconda

echo "Install anaconda ==========>"

if !(type conda > /dev/null 2>&1); then
   CONDA_VERSION=$(pyenv install -l | grep anaconda | tail -n 1 | sed 's/^ *\| *$//')
   echo Install $CONDA_VERSION
   pyenv install $CONDA_VERSION

else
   CONDA_VERSION=$(ls -1 ~/.pyenv/versions | head -n1)
   echo "$CONDA_VERSION is already installed."
fi

echo "
# anaconda
export CONDA_PATH=\${HOME}/.pyenv/versions/${CONDA_VERSION}
source \${CONDA_PATH}/etc/profile.d/conda.sh
export PATH=\"\$CONDA_PATH/bin:\$PATH\"" >>~/.bashrc

echo "===================> Done!!"

# github ssh-key

echo "Install github ssh-key ==========>"

if [ ! -f ~/.ssh/id_ed25519 ]; then
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C ""

   echo "Host github.com
         User git
         Port 22
         HostName github.com
         IdentityFile ~/.ssh/id_ed25519" >~/.ssh/config

else
   echo "github ssh-key already exists."
fi

echo "~/.ssh/id_ed25519.pub: "
cat ~/.ssh/id_ed25519.pub
echo visit https://github.com/settings/ssh/new to add this ssh-key

echo "=========================> Done!!"

echo "Reload bash with following command:
$ source ~/.bashrc
"
