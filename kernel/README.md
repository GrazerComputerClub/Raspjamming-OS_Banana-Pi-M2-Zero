## Compile dtb file (devicetree config)

```
sudo dtc -I dts -O dtb bpi-m2-zero.dts -o bpi-m2-zero.dtb
```


## Update deb package (devicetree config)

```
mkdir -p deb/DEBIAN
dpkg-deb -x linux-image-4.19.12-m2z-otg-gadget_1.0-521_armhf.deb deb/
dpkg-deb -e linux-image-4.19.12-m2z-otg-gadget_1.0-521_armhf.deb deb/DEBIAN
cp bpi-m2-zero.dtb deb/usr/share/bpikernel/bpi-m2-zero-v4.dtb_4.19.12-m2z-otg-gadget
cp bpi-m2-zero.dts deb/usr/share/bpikernel/bpi-m2-zero-v4.dts_4.19.12-m2z-otg-gadget
# edit version in deb/DEBIAN/control,  
# change deb/DEBIAN/preinst and postinst if needed  
dpkg-deb -Z xz -b deb/ .
```

## create from armbian kernel package 

```
mkdir -p /dev/shm/deb/DEBIAN
dpkg-deb -vx linux-image-4.19.12-m2z-otg-gadget_1.0-521_armhf.deb /dev/shm/deb/
dpkg-deb -e linux-image-4.19.12-m2z-otg-gadget_1.0-521_armhf.deb /dev/shm/deb/DEBIAN

mkdir -p  /dev/shm/linux-image-legacy-sunxi/DEBIAN
dpkg-deb -vx linux-image-legacy-sunxi_20.08.0-trunk_armhf.deb /dev/shm/linux-image-legacy-sunxi/
mkdir -p /dev/shm/linux-headers-legacy-sunxi/DEBIAN
dpkg-deb -vx linux-headers-legacy-sunxi_20.08.0-trunk_armhf.deb /dev/shm/linux-headers-legacy-sunxi/

cd /dev/shm/
mv -v linux-image-legacy-sunxi/lib/modules/4.19.129-sunxi deb/lib/modules/
mv -v linux-image-legacy-sunxi/boot/vmlinuz-4.19.129-sunxi deb/usr/share/bpikernel/zImage_4.19.129-sunxi
mv -v linux-image-legacy-sunxi/boot/config-4.19.129-sunxi deb/usr/share/bpikernel/
mv -v linux-headers-legacy-sunxi/usr/src/linux-headers-4.19.129-sunxi/ deb/usr/src/
cp bpi-m2-zero.dtb deb/usr/share/bpikernel/bpi-m2-zero.dtb_4.19.129-sunxi
cp bpi-m2-zero.dts deb/usr/share/bpikernel/bpi-m2-zero.dts_4.19.129-sunxi

remove old zImage files: deb/usr/share/bpikernel
remove old headers files: deb/usr/src
remove old modules files: deb/lib/modules

# edit version in deb/DEBIAN/control, 
# change deb/DEBIAN/preinst and postinst if needed  
dpkg-deb -Z xz -b deb/ .
```

