# foodotfiles

Shared Hyprland desktop configuration, Kitty, Ironbar, Mako, Yazi, Neovim,
Tmux, and Dolphin settings. The current Hyprland configuration is Lua and
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
python foodotfiles.py install hypr kitty ironbar mako yazi --profile yoga --force
python foodotfiles.py check hypr kitty ironbar mako yazi
```

`--force` moves existing configs to timestamped backups before linking them.
Omit it to refuse replacing existing files. Enable NetworkManager and Bluetooth
if not already enabled, then launch `start-hyprland` from your console login.
The Lua config opens Kitty with **Super+Enter**, the launcher with **Super+R**,
and Yazi with **Super+E**. Close windows with **Super+Shift+Q**.

The package list covers the shared session. Desktop NVIDIA drivers, Proton VPN,
and EasyEffects are machine-specific and are not in this list. Ironbar is now
available in Arch's `extra` repository; this desktop currently uses `ironbar-git`.

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
