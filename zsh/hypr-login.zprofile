# Optional Hyprland startup after a local login on tty1.
# Other consoles, SSH sessions, and terminal windows keep their normal shell.
if [[ -z "$WAYLAND_DISPLAY" && -z "$DISPLAY" && -z "$SSH_CONNECTION" \
      && "$(tty)" == /dev/tty1 ]] && command -v start-hyprland >/dev/null 2>&1; then
  exec start-hyprland
fi
