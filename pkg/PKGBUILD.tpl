# Maintainer: Clemens Wacha <clemens@wacha.ch>
pkgname=%app_pkgid%
pkgver=%app_version%
pkgrel=%app_revision%
epoch=
pkgdesc="%app_displayname%"
arch=('any')
url="https://github.com/cwacha/steamos-rgb"
license=('GPL')
groups=()
depends=()
makedepends=()
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=('!debug')
install=package.install
changelog=
source=()
noextract=()
sha256sums=()
validpgpkeys=()

package() {
	cp -R $startdir/BUILD/* $pkgdir
}
