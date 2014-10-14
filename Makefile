FW_DIR	:= /lib/firmware/
MDL_DIR	:= /lib/modules/$(shell uname -r)
DRV_DIR	:= $(MDL_DIR)/kernel/drivers/bluetooth
KVERSION := $(shell uname -r)

ifneq ($(KERNELRELEASE),)

	obj-m := btusb.o

else
	PWD := $(shell pwd)
	KVER := $(shell uname -r)
	KDIR := /lib/modules/$(KVER)/build

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules
	@cp -f rtl8723a_fw.bin $(FW_DIR)/.
	@cp -f rtl8723b_fw.bin $(FW_DIR)/.
	@cp -f rtl8821a_fw.bin $(FW_DIR)/.
	@cp -f rtl8761a_fw.bin $(FW_DIR)/.
	@cp -f rtl8723a_fw.bin $(FW_DIR)/rtl8723a_fw
	@cp -f rtl8723b_fw.bin $(FW_DIR)/rtl8723b_fw
	@cp -f rtl8821a_fw.bin $(FW_DIR)/rtl8821a_fw
	@cp -f rtl8761a_fw.bin $(FW_DIR)/rtl8761a_fw

clean:
	rm -rf *.o *.mod.c *.mod.o *.ko *.symvers *.order *.a
endif

install:
	@mkdir -p $(FW_DIR)
	@cp -f rtl8723a_fw.bin $(FW_DIR)/.
	@cp -f rtl8723b_fw.bin $(FW_DIR)/.
	@cp -f rtl8821a_fw.bin $(FW_DIR)/.
	@cp -f rtl8761a_fw.bin $(FW_DIR)/.
	@cp -f rtl8723a_fw.bin $(FW_DIR)/rtl8723a_fw
	@cp -f rtl8723b_fw.bin $(FW_DIR)/rtl8723b_fw
	@cp -f rtl8821a_fw.bin $(FW_DIR)/rtl8821a_fw
	@cp -f rtl8761a_fw.bin $(FW_DIR)/rtl8761a_fw
	@cp -f btusb.ko $(DRV_DIR)/btusb.ko
	depmod -a $(MDL_DIR)
	@echo "installed revised btusb"

uninstall:
	rm -f $(DRV_DIR)/btusb.ko
	depmod -a $(MDL_DIR)
	echo "uninstalled revised btusb"
