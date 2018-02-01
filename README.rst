Tucker's Dotfiles
=================

These dotfiles are here mostly move them  between my computers and 
as a backup, but feel free to use them yourself.

Installation
------------

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
