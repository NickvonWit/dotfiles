#!/bin/bash

#_____________________ Variables _____________________

# Find location of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Check if the script is being run as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run as root."
  exit 1
fi
# Check if the script is being run on a Mac or Linux
if  [ "$(uname)" == "Darwin" ]; then
  echo "Mac OS detected."
  export OS="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "Linux OS detected."
  export OS="linux"
else
  echo "Unsupported OS detected."
  exit 1
fi

# Backup folder
backup_folder="$SCRIPT_DIR/.dotfiles_backup"
if [ ! -d "$backup_folder" ]; then
  echo "Creating backup folder..."
  mkdir -p $backup_folder
fi

#_____________________ Homebrew Configuration _____________________
if [ "$OS" == "mac" ]; then
  # Check if Homebrew is installed
  if [ -z "$(command -v brew)" ]; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed."
  fi
fi

#_____________________ ZSH Configuration _____________________

# Check if zsh is installed
if [ -z "$(command -v zsh)" ]; then
  echo "Zsh is not installed. Please install zsh first."
  if [ "$OS" == "mac" ]; then
    echo "Haha, zsh should be installed. I am very sorry for your Mac."
    echo "Figure out why you do not have zsh and then run this script again."
    echo "Exiting script..."
    exit 1
  elif [ "$OS" == "linux" ]; then
    echo "For Linux, run 'sudo apt install zsh'"
    echo "If you however do not have sudo privileges, I can install zsh for you."
    read -p "Do you want to install zsh with sudo or using .local and linking? [s/l]: " install_zsh
    if [ "$install_zsh" == "s" ]; then
      sudo apt install zsh
    elif [ "$install_zsh" == "l" ]; then
      wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
      mkdir zsh && unxz zsh.tar.xz && tar -xvf zsh.tar -C zsh --strip-components 1
      cd zsh
      mkdir -p $SCRIPT_DIR/.local
      ./configure --prefix=$SCRIPT_DIR/.local
      make && make install
      cd ..
      rm -rf zsh.tar zsh
      mkdir -p $HOME/.local/bin
      ln -sf $SCRIPT_DIR/.local/bin/zsh $HOME/.local/bin/zsh
      touch $HOME/.aliases
      # Check if this is already in the .aliases file
      if ! grep -q "export PATH=\"\$HOME/.local/bin:\$PATH\"" $HOME/.aliases; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.aliases
      fi
    fi
  fi
fi

# Handle .zshrc file
if [ ! -f "$HOME/.zshrc" ]; then
  touch $HOME/.zshrc
else 
  echo "Backing up existing .zshrc file..."
  mv $HOME/.zshrc $backup_folder/.zshrc.bak
  touch $HOME/.zshrc
fi
ln -sf $SCRIPT_DIR/.zshrc $HOME/.zshrc

 # Set zsh as the default shell if it is not already
if [ "${SHELL: -3}" != "zsh" ]; then
  echo "Setting zsh as the default shell..."
  if ! chsh -l | grep -q "$(which zsh)"; then
    echo "zsh is not listed in chsh -l. Please add it manually."
    echo "If I previously installed zsh for you, I can add it for you."
    read -p "Do you want to default zsh the scuffed way? [y/n]: " add_zsh
    if [ "$add_zsh" == "y" ]; then
      mv $HOME/.bash_profile $backup_folder/.bash_profile.bak
      touch $HOME/.bash_profile
      ln -sf $SCRIPT_DIR/cluster/.bash_profile $HOME/.bash_profile
    else
      echo "Exiting script..."
    fi
    exit 1
  fi
  # Check if user has sudo privileges
  echo "If you do not have sudo privileges, I can add zsh for you."
  read -p "Do you want to default zsh the scuffed way? [y/n]: " default_zsh
  if [ "$default_zsh" == "y" ]; then
    mv $HOME/.bash_profile $backup_folder/.bash_profile.bak
    touch $HOME/.bash_profile
    ln -sf $SCRIPT_DIR/cluster/.bash_profile $HOME/.bash_profile
  else
    chsh -s $(which zsh)
  fi
else
  echo "zsh is already the default shell."
fi

echo "Zsh configuration complete. For system specific aliases, create a .aliases file in home."

#__________________ Oh-my-zsh Configuration ___________________

# Check if oh-my-zsh is installed 
omz="$HOME/.oh-my-zsh"
if [ ! -d "$omz" ]; then
  echo "Installing oh-my-zsh..."
  wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
  CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh install.sh
  rm install.sh
else
  echo "oh-my-zsh is already installed."
fi

# Check if powerlevel10k is installed
p10k="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [ ! -d "$p10k" ]; then
  echo "Installing powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
  echo "powerlevel10k is already installed."
fi
if [ ! -f "$HOME/.p10k.zsh" ]; then
  touch $HOME/.p10k.zsh
else
  echo "Backing up existing .p10k.zsh file..."
  mv $HOME/.p10k.zsh $backup_folder/.p10k.zsh.bak
  touch $HOME/.p10k.zsh
fi
ln -sf $SCRIPT_DIR/.p10k.zsh $HOME/.p10k.zsh

# Check if zsh-syntax-highlighting is installed
zsh_syntax="$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
if [ ! -d "$zsh_syntax" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax_highlighting is already installed."
fi

# Check if zsh-autosuggestions is installed
zsh_autosuggestions="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
if [ ! -d "$zsh_autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
 echo "zs-autosuggestions is already installed."
fi

# Check if fzf is installed
if [ "$OS" == "mac" ]; then
  if [ -z "$(command -v fzf)" ]; then
    echo "Installing fzf..."
    brew install fzf
  else
    echo "fzf is already installed."
  fi
elif [ "$OS" == "linux" ]; then
  if [ ! -d "$HOME/.fzf" ]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    echo "source $HOME/.fzf.zsh" >> $HOME/.aliases
  else
    echo "fzf is already installed."
  fi
fi
#_____________________ Git Configuration _____________________

# Check if git is installed
if [ -z "$(command -v git)" ]; then
  echo "Git is not installed. Please install git first."
  exit 1
fi
if [ ! -d "$HOME/.config/git" ]; then
  echo "Creating git config directory..."
  mkdir -p $HOME/.config/git
fi
if [ ! -f "$HOME/.config/git/config" ]; then
  echo "Creating git config file..."
  touch $HOME/.config/git/config
else
  echo "Backing up existing git config file..."
  mv $HOME/.config/git/config $backup_folder/gitconfig.bak
  touch $HOME/.config/git/config
fi
ln -sf $SCRIPT_DIR/.config/git/config $HOME/.config/git/config

#_____________________ Vim Configuration _____________________

# Check if vim is installed
if [ -z "$(command -v vim)" ]; then
  echo "Vim is not installed. Please install vim first."
  exit 1
else
  mv $HOME/.vimrc $backup_folder/.vimrc.bak
  touch $HOME/.vimrc
  ln -sf $SCRIPT_DIR/.vimrc $HOME/.vimrc
fi