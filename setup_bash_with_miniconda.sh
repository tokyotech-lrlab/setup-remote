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

# anaconda

echo "Install miniconda ==========>"

if !(type conda > /dev/null 2>&1); then
   mkdir -p ~/miniconda3
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
   bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
   rm -rf ~/miniconda3/miniconda.sh
fi

source ~/.bashrc
conda config --set auto_activate_base False
source ~/.bashrc

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
