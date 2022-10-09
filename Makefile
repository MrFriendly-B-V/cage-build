all: cage-build

.PHONY: seatd-deps
seatd-deps:
	sudo apt install -y -qq \
		cmake \
		pkg-config \
		libsystemd-dev

seatd:
	git clone https://git.sr.ht/~kennylevinsen/seatd seatd/

.PHONY: seatd-build
seatd-build: seatd seatd-deps
	cd seatd && \
		meson build/ -Dlibseat-logind=systemd -Dexamples=disabled -Dman-pages=disabled --buildtype=release && \
		ninja -C build/ && \
		sudo ninja -C build/ install

.PHONY: wlroots-deps
wlroots-deps: seatd-build
	sudo apt install -y -qq \
		libwayland-dev \
		wayland-protocols \
		libegl-dev \
		libgles-dev \
		libdrm-dev \
		libgbm-dev \
		libinput-dev \
		libxkbcommon-dev \
		libudev-dev \
		libpixman-1-dev \
		xwayland \
		libxcb-composite0-dev \
		libxcb-dri3-dev \
		libxcb-icccm4-dev \
		libxcb-res0-dev

wlroots:
	git clone https://gitlab.freedesktop.org/wlroots/wlroots.git wlroots/
	cd wlroots && \
		git checkout 0.14.0

.PHONY: wlroots-build
wlroots-build: wlroots wlroots-deps
	cd wlroots && \
		meson build/ -Dxwayland=enabled -Dexamples=false --buildtype=release && \
		ninja -C build/ && \
		sudo ninja -C build/ install

.PHONY: cage-deps
cage-deps: wlroots-build

cage:
	git clone https://github.com/Hjdskes/cage.git cage/
	cd cage && \
		git checkout v0.1.4

cage-build: cage cage-deps
	cd cage && \
		meson build -Dman-pages=disabled -Dxwayland=true --buildtype=release && \
		ninja -C build && \
		sudo ninja -C build/ install
