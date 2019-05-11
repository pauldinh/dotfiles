echo "in .bash_profile"
[[ -r ~/.bashrc ]] && . ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"
if [ -e /home/pdinh/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pdinh/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# autojump
[[ -s /home/pdinh/.autojump/etc/profile.d/autojump.sh ]] && source /home/pdinh/.autojump/etc/profile.d/autojump.sh
#. /usr/share/autojump/autojump.sh
