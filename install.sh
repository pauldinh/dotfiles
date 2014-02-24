# create symlinks for .vim/ and .vimrc
echo 'This script will create symlinks for ~/.bash_profile, ~/.bash_aliases, ~/.gitignore_global, and ~/.config/terminator/config'
echo 'It will rename existing files to *.backup'
read -p 'Continue (y/n)? ' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# remove previous settings
	#rm ~/.vimrc
	#rm -rf ~/.vim
	mv ~/.gitignore_global ~/.gitignore_global.backup
	mv ~/.config/terminator/config ~/.config/terminator/config.backup
	mv ~/.bash_aliases ~/.bash_aliases.backup
        mv ~/.kde/share/apps/konsole/DarkPastels.colorscheme ~/.kde/share/apps/konsole/DarkPastels.colorscheme.backup
        mv ~/.kde/share/apps/konsole/Shell.profile ~/.kde/share/apps/konsole/Shell.profile.backup
	mv ~/.tmux.conf ~/.tmux.conf.backup
	mv ~/.tmux/dev ~/.tmux/dev.backup

	echo ''
	# create symlinks
	#ln -s ${PWD}/vim/vimrc ~/.vimrc;
	#echo 'Created symlink ~/.vimrc -> '${PWD}'/vim/vimrc'
	#ln -s ${PWD}/vim ~/.vim;
	#echo 'Created symlink ~/.vim -> '${PWD}'/vim/'
	ln -s ${PWD}/.gitignore_global ~/.gitignore_global;
	echo 'Created symlink ~/.gitignore_global -> '${PWD}'/.gitignore_global'
	git config --global core.excludesfile ~/.gitignore_global
	echo 'Set global git ignore to ~/.gitignore_global'
	mkdir -p ~/.config/terminator
	ln -s ${PWD}/terminator/config ~/.config/terminator/config
	echo 'Created symlink ~/.config/terminator config -> '${PWD}'/terminator/config'
	ln -s ${PWD}/.bash_aliases ~/.bash_aliases
	echo 'Created symlink ~/.bash_aliases -> '${PWD}'/.bash_aliases'
	ln -s ${PWD}/.bash_profile ~/.bash_profile
	echo 'Created symlink ~/.bash_profile -> '${PWD}'/.bash_profile'
        ln -s ${PWD}/konsole/DarkPastels.colorscheme ~/.kde/share/apps/konsole/DarkPastels.colorscheme
	echo 'Created symlink ~/.kde/share/apps/konsole/DarkPastels.colorscheme -> '${PWD}'/konsole/DarkPastels.colorscheme'
        ln -s ${PWD}/konsole/Shell.profile ~/.kde/share/apps/konsole/Shell.profile
	echo 'Created symlink ~/.kde/share/apps/konsole/Shell.profile -> '${PWD}'/konsole/Shell.profile'
	ln -s ${PWD}/tmux/.tmux.conf ~/.tmux.conf
	echo 'Created symlink ~/.tmux.conf -> '${PWD}'/tmux/.tmux.conf'
        mkdir -p ~/.tmux
	ln -s ${PWD}/tmux/dev ~/.tmux/dev
	echo 'Created symlink ~/tmux/dev -> '${PWD}'/tmux/dev'

fi
