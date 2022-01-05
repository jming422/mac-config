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
- simplebarrc
- vimrc

To symlink one, cd to `~` and then do something like `ln -s .config/bashrc .bashrc`

The `simplebarrc` you see in there is for https://github.com/Jean-Tinland/simple-bar, which I usually have installed under my fork https://github.com/jming422/simple-bar. I try to issue PRs on my fork back to the original repo, so it's probably best to just install the real one and not use my fork.
