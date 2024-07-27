set -e

XKB_CONF_DIR="/usr/share/X11/xkb/symbols"
EVDEV_XML="/usr/share/X11/xkb/rules/evdev.xml"
LAYOUT_NAME='devzty'

if [ ! -f "$EVDEV_XML" ]
then
    echo "Failed to install the layout, config file not found : $EVDEV_XML" > /dev/stderr
    exit 1
fi

if ! command -v xmlstarlet &> /dev/null
then
    echo "xmlstarlet command not found" > /dev/stderr
    exit 1
fi
