## Competitive programming
set PATH /home/azarashi2931/.local/bin $PATH
alias ojt="oj test -c "./a.out" -d ./tests/"
alias cm="g++ main.cpp"
alias mt="cm;ojt"
alias db="g++ -g -O0 main.cpp;gdb a.out"
alias acs="acc s"
alias accs="acc s"
alias ac="acc"
alias opc="code main.cpp"

## Rust env
set PATH ~/.cargo/bin $PATH
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
