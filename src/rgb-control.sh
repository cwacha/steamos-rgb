#!/bin/sh

OPENRGB="flatpak run org.openrgb.OpenRGB --noautoconnect"

case "$1" in
    pre|off)
        # Before sleep
        $OPENRGB -p off
        ;;
    post|on)
        # After wake
        $OPENRGB -p on
        ;;
esac
