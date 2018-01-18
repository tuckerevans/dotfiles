#!/bin/bash
if [ "$PWD" != "$HOME/dotfiles" ]
then
	echo "Must be run in $HOME/dotfiles"
	exit 1
fi


while getopts o opt; do
	if [ "$opt" == "h" ]
	then
		nroff .PlugHelp.tr
		exit 0
	fi
done

git submodule update --remote --merge && \
git commit -m"Updated vim plugins." && echo "Success"
