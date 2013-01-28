# create symbolic links for .vim/ and .vimrc
echo 'WARNING!'
echo 'This will overwrite your current ~/.vimrc, ~/.vim, and ~/.gitignore_global'
echo 'settings and set your global gitignore to ~/.gitignore_global'
read -p 'Continue (y/n)? ' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# remove previous settings
	rm ~/.vimrc
	rm -rf ~/.vim
	rm ~/.gitignore_global

	echo ''
	# create symbolic links
	ln -s ${PWD}/vim/vimrc ~/.vimrc;
	echo 'Created symbolic link ~/.vimrc -> '${PWD}'/vim/vimrc'
	ln -s ${PWD}/vim ~/.vim;
	echo 'Created symbolic link ~/.vim -> '${PWD}'/vim/'
	ln -s ${PWD}/.gitignore_global ~/.gitignore_global;
	echo 'Created symbolic link ~/.gitignore_global -> '${PWD}'/.gitignore_global'
	git config --global core.excludesfile ~/.gitignore_global
	echo 'Set global git ignore to ~/.gitignore_global'
fi
