## Update deb package (devicetree config)


```
mkdir -p deb/DEBIAN
dpkg-deb -x linux-image-4.19.12-m2z-otg-gadget_1.0-321_armhf.deb deb/
dpkg-deb -e linux-image-4.19.12-m2z-otg-gadget_1.0-321_armhf.deb deb/DEBIAN
cp bpi-m2-zero.dtb deb/usr/share/bpikernel/bpi-m2-zero-v4.dtb_4.19.12-m2z-otg-gadget
cp bpi-m2-zero.dts deb/usr/share/bpikernel/bpi-m2-zero-v4.dts_4.19.12-m2z-otg-gadget
# edit version in deb/DEBIAN/control, change deb/DEBIAN/preinst and postinst  
dpkg-deb -Z xz -b deb/ .
```

