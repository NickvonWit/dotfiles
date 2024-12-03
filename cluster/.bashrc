# ~/.bashrc

# Execute zsh shell
if [[ -x "$HOME/.local/bin/zsh" ]]; then
    export SHELL="$HOME/.local/bin/zsh"
    exec "$HOME/.local/bin/zsh"
else 
    exec zsh
fi