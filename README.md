# Setup Remote Server

This repository contains scripts for setting up a remote server for research purpose. The scripts install essential packages and useful tools for NLP research, such as miniconda, linuxbrew, and fzf.

- [SSH Key Setup](#basic-ssh-key-setup)
- [Setup Scripts](#setup-scripts)
- [Usages](#usages)
  - [Python Environment](#python-environment)
  - [Tmux (terminal multiplexer)](#tmux-terminal-multiplexer)
  - [Useful command-line tools](#useful-command-line-tools)
    - [fzf](#fzf)
    - [eza](#eza)
    - [bat](#bat)
    - [dust](#dust)

## SSH Key Setup

1. Generate a new SSH key if you don't have one (@LOCAL MACHINE)

   ```
   ssh-keygen -t ed25519 -C ""  # Enter a passphrase if you want
   cat ~/.ssh/id_ed25519.pub  # Copy the public key
   ```

2. Copy the public key to the remote server (@REMOTE MACHINE)

   ```
   mkdir -p ~/.ssh
   chmod 700 ~/.ssh
   echo '{public key}' >> ~/.ssh/authorized_keys"
   chmod 600 ~/.ssh/authorized_keys
   exit
   ```

3. Add following SSH config to `~/.ssh/config` (@LOCAL MACHINE)

   ```
   Host {Hostname (Nickname)}
       HostName {IPAddress or DomainName}
       User {Username}
       ForwardAgent yes
       IdentityFile ~/.ssh/id_ed25519
   ```

4. Test to login without password

   ```
   ssh {hostname}
   ```

## Setup Scripts

1. Clone this repository

   ```
   git clone https://github.com/tokyotech-lrlab/setup-remote.git
   ```

2. Setup base packages (miniconda, ssh-key for github)

   ```
   bash setup-remote/setup_bash_with_miniconda.sh
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
   source ~/.bashrc
   ```

## Usages

### Python Environment

Option-1: Simple usage (venv)

```
# Create a new python environment
cd ~/{project directory}
python -m venv myenv
source myenv/bin/activate

# Install packages
pip install {packages}=={version}
```

Option-2: Use miniconda (if you want to switch python versions or use conda packages)

```
# Create a new python environment
conda create -n myenv python=3.12
conda activate myenv

# Install packages with pip (basically using pip only)
pip install {packages}=={version}

# Use conda to install if install with pip doesn't work
conda install -c conda-forge faiss-gpu # for example
```

### Tmux (terminal multiplexer)

See docs: https://github.com/tmux/tmux/wiki/Getting-Started

- Essential usages (using customized aliases in `files/.bash_aliases`):

  ```
  # Create a new session
  cd ~/{project directory}
  tn  # alias for `tmux new-session`

  # See all sessions
  tl  # alias for `tmux list-sessions`

  # Attach to a session
  ta -t {session name or number}  # alias for `tmux attach-session`
  ```

- Command for tmux (default prefix is `Ctrl + b`):

  ```
  # Pane operations
  {prefix} + "  # Split the current pane horizontally
  {prefix} + %  # Split the current pane vertically
  {prefix} + {cursor key}  # Move to the next pane
  SHIFT + {cursor key}  # Same as above
  {prefix} + hjkl  # Resize the current pane
  {prefix} + \{  # Swap the current pane with the previous pane
  {prefix} + \}  # Swap the current pane with the next pane

  # Window operations
  {prefix} + c  # Create a new window
  {prefix} + n  # Move to the next window
  {prefix} + p  # Move to the previous window

  # Session operations
  {prefix} + d  # Detach from the current session
  {prefix} + s  # List all sessions and select one to attach
  ```

### Useful command-line tools

Install by running `install_useful_tools.sh`

#### fzf

fzf is a general-purpose command-line fuzzy finder. It is useful for searching file/directory, logs, and command history.

- Example usages

  ```
  # Search logs
  sudo cat /var/log/syslog | fzf

  # Search library versions
  pip list | fzf
  ```

- Search command history with `CTRL + r` (you can use it while typing command).

  ```
  amaekawa@gpu01:~/dataset-distillation-with-summarization(develop*)$ (CTRL + r)
   ╭───────────────────────────────────────────────────────────────────────────╮
   │ > conda                                                                   │
   │   365/2133 +S ─────────────────────────────────────────────────────────── │
   │ > 4893    conda activate DatasetDistillation                              │
   │   4475    conda deactivate                                                │
   │   4473    conda activate RSTParsingWithLLM                                │
   │   4320    conda activate                                                  │
   │   3506    conda install -c conda-forge faiss-gpu                          │
   │   3391    conda install -c pytorch -c nvidia faiss-gpu=1.8.0              │
   │   3383    conda --version                                                 │
   │   3104    which conda                                                     │
   │   3094    conda install python=3.10                                       │
   │   3093    conda activate base                                             │
   ╰───────────────────────────────────────────────────────────────────────────╯
  ```

- Search files with `fzf` or `CTRL + t` (default keybinding).

  ```
  amaekawa@gpu01:~/dataset-distillation-with-summarization(develop*)$ (CTRL + t)
   ╭───────────────────────────────────────────────────────────────────────────╮
   │ > dataset                                                                 │
   │   52/4263 ─────────────────────────────────────────────────────────────── │
   │ > src/data/dataset.py                                                     │
   │   src/data/__pycache__/dataset.cpython-310.pyc                            │
   │   src/data/raw_dataset.py                                                 │
   │   src/preprocess_dataset.py                                               │
   │   src/generate_dataset.py                                                 │
   │   src/generate_dataset_parallel.py                                        │
   │   src/data/__pycache__/raw_dataset.cpython-310.pyc                        │
   ╰───────────────────────────────────────────────────────────────────────────╯
  ```

#### eza

eza is a modern, maintained replacement for the venerable file-listing command-line program `ls`.

- Example usages (see aliases in `files/.bash_aliases`)

  | Command            | Description                                                  |
  | ------------------ | ------------------------------------------------------------ |
  | `ll`,              | List files in directory (alternative to `ls -l`)             |
  | `la`               | List all files in directory (alternative to `ls -a`)         |
  | `lt`, `lt2`, `lt3` | List files in directory recursively (alternative to `ls -R`) |

#### bat

bat is a modern replacement for `cat` command. It provides syntax highlighting and git integration.

- Example usages (use instead of `cat` command)

  ```
  bat {filename}
  ```

#### dust

dust is a more intuitive version of `du` command. It provides a tree-like view of disk usage.

- Example usages

  ```
  dust .  # Show disk usage of the current directory
  dust -d 1 {dir path}  # Show disk usage with depth 1
  ```
