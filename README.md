# .dotfiles

---
My portable configurations for programs on my machines. Controlled via [chezmoi](https://github.com/twpayne/chezmoi)

Currently, this is a config-only repo, no automatic package installation.

## Notes

> To my future self and anyone who happens to stumble accross this mess.

### zsh, .zshrc and zsh config

I use [zsh](https://www.zsh.org/) with
[zinit](https://github.com/zdharma-continuum/zinit) as a package manager.

I opted to separate start up snippets into different files inside
[config/zsh](./private_dot_config/zsh/), take a look at them to get a rough
idea of what tools to install. The sourcing order inside [.zshrc](./dot_zshrc)
matters (sometimes).

### nvim

I pickpocketed my nvim config from a lot of places, so here is a shout out:

- [neovim](https://github.com/neovim/neovim), currently using version 0.11 cuz
  I'm too lazy to switch to vim.pack
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim): man I love Tj.
- I can't remember the other repos, so I will add them gradually.

### tmux

> Remember to install TPM, Remember to install TPM, Remember to install TPM.

Once TPM is installed, tmux should sort itself out (I hope).

Here's some note about the config:

- [tmux-sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer): I stole
  the file
  [tmux-sessionizer.sh](./private_dot_local/bin/executable_tmux-sessionizer.sh)
  directly from ThePrimeagen's plugin and added a few tweak, so here's a shout
  out. Also, edit target directories in the script to fit your directory
  structure.
- [tmux-catppuccin](https://github.com/catppuccin/tmux): not installed via TPM,
  visit the repo for installation command.
- `<prefix>+<C-o>`: fuzzy search sessions (probably should be written into a script).
- `<prefix>+<C-n>`: tmux-sessionizer, create new session with selected base directory.

### catppuccin

I love [catppuccin](https://github.com/catppuccin), I don't know why it isn't
used by everyone, so this section is a reminder if I ever forget my favorite
theme's name.
