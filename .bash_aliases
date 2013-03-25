# From: https://pintsize.jsc.nasa.gov/drc-software/drc_common/blobs/develop/scripts/util-git.sh
export GITAWAREPROMPT=~/.bash/git-aware-prompt
if [ -d $GITAWAREPROMPT ]
then
    # From: https://github.com/jimeh/git-aware-prompt (mentioned by Dane in Confluence)
    # This solution doesn't screw up bash's ability to count characters so you don't get weird line wrapping when editing old lines
    source $GITAWAREPROMPT/main.sh
    export PS1="\[$bldgrn\]\u@\h\[$bldblu\] \w\[$bldylw\]\$git_branch\[$bldred\]\$git_dirty\[$txtrst\]\$ "
fi
