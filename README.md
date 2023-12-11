# Personal macOS Config

This is most of my config dotfiles for my work MacBook. I'm publishing this for my own use, but since there's nothing secret in it, I guess you can see it too if you like.

If this directory is cloned as `~/.config`, then many of these configs will Just Work™. Some programs do not know how to look in `~/.config` though -- those files must be symlinked into their dotfile location in `~`. For now, those files include:

- bash_profile
- bashrc
- clojure
- curlrc
- gitconfig
- gitignore_global
- ngrok2
- npmrc
- vimrc
- zshrc

To symlink one, cd to `~` and then do something like `ln -s .config/zshrc .zshrc`
