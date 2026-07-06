#!/bin/sh

OPENRGB="flatpak run org.openrgb.OpenRGB --noautoconnect"

case "$1" in
    pre)
        # Before sleep
        $OPENRGB -p off
        ;;
    post)
        # After wake
        $OPENRGB -p on
        ;;
esac
