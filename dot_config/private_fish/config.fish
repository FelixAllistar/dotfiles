if not status is-interactive
    exit
end
if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

# Autojump setup for fish
begin
    set --local AUTOJUMP_PATH /usr/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

# Environment variables
set -x ANDROID_HOME ~/Android/Sdk
set -x NDK_HOME ~/Android/Sdk/ndk
set -x PATH /usr/local/bin ~/.local/bin $ANDROID_HOME/emulator $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools /usr/lib/at-spi2-core $PATH
set -x LD_LIBRARY_PATH /home/felix/projects/VibeCodin/venv/lib/python3.12/site-packages/nvidia/cublas/lib:/home/felix/projects/VibeCodin/venv/lib/python3.12/site-packages/nvidia/cudnn/lib
fish_add_path -a ~/bin
# Aliases
fastfetch
alias startback="cd backend && source venv/bin/activate.fish && python run.py"
alias install="sudo pacman -S"
alias yayinstall="yay -S"

# Git quick commit and push function
function gitc --description "Quick git add, commit, and push"
    if test (count $argv) -eq 0
        echo "Usage: gitc commit message here"
        return 1
    end
    git add . && git commit -m "$argv" && git push
end

# Pyenv setup
# Pyenv setup
set -gx PYENV_ROOT $HOME/.pyenv
set -gx PATH $PYENV_ROOT/bin $PATH
if command -v pyenv >/dev/null
    pyenv init - fish | source
end
# Custom AI function
function ai --description "Suggest and optionally run a Linux command from English input"
    set QUERY "Provide only the Linux command for: $argv"
    set RESPONSE (gemini -m gemini-1.5-flash "$QUERY")
    echo "Suggested command: $RESPONSE"
    read --prompt-str="Execute? (y/n) " confirm
    if test "$confirm" = y
        eval $RESPONSE
    end
end

# Node.js options
export NODE_OPTIONS="--expose-gc"

# pnpm setup
set -gx PNPM_HOME "/home/felix/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# pnpm
set -gx PNPM_HOME "/home/felix/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
