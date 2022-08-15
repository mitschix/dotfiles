#!/usr/bin/env python
"toggle background and opacity for alacritty terminal config"

import os
import yaml

ALACRITTY_CONFIG_FILE = os.path.expanduser("~/.config/alacritty/alacritty.yml")

ALACRITTY_CONFIG_NORM = {
    "font": {"size": 9.0},
    "window": {"opacity": 0.9},
    "colors": {"primary": {
        "background": '#1d1f21',
        "foreground": '#c5c8c6'
    }
    }
}

ALACRITTY_CONFIG_LIGHT = {
    "font": {"size": 9.0},
    "window": {"opacity": 1.0},
    "colors": {"primary": {
        "foreground": '#1d1f21',
        "background": '#FFFFFF'
    }
    }
}


def _get_light_state() -> str:
    with open(ALACRITTY_CONFIG_FILE, "r", encoding="utf-8") as r_f:
        lines = r_f.readlines()

    if len(lines) > 1:
        snd_line = lines[1]
        state = snd_line.split(":")[1].strip() if "B_STATE" in snd_line else "dark"
    else:
        state = "light"

    return state


def _write_new_config(config: dict, state: str):
    with open(ALACRITTY_CONFIG_FILE, "w", encoding="utf-8") as w_f:
        w_f.write("# Auto generated configuration from toggle-bg.py.\n")
        w_f.write(f"# B_STATE: {state}\n\n")
        yaml.dump(config, w_f)


def toggle_bg():
    "toggle background and opacity for alacritty terminal config"
    if not os.path.exists(ALACRITTY_CONFIG_FILE):
        _write_new_config(ALACRITTY_CONFIG_NORM, "dark")
    else:
        state = _get_light_state()
        new_config, new_state = (ALACRITTY_CONFIG_LIGHT, "light") if state == "dark" \
            else (ALACRITTY_CONFIG_NORM, "dark")
        _write_new_config(new_config, new_state)


if __name__ == "__main__":
    toggle_bg()
