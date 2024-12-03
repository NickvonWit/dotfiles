# ~/.bashrc

# Execute zsh shell
if [[ -x "$HOME/.local/bin/zsh" ]]; then
    export SHELL="$HOME/.local/bin/zsh"
    export PATH="$HOME/.local/bin:$PATH"
    exec "$HOME/.local/bin/zsh" -l
elif command -v zsh >/dev/null 2>&1; then
    export SHELL=$(command -v zsh)
    exec zsh -l
fi