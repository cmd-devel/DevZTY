#! /usr/bin/env sh

cd $(dirname $0)
source ./common.sh

echo 'Uninstalling...'

# Remove the keymap
rm -f "$XKB_CONF_DIR/$LAYOUT_NAME"

# Remove the evdev.xml entry
xmlstarlet ed -L -d "//layout[configItem/name[text() = '$LAYOUT_NAME']]" /usr/share/X11/xkb/rules/evdev.xml

echo 'Done'