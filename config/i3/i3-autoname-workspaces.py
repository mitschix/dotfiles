#!/usr/bin/env python3

# This script listens for i3 events and updates workspace names to show icons
# for running programs.  It contains icons for a few programs, but more can
# easily be added by inserting them into WINDOW_ICONS below.
#
# Dependencies
# * xorg-xprop - install through system package manager
# * i3ipc - install with pip
# * fontawesome - install with pip
#
# Installation:
# * Download this script and place it in ~/.config/i3/ (or anywhere you want)
# * Add "exec_always ~/.config/i3/i3-autoname-workspaces.py &" to your i3 config
# * Restart i3: "$ i3-msg restart"
#
# Configuration:
# The default i3 config's keybingings reference workspaces by name, which is an
# issue when using this script because the "names" are constantaly changing to
# show window icons.  Instead, you'll need to change the keybindings to
# reference workspaces by number.  Change lines like:
#   bindsym $mod+1 workspace 1
# To:
#   bindsym $mod+1 workspace number 1


import re
import signal
import subprocess as proc
import sys

import fontawesome as fa
import i3ipc

from util import construct_workspace_name, parse_workspace_name

# Add icons here for common programs you use.  The keys are the X window class
# (WM_CLASS) names (lower-cased) and the icons can be any text you want to
# display.
#
# Most of these are character codes for font awesome:
#   http://fortawesome.github.io/Font-Awesome/icons/
#
# If you're not sure what the WM_CLASS is for your application, you can use
# xprop (https://linux.die.net/man/1/xprop). Run `xprop | grep WM_CLASS`
# then click on the application you want to inspect.
WINDOW_ICONS = {
	'atom': fa.icons['code'],
	'blender': fa.icons['cube'],
	'blueman-manager': fa.icons['bluetooth'],
	'chromium': fa.icons['chrome'],
	'code': fa.icons['code'],
	'darktable': fa.icons['camera'],
        'discord': fa.icons['discord'],
	'dwarf_fortress': fa.icons['fort-awesome'],
	'eclipse': fa.icons['code'],
	'emacs': fa.icons['code'],
	'evince': fa.icons['file-pdf'],
	'factorio': fa.icons['cog'],
	'feh': fa.icons['image'],
	'firefox': fa.icons['firefox'],
	'firefox-developer': fa.icons['firefox'],
	'gimp-2.10': fa.icons['file-image'],
	'google-chrome': fa.icons['chrome'],
	'vscodium': fa.icons['code'],
	'kicad': fa.icons['microchip'],
        'kite': fa.icons['python'],
        'keepassxc': fa.icons['key'],
	'libreoffice': fa.icons['file-alt'],
	'mirage': fa.icons['image'],
	'multimc': fa.icons['cube'],
	'minecraft 1.12.2': fa.icons['cube'],
	'mpv': fa.icons['video'],
	'mupdf': fa.icons['file-pdf'],
	'nautilus': fa.icons['folder'],
	'nm-connection-editor': fa.icons['wifi'],
	'org-openstreetmap-josm-gui-mainapplication': fa.icons['map'],
	'pavucontrol': fa.icons['volume-up'],
	'qbittorrent': fa.icons['download'],
	'qtcreator': fa.icons['code'],
	'spotify': fa.icons['spotify'],
	'steam': fa.icons['steam'],
	'subl': fa.icons['file-alt'],
	'subl3': fa.icons['file-alt'],
	'telegram-desktop-bin': fa.icons['telegram'],
	'telegram-desktop': fa.icons['telegram'],
	'terminator': fa.icons['terminal'],
	'terraria': fa.icons['tree'],
	'thunar': fa.icons['folder'],
	'thunderbird': fa.icons['envelope'],
	'termite': fa.icons['terminal'],
	'vim': fa.icons['code'],
	'virt-manager': fa.icons['desktop'],
	'virtualbox manager': fa.icons['desktop'],
	'vmware': fa.icons['desktop'],
	'zathura': fa.icons['file-pdf'],
}

# This icon is used for any application not in the list above
DEFAULT_ICON = '*'


# Returns an array of the values for the given property from xprop.  This
# requires xorg-xprop to be installed.
def xprop(win_id, property):
	try:
		prop = proc.check_output(['xprop', '-id', str(win_id), property], stderr=proc.DEVNULL)
		prop = prop.decode('utf-8')
		print(re.findall('"([^"]+)"', prop))
		return re.findall('"([^"]+)"', prop)

	except proc.CalledProcessError:
		print("Unable to get property for window '%d'" % win_id)
		return None


def icon_for_window(window):
	classes = xprop(window.window, 'WM_CLASS')
	if classes is not None and len(classes) > 0:
		for cls in classes:
			cls = cls.lower()  # case-insensitive matching
			if cls in WINDOW_ICONS:
				return WINDOW_ICONS[cls]

		print('No icon available for: %s' % str(classes))

	return DEFAULT_ICON


# renames all workspaces based on the windows present
def rename_workspaces(i3):
	for workspace in i3.get_tree().workspaces():
		if '' not in workspace.name and '' not in workspace.name and '' not in workspace.name:
			name_parts = parse_workspace_name(workspace.name)
			name_parts['icons'] = ' '.join([icon_for_window(w) for w in workspace.leaves()])
			new_name = construct_workspace_name(name_parts)
			i3.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))


# rename workspaces to just numbers and shortnames.
# called on exit to indicate that this script is no longer running.
def undo_window_renaming(i3):
	for workspace in i3.get_tree().workspaces():
		name_parts = parse_workspace_name(workspace.name)
		name_parts['icons'] = None
		new_name = construct_workspace_name(name_parts)
		i3.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))

	i3.main_quit()
	sys.exit(0)


if __name__ == '__main__':
	i3 = i3ipc.Connection()

	# exit gracefully when ctrl+c is pressed
	for sig in [signal.SIGINT, signal.SIGTERM]:
		signal.signal(sig, lambda signal, frame: undo_window_renaming(i3))

	# call rename_workspaces() for relevant window events
	def window_event_handler(i3, e):
		if e.change in ['new', 'close', 'move']:
			rename_workspaces(i3)

	i3.on('window', window_event_handler)
	rename_workspaces(i3)
	i3.main()
