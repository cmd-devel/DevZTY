#! /usr/bin/env sh

cd $(dirname $0)
source ./common.sh

echo 'Installing...'

if [ -f "$XKB_CONF_DIR/$LAYOUT_NAME" ]
then
    echo 'Already installed' > /dev/stderr
    exit 0
fi

# Copy the keymap to the xkb data directory
cp "$LAYOUT_NAME" "$XKB_CONF_DIR/$LAYOUT_NAME"

# Make the layout visible to desktop environments
# by adding a layout entry to evdev.xml
cp "$EVDEV_XML" ./evdev.xml.bak
echo "$EVDEV_XML backup created in the same directory as the installation script"
xmlstarlet ed -L -s '//layoutList' -t elem -n 'layout' \
                 --var node '$prev' \
                 -s '$node' -t elem -n configItem \
                 --var conf '$prev' \
                 -s '$conf' -t elem -n name -v "$LAYOUT_NAME" \
                 -s '$conf' -t elem -n shortDescription -v fr \
                 -s '$conf' -t elem -n description -v "French (Dev, $LAYOUT_NAME)" \
                 -s '$conf' -t elem -n countryList \
                 -s '$prev' -t elem -n iso3166Id -v FR \
                 -s '$conf' -t elem -n languageList \
                 -s '$prev' -t elem -n iso639Id -v fra \
                 -s '$node' -t elem -n variantList \
                 -s '$prev' -t elem -n variant \
                 -s '$prev' -t elem -n configItem \
                 --var conf2 '$prev' \
                 -s '$conf2' -t elem -n name -v main \
                 -s '$conf2' -t elem -n description -v 'AZERTY keyboard for development' \
                 "$EVDEV_XML"

echo 'Done'