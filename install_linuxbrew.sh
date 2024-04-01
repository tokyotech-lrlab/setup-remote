# Description: Install Linuxbrew

echo "Install Linuxbrew ==========>"

if [ -z "$(which brew)" ]; then

   if [ ! -d ~/.linuxbrew ]; then
      echo "Install Linuxbrew from source"
      git clone https://github.com/Homebrew/brew ~/.linuxbrew
   fi

   eval "$(~/.linuxbrew/bin/brew shellenv)"
   brew update --force --quiet
   chmod -R go-w "$(brew --prefix)/share/zsh"

else

   echo "Linuxbrew is already installed."

fi

echo "====================> Done!!"
