# foodotfiles

Shared Hyprland desktop configuration, Kitty, Ironbar, Mako, Yazi, Neovim,
Zsh, Tmux, and Dolphin settings. The current Hyprland configuration is Lua and
requires Hyprland 0.55 or newer. `hypr/hyprland.conf` is a legacy snapshot;
it does not use the machine profiles described here.

## Install on the Yoga

Run as your regular user, not root:

```sh
sudo pacman -Syu git python
mkdir -p ~/.config
git clone --recurse-submodules https://github.com/lcbcFoo/foo_dotfiles.git ~/.config/foodotfiles
cd ~/.config/foodotfiles
sudo pacman -S --needed $(cat packages/desktop.txt) mesa vulkan-intel sof-firmware
python foodotfiles.py install hypr kitty ironbar mako yazi nvim --profile yoga --force
python foodotfiles.py check hypr kitty ironbar mako yazi nvim
```

`--force` moves existing configs to timestamped backups before linking them.
Omit it to refuse replacing existing files. Enable NetworkManager and Bluetooth
if not already enabled, then launch `start-hyprland` from your console login.
The Lua config opens Kitty with **Super+Enter**, the launcher with **Super+R**,
and Yazi with **Super+E**. Close windows with **Super+Shift+Q**.

The package list covers the shared session. Desktop NVIDIA drivers, Proton VPN,
and EasyEffects are machine-specific and are not in this list. Ironbar is now
available in Arch's `extra` repository; this desktop currently uses `ironbar-git`.

## Neovim

The package list includes Neovim, LazyVim's search/parser dependencies, a compiler,
clipboard support, and Node/npm for language-server tooling. Install the tracked
config as your regular user:

```sh
python foodotfiles.py install nvim --force
nvim
```

On the first launch, lazy.nvim downloads the plugins. Use `:Lazy restore` to
restore the versions recorded in `nvim/lazy-lock.json`, then `:checkhealth` to
inspect any remaining tool requirements. Avoid `:Lazy sync` when reproducing the
lockfile: sync updates plugins and rewrites it.

The Minuet AI completion config expects a llama.cpp server on `127.0.0.1:8012`.
That server and its model are not part of the dotfiles installation.

## Yay and AUR packages

Official repository packages are in `packages/desktop.txt`; AUR packages are in
`packages/aur.txt`. The AUR list currently contains `yay`. Bootstrap it once using
[the upstream installation instructions](https://github.com/Jguer/yay#installation),
as your regular user:

```sh
sudo pacman -S --needed git base-devel
mkdir -p ~/.cache/foodotfiles-build
cd ~/.cache/foodotfiles-build
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Once Yay is installed, the AUR list can be applied from the dotfiles directory:

```sh
yay -S --needed $(cat packages/aur.txt)
```

## Zsh and console login

The shared `.zshrc` keeps this desktop's Oh My Zsh `robbyrussell` theme, `git`
plugin, aliases, PATH settings, and development helpers. Install Oh My Zsh
separately if `~/.oh-my-zsh` does not exist:

```sh
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
python foodotfiles.py install zsh --force
chsh -s /bin/zsh
```

Log out and back in for the login shell change to apply. Development helper
functions still require the corresponding workspace, Android SDK, or scripts.
`~/.deepseek_token` is local and is never bundled; the config reads it only when
it exists. Missing Oh My Zsh does not prevent the shell from starting.

To start Hyprland automatically **after logging in on tty1**, explicitly install
its Zsh login profile:

```sh
python foodotfiles.py install hypr-login --force
```

This installs `~/.zprofile`, preserving any previous file as a backup. It leaves
SSH sessions, other consoles, and graphical terminal windows as normal shells.
It does not bypass the LUKS or user login prompts. `hypr-login` is intentionally
excluded from the default install/check/remove set; name it explicitly to manage
it. Bash's `.bash_profile` is not used when your login shell is Zsh.

## Machine profiles

```sh
# Existing NVIDIA desktop: preserve its monitors, VPN, and Bluetooth audio startup.
python foodotfiles.py install hypr ironbar scripts --profile desktop --force

# Intel Yoga: automatic monitor mode/scaling, direct Ironbar startup, no NVIDIA widget.
python foodotfiles.py install hypr ironbar --profile yoga --force
```

The shared appearance and bindings live in `hypr/hyprland.lua`. GPU settings,
monitors and additional startup commands live in `hypr/profiles/*.lua`.
Ironbar profiles live in `ironbar/profiles/*.corn`; both use the same stylesheet.
The desktop profile retains the existing two-device NVIDIA monitoring module.

`hypr/machine.lua` and `ironbar/config.corn` are ignored local symlinks selecting
those profiles. Changing one machine's selection does not change the tracked
configuration. A new installation defaults to `yoga`; an existing selection is
preserved when `--profile` is omitted. Select both `hypr` and `ironbar` when
switching profiles. Restart Hyprland to apply startup commands and GPU environment
changes. Reload Ironbar after switching its profile.

The desktop-only `scripts/start-audio.sh` connects the existing Bluetooth speaker,
selects its sink, optionally launches EasyEffects, and finally starts Ironbar.
Its speaker address is intentionally desktop-specific. The Yoga starts Ironbar
directly and uses its normal audio devices. Wallpaper images, icon themes, VPN
credentials, and application state are not bundled. The bar requests the optional
Tela-circle-grey-dark icon theme; GTK uses available icons if it is not installed.

## Update and inspect

```sh
git pull --ff-only
git submodule update --init --recursive
python foodotfiles.py check
```

`check` reports missing links and profile selections. Installation creates links
only; it does not install packages or enable services. You can install a subset:

```sh
python foodotfiles.py install nvim tmux
python foodotfiles.py rm nvim tmux
```

`rm` removes only links pointing into this repository; backups are retained.
