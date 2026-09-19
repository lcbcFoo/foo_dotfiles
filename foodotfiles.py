#!/usr/bin/env python3
"""foodotfiles — keep this repo's configs symlinked into place.

    ./foodotfiles.py install [names...] [--force]   create the symlinks
    ./foodotfiles.py rm [names...]                  remove symlinks pointing into this repo
    ./foodotfiles.py check [names...]               show what is installed

Configs that are their own git repo live here as submodules instead of copies;
run `git submodule update --init --recursive` once after cloning on a new machine.
"""

from __future__ import annotations

import argparse
import os
import shutil
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parent
HOME = Path.home()

# name -> sources are relative to the repo, targets are absolute-ish (~ expanded)
CONFIGS: dict[str, dict] = {
    "hypr": {"links": [("hypr", "~/.config/hypr")]},
    "kitty": {
        "links": [("kitty", "~/.config/kitty")],
        "submodules": {"kitty/kitty-themes": "https://github.com/dexpota/kitty-themes.git"},
    },
    "nvim": {"links": [("nvim", "~/.config/nvim")]},
    "tmux": {"links": [("tmux/tmux.conf", "~/.tmux.conf")]},
    "dolphin": {
        "links": [
            ("dolphin/dolphinrc", "~/.config/dolphinrc"),
            ("dolphin/kdeglobals", "~/.config/kdeglobals"),
            ("dolphin/color-schemes/Foocolors.colors", "~/.local/share/color-schemes/Foocolors.colors"),
            ("dolphin/applications/org.kde.dolphin.desktop", "~/.local/share/applications/org.kde.dolphin.desktop"),
            ("dolphin/applications/org.gnome.Nautilus.desktop", "~/.local/share/applications/org.gnome.Nautilus.desktop"),
        ]
    },
}

OK, MISSING, FOREIGN, BROKEN_SOURCE = "ok", "missing", "foreign", "no-source"


def target(path: str) -> Path:
    return HOME / path[2:] if path.startswith("~/") else Path(path)


def state(src: Path, dst: Path) -> str:
    if not src.exists():
        return BROKEN_SOURCE
    if dst.is_symlink():
        return OK if dst.resolve() == src.resolve() else FOREIGN
    return MISSING if not dst.exists() else FOREIGN


def rel_link(src: Path, dst: Path) -> str:
    """Relative symlink so the repo can be moved as a unit."""
    return os.path.relpath(src, dst.parent)


def selected(names: list[str]) -> list[str]:
    if not names:
        return list(CONFIGS)
    unknown = [n for n in names if n not in CONFIGS]
    if unknown:
        sys.exit(f"unknown config(s): {', '.join(unknown)} (have: {', '.join(CONFIGS)})")
    return names


def submodule_lines(name: str) -> list[str]:
    out = []
    for path, url in CONFIGS[name].get("submodules", {}).items():
        d = REPO / path
        initialized = d.is_dir() and any(d.iterdir())
        if initialized:
            out.append(f"  submodule {path}: ok")
        else:
            out.append(f"  submodule {path}: MISSING — git -C {REPO} submodule update --init --recursive  ({url})")
    return out


def do_install(names: list[str], force: bool) -> int:
    failed = 0
    for name in names:
        print(f"{name}:")
        for src_rel, dst_rel in CONFIGS[name]["links"]:
            src, dst = REPO / src_rel, target(dst_rel)
            st = state(src, dst)
            if st == BROKEN_SOURCE:
                print(f"  {dst_rel}: source {src_rel} not in repo")
                failed += 1
            elif st == OK:
                print(f"  {dst_rel}: already linked")
            elif st == MISSING:
                dst.parent.mkdir(parents=True, exist_ok=True)
                dst.symlink_to(rel_link(src, dst))
                print(f"  {dst_rel}: linked")
            else:
                if not force:
                    print(f"  {dst_rel}: EXISTS (not ours) — rerun with --force to back it up")
                    failed += 1
                    continue
                backup = dst.with_name(f"{dst.name}.bak-{time.strftime('%Y%m%d-%H%M%S')}")
                shutil.move(str(dst), str(backup))
                dst.symlink_to(rel_link(src, dst))
                print(f"  {dst_rel}: linked (old one moved to {backup.name})")
        for line in submodule_lines(name):
            print(line)
    return failed


def do_rm(names: list[str]) -> int:
    for name in names:
        print(f"{name}:")
        for _, dst_rel in CONFIGS[name]["links"]:
            dst = target(dst_rel)
            if dst.is_symlink() and REPO in dst.resolve().parents:
                dst.unlink()
                print(f"  {dst_rel}: removed")
            elif dst.is_symlink():
                print(f"  {dst_rel}: skipped (points outside the repo: {os.readlink(dst)})")
            elif dst.exists():
                print(f"  {dst_rel}: skipped (real file/dir, not created by foodotfiles)")
            else:
                print(f"  {dst_rel}: not installed")
    return 0


def do_check(names: list[str]) -> int:
    pending = 0
    width = max(len(d) for n in names for _, d in CONFIGS[n]["links"])
    for name in names:
        print(f"{name}:")
        for src_rel, dst_rel in CONFIGS[name]["links"]:
            st = state(REPO / src_rel, target(dst_rel))
            if st != OK:
                pending += 1
            print(f"  {dst_rel:<{width}}  {st}")
        for line in submodule_lines(name):
            if "MISSING" in line:
                pending += 1
            print(line)
    print(f"\n{'all configs installed' if not pending else f'{pending} item(s) not installed'}")
    return 1 if pending else 0


def main() -> int:
    p = argparse.ArgumentParser(prog="foodotfiles.py", description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("command", choices=["install", "rm", "check"])
    p.add_argument("names", nargs="*", help=f"configs to act on (default: all — {', '.join(CONFIGS)})")
    p.add_argument("--force", action="store_true", help="install: back up existing files instead of refusing")
    a = p.parse_args()
    names = selected(a.names)
    if a.command == "install":
        return 1 if do_install(names, a.force) else 0
    if a.command == "rm":
        return do_rm(names)
    return do_check(names)


if __name__ == "__main__":
    sys.exit(main())
