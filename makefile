STOW_CMD= stow --ignore="makefile|.*m4|src"
UNSTOW_CMD= stow -D

process: X alacritty lemonbar

remove:
	$(UNSTOW_CMD) X/
	$(UNSTOW_CMD) alacritty/
	$(UNSTOW_CMD) bash/
	$(UNSTOW_CMD) bin/
	$(UNSTOW_CMD) bspwm/
	$(UNSTOW_CMD) csh/
	$(UNSTOW_CMD) gpg/
	$(UNSTOW_CMD) i3/
	$(UNSTOW_CMD) input/
	$(UNSTOW_CMD) mbsync/
	$(UNSTOW_CMD) msmtp/
	$(UNSTOW_CMD) mutt/
	$(UNSTOW_CMD) newsboat/
	$(UNSTOW_CMD) qutebrowser/
	$(UNSTOW_CMD) sxhkd/
	$(UNSTOW_CMD) tmux/
	$(UNSTOW_CMD) vim/

stow: process
	$(STOW_CMD) X/
	$(STOW_CMD) alacritty/
	$(STOW_CMD) bash/
	$(STOW_CMD) bspwm/
	$(STOW_CMD) csh/
	$(STOW_CMD) gpg/
	$(STOW_CMD) i3/
	$(STOW_CMD) input/
	$(STOW_CMD) lemonbar/
	$(STOW_CMD) mbsync/
	$(STOW_CMD) msmtp/
	$(STOW_CMD) mutt/
	$(STOW_CMD) newsboat/
	$(STOW_CMD) qutebrowser/
	$(STOW_CMD) sxhkd/
	$(STOW_CMD) tmux/
	$(STOW_CMD) vim/

lemonbar: lemonbar/src/input.go lemonbar/bin/get_network_info.sh
	cd lemonbar; make

X: m4_defaults X/Xresources.m4
	cd X; make

alacritty: m4_defaults alacritty/alacritty.m4
	cd alacritty; make

m4_defaults: $(wildcard m4_defines/*.m4)
	if test `hostname` = ursa-minor; then \
		ln -sf ./ursa_minor.m4 ./m4-defines/m4_defaults.m4; \
	elif test `hostname` = devon; then \
		ln -sf ./devon.m4 ./m4-defines/m4_defaults.m4; \
	else \
		ln -sf ./ursa_minor.m4 ./m4-defines/m4_defaults.m4; \
	fi

