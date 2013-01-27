# create symbolic links for .vim/ and .vimrc
echo 'WARNING!'
echo 'This will overwrite your current ~/.vimrc and ~/.vim settings.'
read -p 'Continue (y/n)? ' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	rm ~/.vimrc; rm -rf ~/.vim
	echo ''
	ln -s ${PWD}/vim/vimrc ~/.vimrc;
	echo 'Created symbolic link ~/.vimrc -> '${PWD}'/vim/vimrc'
	ln -s ${PWD}/vim ~/.vim;
	echo 'Created symbolic link ~/.vim -> '${PWD}'/vim/'
fi
