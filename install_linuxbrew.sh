# Description: Install Linuxbrew

echo "Install Linuxbrew ==========>"

if !(type brew > /dev/null 2>&1); then

   if [ ! -d ~/.linuxbrew ]; then
      echo "Install Linuxbrew from source"
      git clone https://github.com/Homebrew/brew ~/.linuxbrew
   fi

   eval "$(~/.linuxbrew/bin/brew shellenv)"
   brew update --force --quiet
   chmod -R go-w "$(brew --prefix)/share/zsh"

   echo '
# linuxbrew
export PATH="${HOME}/.linuxbrew/bin:$PATH"' >>~/.bashrc
   source ~/.bashrc

else

   echo "Linuxbrew is already installed."

fi

# check linuxbrew
if !(type brew > /dev/null 2>&1); then
   echo "Some problems have occured"
   exit 1
fi

echo "====================> Done!!"
