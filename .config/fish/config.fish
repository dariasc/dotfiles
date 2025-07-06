set -U fish_greeting
set -U lucid_skip_newline

if status is-interactive
    # Commands to run in interactive sessions can go here
end

export PATH="$PATH:$HOME/.local/bin/"

alias c='g++ -Wall -Wconversion -Wfatal-errors -g -std=c++23 -fsanitize=undefined,address'

set -gx EDITOR vim
set -gx ZEIT_DB ~/.config/zeit.db 

