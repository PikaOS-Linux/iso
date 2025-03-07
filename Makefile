# Configuration settings
DISTRO_CODE?=pikaos
DISTRO_VERSION?=22.10
DISTRO_DESKTOP?=GNOME

DISTRO_EPOCH?=$(shell date +%s)
DISTRO_DATE?=$(shell date +%Y%m%d)

DISTRO_PARAMS?=

ISO_NAME?=$(DISTRO_CODE)_$(DISTRO_VERSION)_$(DISTRO_DESKTOP)

GPG_NAME?=`id -un`

# Include automatic variables
include mk/automatic.mk

# Language packages
include mk/language.mk

# Include configuration file
include config/config.mk

# Standard target - build the ISO
iso: $(ISO)

tar: $(TAR)

usb: $(USB)

# Complete target - build zsync file, SHA256SUMS, and GPG signature
all: $(ISO) $(ISO).zsync $(BUILD)/SHA256SUMS $(BUILD)/SHA256SUMS.gpg

serve: all
	cd $(BUILD) && python3 -m http.server 8909

# Clean target
include mk/clean.mk

# Germinate target
include mk/germinate.mk

# QEMU targets
include mk/qemu.mk

# Chroot targets
include mk/chroot.mk

# Update targets
include mk/update.mk

# ISO targets
include mk/iso.mk

# Force target
FORCE:
