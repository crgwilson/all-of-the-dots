# Craig's dotfiles

This is my repo containing all of my dotfiles which I manage with [yadm](https://yadm.io). If you find anything useful in the repo, feel free to take it, although YMMV.

## My Stuff

I mostly work in Java, Python, and Go, so everything is configured with that in mind.

* [Zsh](./.config/zsh/)
* [Alacritty](./.config/alacritty/alacritty.yml)
* [Starship](./.config/starship/starship.toml)
* [Tmux](./.tmux.conf)
* [Neovim](./.config/nvim/)
* [Git](./.gitconfig)
* [Installer playbook](./.local/share/playbook/)
* [~~Vagrant~~](./.vagrant.d/Vagrantfile)

The font I use is SourceCodePro taken from NerdFont 3.0, in the case a newer version of the font is released, download the ttf from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts), and stash it [here](./.local/share/myfonts/sauce_code_prod_nerd_font/).

The config for my Iris Rev6b firmware is also stashed here. To rebuild that head on over to the [QMK configurator](https://config.qmk.fm/#/keebio/iris/rev6/LAYOUT).

## First Time Setup

All the bells and whistles I need to work on a new machine is setup with the ansible playbook in this repo. My filesystem is setup with my workspace directories, and these packages are installed:

* [Antigen](https://github.com/zsh-users/antigen)
* [Starship](https://starship.rs)
* [Golang](https://go.dev)
* [fzf](https://github.com/junegunn/fzf)
* [git-number](https://github.com/holygeek/git-number)

Other common tasks can also be run with this, like installing new versions of Go, ~~Python~~, and ~~OpenJDK~~, or ~~recompiling Neovim~~.

### Platforms

* MacOS (Intel)
* Debian 12

### Prerequisites

I've tried to automate as much as I can, but there will also be some pieces missing, so start by installing:

* brew (on MacOS)
* git

### Running the playbook

```console
~ git clone https://github.com/crgwilson/all-of-the-dots                 # Clone the repo on your fresh install
~ cd all-of-the-dots                                                     # cd into the newly cloned directory
~/all-of-the-dots python3 -m venv venv                                   # Create a new python venv
~/all-of-the-dots source ./venv/bin/activate                             # Activate your venv
(.venv) ~/all-of-the-dots python3 -m pip install -r requirements.txt     # Install python dependencies into your venv
(.venv) ~/all-of-the-dots ansible-playbook ./site.yml --ask-become-pass  # Run the playbook and hopefully it works :p
```

### How do I install a new version of Golang?

The [golang ansible role](./local/share/playbook/roles/golang) handles installing different versions of Go, all versions are defined in the vars. To add a new version, simply update the `golang_versions` list with a new version, and matching sha256 checksum to be downloaded from the go.dev repo.

```yaml
# ./local/share/playbook/roles/golang/vars/<OS-Family>.yml
---
golang:
  - version: 1.21.5
    checksum: "{{ golang_checksum_algo }}:e2bc0b3e4b64111ec117295c088bde5f00eeed1567999ff77bc859d7df70078e"
  - version: 1.2.345  # My new version
    checksum: "{{ golang_checksum_algo }}:justpretendthatthisisarealsha256checksumimtoolazytogogenerateone"
```

Once that has been updated, just run the playbook again as described above.
