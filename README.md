# dotfiles
my dotfiles for zsh, nnn, vscodium, nvim, i3, sway, ...

## Install
To use the repo/config just clone this repo and link the folders to the prefered location.
Most of the config folders are designed to directly link them into **~/.config/**.

```sh
ln -s <path/to/dotfiles-repo>/config/i3 ~/.config/i3
```

To use my [nvim](https://github.com/mitschix/nvim.files/) config or install all the configs and the correspotending applications with [dotbot](https://github.com/anishathalye/dotbot) you have to clone this repo with submodules.

```sh
git clone --recurse-submodules https://github.com/mitschix/dotfiles
```

### Using dotbot
This repo uses [dotbot](https://github.com/anishathalye/dotbot) to setup/copy all the configuration to the needed location.
All files beloging to dotbot are in the **meta** folder. To install the configs there are two scripts given.

The first one is `install-profile` and to use this you can execute it with a prefered profile given:
```sh
./install-profile configs
```

This will refer to the **configs** script in **meta/profiles/** which has a list of yaml files to execute. The yaml files for the config are located in **meta/configs**

With the second script `install-standalone` you can select single config files to install:
```sh
./install-standalone nvim
```

For further information please read the [dotbot wiki](https://github.com/anishathalye/dotbot/wiki/Tips-and-Tricks).

## Further ideas
If you have feedback - further ideas - a super cool config to look at - any other needs ==> do not hesitate to contact me! (:
