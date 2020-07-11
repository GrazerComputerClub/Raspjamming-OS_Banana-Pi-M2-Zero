# Compile with:
# sudo mkimage -C none -A arm -T script -d bpi-m2-zero_boot.cmd boot.scr

#gpio set PD14
#gpio status PD14
setenv fsck.repair yes
setenv ramdisk initrd.img
setenv kernel zImage

setenv env_addr 0x45000000
setenv kernel_addr 0x46000000
setenv ramdisk_addr 0x47000000
setenv dtb_addr 0x48000000
setenv initrd_high 0xffffffff

fatload mmc 0 ${kernel_addr} ${kernel}
fatload mmc 0 ${ramdisk_addr} ${ramdisk}
setenv ramdisk_size ${filesize}
fatload mmc 0 ${dtb_addr} bpi-m2-zero.dtb
fdt addr ${dtb_addr}

# setup MAC address 
fdt set ethernet0 local-mac-address ${mac_node}

# setup boot_device
fdt set mmc${boot_mmc} boot_device <1>

setenv disp_mode "1280x720p60"
setenv extra "hdmi.audio=EDID:0 disp.screen0_output_mode=${disp_mode} sunxi_ve_mem_reserve=0 sunxi_g2d_mem_reserve=0 sunxi_fb_mem_reserve=16"
# no_console_suspend consoleblank=0
setenv bootargs "console=ttyS0,115200 earlyprintk rootfstype=ext4 root=/dev/mmcblk0p2 rw rootwait fsck.repair=${fsck.repair} panic=10 ${extra} modules-load=g_ether,brcmfmac g_ether.host_addr=00:01:02:03:04:05 g_ether.dev_addr=00:01:02:03:04:06 g_ether.use_eem=0 g_ether.iManufacturer=RaspjammingOS"
bootz ${kernel_addr} ${ramdisk_addr}:${ramdisk_size} ${dtb_addr}

