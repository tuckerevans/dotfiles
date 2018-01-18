#!/bin/bash
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
NAME="${!ARGS}"
FILENAME="$PLUG_PATH$NAME"

git submodule deinit -f $FILENAME
echo
git rm -f $FILENAME
echo
rm -rfv ".git/modules/$FILENAME"

git commit -m"Removed vim plugin: $NAME"
