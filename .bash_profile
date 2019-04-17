[[ -r ~/.bashrc ]] && . ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"
if [ -e /home/pdinh/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pdinh/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# autojump
. /usr/share/autojump/autojump.sh
