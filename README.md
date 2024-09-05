# Esparta's dot files

These are config files to set up a system the way I like it. It's based
on @rook config files.

## Installation
```bash
git clone git://github.com/esparta/dotfiles ~/.dotfiles
cd ~/.dotfiles
```
Next, there's a few things to do, you can see the list by using `make`:
```bash
make
```

The output is the following:
```
This is the list of available targets
basic.setup curl link repos u2f vim.setup vundle
```

If you are setting up a ArchLinux machine, you may want to install basic programs
that I do use every day:

```bash
make basic.setup
```

After that you may want to copy the configurations I already setup for you:

```bash
make link
```

Vim plugins are managed through vundle. You'll need to install vundle
to get them.

```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

  Run :BundleInstall in vim.
