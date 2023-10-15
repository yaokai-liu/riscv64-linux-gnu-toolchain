TARGET := riscv64-linux-gnu

PKGS := linux-api-headers binutils gcc gdb glibc

define install
endef

define updatesums
endef

.PHONY: clean download update-sums install restore

.DEFAULT: download

install: update-sums
	for pkg in $(PKGS); do \
		cd $$pkg/trunk; \
		makepkg --printsrcinfo > .SRCINFO; \
		makepkg -i -C --noconfirm; \
		cd ../..; \
	done



update-sums: $(PKGS)
	for pkg in $(PKGS); do \
		updpkgsums $$pkg/trunk/PKGBUILD; \
	done



restore: $(PKGS)
	for pkg in $(PKGS); do \
		cp -r $$pkg/trunk/* $$pkg/repos/; \
	done



clean:
	rm -rf .SRCINFO
	rm -rf */trunk/{.SRCINFO,*.tar.*,*.sign,pkg,src}
	rm -rf all


