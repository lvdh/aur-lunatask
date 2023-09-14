# Maintainer: Laurens Vanderhoven <lvdh@noxy.be>

pkgname='lunatask'
pkgver=1.7.5
pkgrel=0
pkgdesc='encrypted to-do list, habit and mood tracker, journaling and notes app'
license=('proprietary')
arch=('x86_64')
url='https://lunatask.app'
source=("${url}/download/Lunatask-${pkgver}.AppImage")
sha512sums=('b4feb12374d78ca4df3f0ad52f48c02d5f8a836a7852bbf21f6a41cbf2789051ba4c5c3d99ccdca6670932a627395f2737b6ebaaaf53f01ba1bbfc36377d3b81')
options=('!strip')
depends=(
  'alsa-lib'
  'at-spi2-core'
  'bash'
  'cairo'
  'dbus-glib'
  'dbus'
  'expat'
  'gcc-libs'
  'glib2'
  'glibc'
  'gtk2'
  'gtk3'
  'hicolor-icon-theme'
  'libcups'
  'libdbusmenu-glib'
  'libdbusmenu-gtk2'
  'libdrm'
  'libindicator-gtk2'
  'libnotify'
  'libx11'
  'libxcb'
  'libxcomposite'
  'libxdamage'
  'libxext'
  'libxfixes'
  'libxkbcommon'
  'libxrandr'
  'libxss'
  'libxtst'
  'mesa'
  'nspr'
  'nss'
  'pango'
)

prepare() {
  _appimagename="${source##*/}"
  chmod +x "${_appimagename}"
  ./"${_appimagename}" --appimage-extract &>/dev/null
}

package() {
  # /opt
  install -dm755 "${pkgdir}"/opt/lunatask/
  install -Dm644 squashfs-root/LICENSE.* "${pkgdir}"/opt/lunatask/
  install -Dm755 squashfs-root/AppRun "${pkgdir}"/opt/lunatask/
  install -Dm755 squashfs-root/lunatask "${pkgdir}"/opt/lunatask/
  install -Dm644 squashfs-root/chrome*.pak "${pkgdir}"/opt/lunatask/
  install -Dm755 squashfs-root/chrome* "${pkgdir}"/opt/lunatask/
  install -Dm644 squashfs-root/*.bin "${pkgdir}"/opt/lunatask/
  install -Dm644 squashfs-root/*.dat "${pkgdir}"/opt/lunatask/
  install -Dm644 squashfs-root/*.desktop "${pkgdir}"/opt/lunatask/
  install -Dm644 squashfs-root/*.json "${pkgdir}"/opt/lunatask/
  install -Dm644 squashfs-root/*.pak "${pkgdir}"/opt/lunatask/
  install -Dm755 squashfs-root/*.so* "${pkgdir}"/opt/lunatask/
  install -dm755 "${pkgdir}"/opt/lunatask/locales/
  install -Dm644 squashfs-root/locales/*.pak "${pkgdir}"/opt/lunatask/locales/
  install -dm755 "${pkgdir}"/opt/lunatask/resources/
  install -Dm644 squashfs-root/resources/* "${pkgdir}"/opt/lunatask/resources/

  # /usr libraries
  rm -f squashfs-root/usr/lib/libindicator.so.7  # provided by 'libindicator-gtk2'
  rm -f squashfs-root/usr/lib/libXss.so.1  # provided by 'libxss'
  rm -f squashfs-root/usr/lib/libXtst.so.6  # provided by 'libxtst'
  rm -f squashfs-root/usr/lib/libnotify.so.4  # provided by 'libnotify'
  install -dm755 "${pkgdir}"/usr/lib/
  install -CDm644 squashfs-root/usr/lib/* "${pkgdir}"/usr/lib/

  # /usr icon link
  install -Dm644 squashfs-root/usr/share/icons/hicolor/512x512/apps/lunatask.png \
    "${pkgdir}"/opt/lunatask/usr/share/icons/hicolor/512x512/apps/lunatask.png
  install -dm755 "${pkgdir}"/usr/share/icons/hicolor/512x512/apps/
  ln -s /opt/lunatask/usr/share/icons/hicolor/512x512/apps/lunatask.png \
    "${pkgdir}"/usr/share/icons/hicolor/512x512/apps/lunatask.png

  # /usr binary link
  install -dm755 "${pkgdir}"/usr/bin/
  ln -s /opt/lunatask/lunatask "${pkgdir}"/usr/bin/lunatask

  # /usr autostart manifest link
  sed -i 's/Exec=AppRun --no-sandbox %U/Exec=lunatask/' \
    squashfs-root/lunatask.desktop
  install -Dm644 squashfs-root/lunatask.desktop \
    "${pkgdir}"/usr/share/applications/lunatask.desktop
}
