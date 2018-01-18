#!/bin/bash
if [ "$PWD" != "$HOME/dotfiles" ]
then
	echo "Must be run in $HOME/dotfiles"
	exit 1
fi


PLUG_PATH="vim/.vim/pack/$USER/start/"
ARGS=0
while getopts o opt; do
	((ARGS++))

	if [ "$opt" == "o" ]
	then
		PLUG_PATH="vim/.vim/pack/$USER/opt/"
	fi
	if [ "$opt" == "h" ]
	then
		nroff .PlugHelp.tr
		exit 0
	fi
done
((ARGS++))
LINK="${!ARGS}"
PLUG_NAME=${LINK##*/}
FILENAME=${FILENAME%.git}
FILENAME="$PLUG_PATH$FILENAME"

echo "Installing \"$PLUG_NAME\" into directory $PLUG_PATH"



git submodule add $LINK $FILENAME && \
git add .gitmodules $FILENAME && \
git commit -m"Added vim plugin: $PLUG_NAME." && echo "Success"
