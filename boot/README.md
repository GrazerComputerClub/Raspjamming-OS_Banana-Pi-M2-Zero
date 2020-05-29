## create u-boot configuration

```
sudo mkimage -C none -A arm -T script -d bpi-m2-zero_boot.cmd boot.scr
```

## install u-boot to partition

```
dd if=bootloader_uboot.bin conv=notrunc bs=1k seek=8 of=/dev/?
```

or

run ``flash_sdcard_m2z_uboot.sh``