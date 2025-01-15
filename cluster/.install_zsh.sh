#!/bin/bash

# Find location of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Download and install zsh from source
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download

# Extract zsh source
mkdir zsh
unxz zsh.tar.xz && tar -xvf zsh.tar -C zsh --strip-components 1
cd zsh

# Configure and install zsh to local directory
mkdir -p $SCRIPT_DIR/.local
./configure --prefix=$SCRIPT_DIR/.local
make && make install

# Cleanup source files
cd ..
rm -rf zsh.tar zsh

# Create local bin directory and symlink zsh
mkdir -p $HOME/.local/bin
ln -sf $SCRIPT_DIR/.local/bin/zsh $HOME/.local/bin/zsh

# Ensure local bin is in PATH (if not already present)
touch $HOME/.aliases
if ! grep -q "export PATH=\"\$HOME/.local/bin:\$PATH\"" $HOME/.aliases; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.aliases
fi

 echo "Setting zsh as the default shell..."

# Backup existing .bash_profile and create new one that launches zsh
if [ -f $HOME/.bash_profile ]; then
    mv $HOME/.bash_profile $HOME/.bash_profile.bak
fi
ln -sf $SCRIPT_DIR/.bash_profile $HOME/.bash_profile
