#!/bin/bash

#This script installs vim plugins using git submodules.
#
#
#MIT License
#
#Copyright (c) 2018 Tucker Evans
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
 
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
