alias psg='ps -aux | grep'
alias die='kill -9'
alias sagi='sudo apt-get install'
alias sagr='sudo apt-get remove'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias uu='update && upgrade'
alias apts='aptitude search'

ECHO() {
    echo -e ${1//:/\\n}
}
