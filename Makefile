# SONiX UVC Like Driver Makefile

KERNEL_VERSION    := `uname -r`
#KERNEL_VERSION    := linux-headers-2.6.32-28-generic
#KERNEL_DIR        := /usr/src/$(KERNEL_VERSION)
KERNEL_DIR        := /usr/src/linux-headers-$(KERNEL_VERSION)
#INSTALL_MOD_DIR   := usb/media
INSTALL_MOD_DIR	  :=/lib/modules/$(uname -r)/kernel/drivers/media/video/uvc
 

PWD        := $(shell pwd)

obj-m        := uvcvideo.o

uvcvideo-objs := uvc_driver.o uvc_queue.o uvc_v4l2.o uvc_video.o uvc_ctrl.o uvc_status.o uvc_isight.o

obj-$(CONFIG_USB_VIDEO_CLASS) += uvcvideo.o

uvcvideo:
	@echo "Building USB Video Class driver..."

	@(make -C $(KERNEL_DIR) M=$(PWD) ARCH=x86 CROSS_COMPILE=$(CROSS_COMPILE) modules)

install:
	@echo "Installing USB Video Class driver..."
	@(make -C $(KERNEL_DIR) M=$(PWD) INSTALL_MOD_DIR=$(INSTALL_MOD_DIR) INSTALL_MOD_PATH=$(INSTALL_MOD_PATH) modules_install)


clean:
	-rm -f *.o *.ko .*.cmd .*.flags *.mod.c Module.symvers version.h modules.order
	-rm -rf .tmp_versions

