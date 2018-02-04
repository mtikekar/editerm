# User-facing scripts

editerm: tabbed + st + neovim + terminal in GUI, abduco + neovim + terminal in CLI.
  The use of abduco is transparent. You don't need to worry about sessions. Just
  run editerm and it will open an existing session if available or start a new one.

gvim: st + neovim

vim: If called from a neovim terminal, open a new tab. Else, open neovim.

man: If called from a neovim terminal, open man page with neovim's :Man. Else, call system /usr/bin/man.

# Components

- fish: https://github.com/fish-shell/fish-shell
- neovim: https://github.com/neovim/neovim
- st: git://git.suckless.org/st
- tabbed: git://git.suckless.org/tabbed
- abduco: http://www.brain-dump.org/projects/abduco
- xsel: http://www.vergenet.net/~conrad/software/xsel/download/xsel-1.2.0.tar.gz (or get binary)

# Shortcuts

tabbed:
- `Ctrl-Shift-t`: open new tab with st
- `Ctrl-q`: close tab
- `Ctrl-<Tab>`: go to last tab
- Mouse: go to tab
- `Shift-<left>/<right>`: move tab
- `F11`: fullscreen

neovim:
- `Ctrl-h,j,k,l`: move b/w windows and tabs
- Mouse: go to tab

# Build requirements

fish needs `libncurses5-dev` for compiling and `doxygen` for documentation (man pages).
st and tabbed need `libx11-dev` and `libxft-dev`.
xsel needs `libxt-dev`.

All these build requirements can be uninstalled after building. The run-time dependencies for all of
these came pre-installed on an Ubuntu 16.04 system.

See the [install script](install) for how to install.

# Notes

To uninstall:
- delete the prefix directory
- `rm -r ~/{.config,.local/share}/{nvim,fish}`
- `rm ~/.terminfo/s/st{,-meta}{,-256color}`
- `rmdir -p ~/.terminfo/s`

man only supports `man <page>` or `man <number> <page>`. vim only supports whatever `vim -h` says.

I encountered an issue with fish 2.4. If vi binding is enabled, it outputs strange codes
that break vim's :Man. Sticking to 2.3.1 for now.
