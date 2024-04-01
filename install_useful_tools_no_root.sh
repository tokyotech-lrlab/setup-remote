# Description: Install useful tools with linuxbrew

# linuxbrew

CUR_DIR=$(
    cd $(dirname $0)
    pwd
)

bash $CUR_DIR/install_linuxbrew.sh

# reload bash
exec -l $SHELL

# check linuxbrew
if !(type brew > /dev/null 2>&1); then
    echo "Some problems have occured when installing linuxbrew."
    exit 1
fi

# fzf

echo "Install fzf ==========>"

if !(type fzf >/dev/null 2>&1); then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    echo "export FZF_DEFAULT_OPTS='--height 40% --reverse --border'" >>~/.bashrc
fi
echo "===============> Done!!"

# exa
echo "Install exa ==========>"
if !(type exa >/dev/null 2>&1); then
    brew install exa

    echo '
# exa colors
export EXA_COLORS="uu=37:da=38;5;081"
' >>~/.bashrc
fi
echo "===============> Done!!"

# bat
echo "Install bat ==========>"
if !(type bat >/dev/null 2>&1); then
    brew install bat
fi
echo "===============> Done!!"

# dust
echo "Install dust ==========>"
if !(type dust >/dev/null 2>&1); then
    brew install dust
fi
echo "===============> Done!!"

# reload bash
exec -l $SHELL
