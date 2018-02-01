Tucker's Dotfiles
=================

These dotfiles are here mostly to move them between my computers and 
as a backup, but feel free to use them yourself.

vimPlugins
----------
These shell scrips are my solution to vim plugins, they use
git-submodules and vim 8's third party package loading.
I recomend reading `Vim: So long Pathogen, hello native package
loading <https://shapeshed.com/vim-packages/>`_,
as it was my reference when creating the scripts.
These will probably be move to their own repo someday, but I'm too
tired to do that now.

.. warning ::
  I just threw these scripts together one night, I do not trust them to be
  completely stable, you should read through them and make sure you
  understand what they are doing.

Installation
------------

dotfiles
********

.. note :: 
  I recommend backing up any existing dotfiles you have before
  installing these, you can do this with the following command
  :code:`cp .dotfile_to_backup .dotfile_to_backup.bak`


I recomend using `stow <https://www.gnu.org/software/stow/>`_ to
manage these files. This can be done with the following commands.

1.  :code:`cd ~`
2.  :code:`git clone https://github/tuckerevans/dotfiles`
3.  :code:`cd dotfiles`
4.  Run :code:`stow [program]` for each program's dotfiles you want to use

      *Example:* :code:`stow vim` or :code:`stow mutt`

vimPlugins
**********

I just run the vimPlugins scripts from my `dotfiles/vimPlugins` directory with
:code:`./PlugInstall`, you could link to them in `/usr/local/bin` by
running the following command as root (or with sudo).

-  :code:`stow -t /usr/local/bin vimPlugins`


Usage (vimPlugins)
------------------

.. note ::
  These scripts must be run in `/home/$user/dotfiles`. You can change
  this by editing the first few lines of the scripts.

PlugInstall
***********

PlugInstall.sh takes in the link to a git repository the same as git
clone, the optional flag `-o` with place the plugin in the opt folder
(this means you will have to tell vim to start this plugin) 

  *Example:* :code:`./PlugInstall.sh [-o] git@github.com/exampleAccount/exampl_repository` 

PlugUpdate
***********

PlugUpdate.sh takes in no arguments and will update the submodules.

  *Example:* :code:`./PlugUpdate.sh`

PlugRemove
***********

PlugUpdate.sh takes in the name of the submodule (plugin) that you
would like to remove, the optional flag `-o` should be used if used in
the install.

  *Example:* :code:`./PlugRemove.sh [-o] example_repository`
