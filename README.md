# Setup Remote Server

This repository contains scripts for setting up a remote server for research purpose. The scripts install essential packages and useful tools for NLP research, such as miniconda, linuxbrew, and fzf.

- [Setup](#setup)
- [Usage](#usage)
  - [Python Environment](#python-environment)
  - [Tmux](#tmux-terminal-multiplexer)
  - [fzf](#fzf)

## Setup

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

1. Simple usage (venv)

   ```
   # Create a new python environment
   cd ~/{project directory}
   python -m venv myenv
   source myenv/bin/activate

   # Install packages
   pip install {packages}=={version}
   ```

2. Use miniconda

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

- Essential usages (using original aliases see `files/.bash_aliases`):

  ```
  # Create a new session (`tmux new-session`)
  cd ~/{project directory}
  tn

  # See all sessions (`tmux list-sessions`)
  tl

  # Attach to a session (`tmux attach-session`)
  ta -t {session name or number}
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

### fzf

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
   ╭─────────────────────────────────────────────────────────────────────╮
   │ > conda                                                             │
   │   365/2133 +S ───────────────────────────────────────────────────── │
   │ > 4893    conda activate DatasetDistillation                       ││
   │   4475    conda deactivate                                          │
   │   4473    conda activate RSTParsingWithLLM                          │
   │   4320    conda activate                                            │
   │   3506    conda install -c conda-forge faiss-gpu                    │
   │   3391    conda install -c pytorch -c nvidia faiss-gpu=1.8.0        │
   │   3383    conda --version                                           │
   │   3104    which conda                                               │
   │   3094    conda install python=3.10                                 │
   │   3093    conda activate base                                       │
   ╰─────────────────────────────────────────────────────────────────────╯
  ```

- Search files with `fzf` or `CTRL + t` (default keybinding).

  ```
  amaekawa@gpu01:~/dataset-distillation-with-summarization(develop*)$ (CTRL + t)
   ╭─────────────────────────────────────────────────────────────────────────╮
   │ > dataset                                                               │
   │   52/4263 ───────────────────────────────────────────────────────────── │
   │ > src/data/dataset.py                                                  ││
   │   src/data/__pycache__/dataset.cpython-310.pyc                         ││
   │   src/data/raw_dataset.py                                              ││
   │   src/preprocess_dataset.py                                            ││
   │   src/generate_dataset.py                                          ││
   │   src/generate_dataset_parallel.py                             ││
   │   src/data/__pycache__/raw_dataset.cpython-310.pyc                      │
   ╰─────────────────────────────────────────────────────────────────────────╯
  ```
