# Setup Remote Server

## Usage

1. Clone this repository

   ```
   git clone https://github.com/tokyotech-lrlab/setup-remote.git
   ```

2. Setup base packages (pyenv, conda, ssh-key for github)
   ```
   bash setup-remote/setup_bash.sh
   source ~/.bashrc
   ```
3. Install linuxbrew

   ```
   bash setup-remote/install_linuxbrew.sh
   source ~/.bashrc
   ```

4. Install useful command line tools (fzf, eza, bat, dust)
   ```
   bash setup-remote/install_useful_tools.sh
   ```
