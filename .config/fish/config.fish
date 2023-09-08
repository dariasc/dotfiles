set -U fish_greeting
set -U lucid_skip_newline

if status is-interactive
    # Commands to run in interactive sessions can go here
end

export (envsubst < ~/.env)
alias zcc="g++ -Wall -Wextra -pedantic -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -Wno-unknown-pragmas -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector -o z"
