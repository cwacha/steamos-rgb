#!/bin/bash

TMP=`pwd`; cd `dirname $0`; BASEDIR=`pwd`; cd $TMP

all() {
    echo "# building: $app_pkgname"
    clean && import && pkg
}

_init() {
    app_pkgid="steamos-rgb"
    app_displayname="RGB control for custom Steam Machine"
    app_version="1.0.0"
    app_revision=`git rev-list --count HEAD`
    app_build=`git rev-parse --short HEAD`

    app_pkgname="$app_pkgid-$app_version-$app_revision-$app_build"
}

_template() {
    filename="$1"
    template="$2"
    
    [ -z "$template" ] && template="$filename.tpl"
    
    cat $template | sed '
    s/%app_pkgid%/'"${app_pkgid}"'/g
    s/%app_displayname%/'"${app_displayname}"'/g
    s/%app_version%/'"${app_version}"'/g
    s/%app_revision%/'"${app_revision}"'/g
    s/%app_build%/'"${app_build}"'/g
    ' > $filename
}

import() {
    echo "##### importing"
    [ -d BUILD ] && rm -rf BUILD
    deckuser=/home/deck
    rootuser=/root
    mkdir BUILD
    mkdir -p BUILD/usr/lib/systemd/system-sleep
    mkdir -p BUILD/usr/lib/systemd/system
    mkdir -p BUILD/usr/share/steamos-rgb
    
    cp ../src/rgb-control.sh BUILD/usr/lib/systemd/system-sleep
    cp ../src/rgb-control.service BUILD/usr/lib/systemd/system
    cp ../src/*.orp BUILD/usr/share/steamos-rgb
    cp ../src/org.openrgb.OpenRGB BUILD/usr/share/steamos-rgb
    
    _template PKGBUILD
}

pkg() {
    echo "##### packaging"
    
    makepkg -f
}

clean() {
    echo "##### cleaning"
    rm -rf BUILD
    rm -rf src
    rm -rf pkg
    rm -rf *.pkg.tar.zst
    rm -rf PKGBUILD
}

if [ $# -eq 0 ]; then
    echo "Usage: $0 <action>"
    echo
    echo "ACTIONS:"
    declare -F | awk '{print $3}' | grep -v ^_ | awk '{print "    "$1}'
    exit
fi

action="$1"
shift

type "$action" >/dev/null
[ $? -ne 0 ] && echo "no such action: $action" && exit 1

cd $BASEDIR
_init

$action $*
echo "##### done"
