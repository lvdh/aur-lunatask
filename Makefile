.PHONY: clean deps chroot unchroot build tree-source tree-package pkgfile
.PHONY: install dryuninstall uninstall reinstall

APPIMAGE=Lunatask-*.AppImage
PKG=lunatask-*.pkg
CHROOT=/mnt/chroots/arch

clean:
	rm -f .BUILDINFO .MTREE .PKGINFO PKGBUILD-*.log
	rm -f Lunatask-* lunatask-*
	rm -rf pkg/ squashfs-root/
deps:
	which extra-x86_64-build || yay -S extra/devtools
chroot:
	test -d $(CHROOT) || sudo mount --mkdir -t tmpfs -o defaults,size=20G tmpfs $(CHROOT)
build: deps chroot clean
	extra-x86_64-build -c -r $(CHROOT)
unchroot:
	sudo umount $(CHROOT)
tree-source:
	./$(APPIMAGE) --appimage-extract &>/dev/null
	tree -fap squashfs-root/
tree-package:
	mkdir pkg/ || rm -rf pkg/*
	unzstd -f $(PKG).tar.zst
	tar xvf $(PKG).tar -C pkg/
	tree -fap pkg/
pkgfile:
	pkgfile --update
install:
	sudo pacman -U $(PKG).tar.zst
dryuninstall:
	sudo pacman -R --recursive --print $(PKG).tar.zst
uninstall:
	sudo pacman -R --recursive --nosave lunatask || exit 0
reinstall: uninstall install
