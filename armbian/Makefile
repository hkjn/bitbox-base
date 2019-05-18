.DEFAULT_GOAL := build
.PHONY: build update clean
MAKE_PATH=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build:
	bash $(MAKE_PATH)/build.sh build
	bash $(MAKE_PATH)/../scripts/move-armbian-image.sh

update:
	bash $(MAKE_PATH)/build.sh update
	bash $(MAKE_PATH)/../scripts/move-armbian-image.sh

clean:
	rm -rf $(MAKE_PATH)/armbian/armbian-build
	bash $(MAKE_PATH)/build.sh clean

flash-emmc:
	sudo dd if=armbian-build/output/images/Armbian_5.86_Rockpro64_Debian_stretch_default_4.4.178.img of=/dev/disk/by-id/usb-Generic_STORAGE_DEVICE_000000000250-0:0 bs=64K conv=sync status=progress

scan-devices:
	nmap -sP 192.168.1.1/24

connect-serial:
	sudo picocom /dev/ttyUSB0 -b 1500000
