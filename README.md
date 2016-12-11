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

# Scripts

editerm: tabbed + st + neovim + terminal in GUI, abduco + neovim + terminal in CLI
  The use of abduco is transparent. You don't need to worry about sessions. Just
  run editerm and it will open an existing session if available or start a new one.

gvim: st + neovim

vim: if called from a neovim terminal, open a new tab; else open neovim

man: same as vim

# Requirements

- fish 2.3.1: https://github.com/fish-shell/fish-shell
- neovim 0.1.5: https://github.com/neovim/neovim
- neovim python client 0.1.9: pip install neovim==0.1.9
- st: git://git.suckless.org/st
- tabbed: git://git.suckless.org/tabbed
- abduco: http://www.brain-dump.org/projects/abduco/abduco-0.6.tar.gz (binary in ubuntu repo too old)
- xsel: http://www.vergenet.net/~conrad/software/xsel/download/xsel-1.2.0.tar.gz (or get binary)

I encountered an issue with fish 2.4. If vi binding is enabled, it outputs strange escape sequences
that break vim's :Man.

# Build instructions

Apply patches with `git apply <patch-file>`

- fish: Install libncurses5-dev to build code and doxygen to build man pages. Then:
    `autoconf; ./configure --prefix=<prefix>; make -j 4 install`
- neovim: Edit prefix setting in local.mk
    `make -j 4 install; pip install neovim==0.1.9`
- st: You need libx11-dev and libxft-dev to build
    `make PREFIX=<prefix> install`
- tabbed: You need libx11-dev and libxft-dev to build
    `make PREFIX=<prefix> install`
- abduco:
    `make PREFIX=<prefix> install`
- xsel:
    `./configure --prefix=<prefix>; make install`

Copy/symlink editerm, gvim, vim, man scripts.
