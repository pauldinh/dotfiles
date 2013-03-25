alias psg='ps -aux | grep'
alias die='kill -9'


ECHO() {
    echo -e ${1//:/\\n}
}
