
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
    # Check which package manager is being used
    if [ -n "$(command -v apt)" ]; then
        echo "Using apt package manager."
        export PKG_MANAGER="apt"
    elif [ -n "$(command -v yum)" ]; then
        echo "Using yum package manager."
        export PKG_MANAGER="yum"
    elif [ -n "$(command -v dnf)" ]; then
        echo "Using dnf package manager."
        export PKG_MANAGER="dnf"
    else
        echo "Unsupported package manager detected."
        exit 1
    fi
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

#_____________________ Install Dependencies _____________________

# Install GNU Stow
install_stow() {
    if [ -z "$(command -v stow)" ]; then
        echo "GNU Stow is not installed. Installing GNU Stow..."
        if [ "$OS" == "mac" ]; then
            brew install stow
        elif [ "$OS" == "linux" ]; then
            sudo $PKG_MANAGER install stow -y
        fi
    else
        echo "GNU Stow is already installed."
    fi
}

# Install package with appropriate package manager
install_package() {
    local package=$1
    if [ -z "$(command -v $package)" ]; then
        echo "$package is not installed. Installing $package..."
        if [ "$OS" == "mac" ]; then
            brew install $package
        elif [ "$OS" == "linux" ]; then
            echo "Do you want to install $package with sudo?"
            read -p "[y/n]: " install_choice
            if [ "$install_choice" == "y" ]; then
                sudo $PKG_MANAGER install $package -y
            else
                echo "Skipping $package installation."
                return 1
            fi
        fi
    else
        echo "$package is already installed."
    fi
    return 0
}

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

# Install required packages
install_package wget || exit 1
install_stow || exit 1

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
        read -p "Do you want to install zsh with sudo? [y/n]: " install_zsh
        if [ "$install_zsh" == "y" ]; then
            sudo $PKG_MANAGER install zsh -y
            chsh -s $(which zsh)
        fi
    fi
fi

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
    echo "zsh-autosuggestions is already installed."
fi

# _________________________ Fonts ____________________________

# Detect OS and set font directory
if [ "$OS" == "mac" ]; then
    # macOS font directory
    FONT_DIR="$HOME/Library/Fonts"
else
    # Linux font directory
    FONT_DIR="$HOME/.local/share/fonts"
fi

# Create fonts directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Copy Nerd Fonts to appropriate fonts directory
cp $SCRIPT_DIR/fonts/*.ttf "$FONT_DIR/" 2>/dev/null
cp $SCRIPT_DIR/fonts/*.otf "$FONT_DIR/" 2>/dev/null

# Refresh font cache (only needed on Linux)
if [[ "$OSTYPE" != "darwin"* ]]; then
    fc-cache -f
    echo "Font cache refreshed."
fi

#_____________________ Git Configuration _____________________

# Check if git is installed
install_package git || exit 1

#_____________________ Vim Configuration _____________________

# Check if vim is installed
install_package vim || echo "Skipping vim configuration."

#_____________________ Nvim Configuration _____________________

# Check if nvim is installed
if ! install_package nvim; then
    echo "Skipping neovim configuration."
else
    # Install ripgrep for telescope
    install_package ripgrep || echo "Warning: ripgrep not installed. Some neovim plugins may not work correctly."
fi

#_____________________ Stow Configuration _____________________

# Backup any existing configs before stowing
backup_existing_configs() {
    local package=$1
    echo "Checking for existing configurations for $package..."

    case $package in
        zsh)
            if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
                echo "Backing up existing .zshrc..."
                mv "$HOME/.zshrc" "$backup_folder/.zshrc.bak"
            fi
            if [ -f "$HOME/.p10k.zsh" ] && [ ! -L "$HOME/.p10k.zsh" ]; then
                echo "Backing up existing .p10k.zsh..."
                mv "$HOME/.p10k.zsh" "$backup_folder/.p10k.zsh.bak"
            fi
            ;;
        git)
            if [ -d "$HOME/.config/git" ] && [ ! -L "$HOME/.config/git" ]; then
                echo "Backing up existing git config..."
                mv "$HOME/.config/git" "$backup_folder/git.bak"
            fi
            ;;
        vim)
            if [ -f "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
                echo "Backing up existing .vimrc..."
                mv "$HOME/.vimrc" "$backup_folder/.vimrc.bak"
            fi
            ;;
        nvim)
            if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
                echo "Backing up existing nvim config..."
                mv "$HOME/.config/nvim" "$backup_folder/nvim.bak"
            fi
            ;;
    esac
}

# Stow packages
stow_packages() {
    echo "Stowing dotfiles with GNU Stow..."

    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"

    # List of packages to stow
    local packages=("zsh" "git" "vim" "nvim")

    for package in "${packages[@]}"; do
        if [ -d "$SCRIPT_DIR/$package" ]; then
            backup_existing_configs $package
            echo "Stowing $package..."
            stow -d "$SCRIPT_DIR" -t "$HOME" $package
        else
            echo "Package directory $package not found, skipping..."
        fi
    done
}

# Run stow
stow_packages

# Print OS-specific instructions
echo "Installation complete!"
# Print some newlines to make it clear that instructions follow
echo -e "\n\n________________________________________________________\n\n"

echo "Please configure the following manually:"
if [ "$OS" == "mac" ]; then
    echo "You may need to configure your terminal manually:"
    echo "- iTerm2: Preferences → Profiles → Text → Font"
    echo "- Terminal.app: Preferences → Profiles → Text"
else
    echo "You may need to configure your terminal manually:"
    echo "- GNOME Terminal: Preferences → Profile → Text"
    echo "- Konsole: Settings → Edit Current Profile → Appearance"
fi
echo "- VS Code: settings.json → terminal.integrated.fontFamily"

exec zsh
