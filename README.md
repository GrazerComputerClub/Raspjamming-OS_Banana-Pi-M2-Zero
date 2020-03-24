# Banana-Pi-M2-Zero
Raspjamming OS files for supporting Banana Pi M2 Zero (BPI-M2 Zero) 


Special thanks to https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal for providing the original data.

## Specification:

* Allwinner H2+ SoC (4x Cortex-A7)
* 512 MB DDR3
* Wifi 2,4 GHz, 802.11b/g/n single-band radio (65 Mps)
* Bluetooth 4.0 (BLE)

## Datasheet:

[Allwinner H2+](http://wiki.friendlyarm.com/wiki/images/0/08/Allwinner_H2%2B_Datasheet_V1.2.pdf)  
[AP6212 WiFi+BT](http://wiki.friendlyarm.com/wiki/images/5/57/AP6212_V1.1_09022014.pdf)  

## Links

[U-Boot](https://linux-sunxi.org/U-Boot)  
[U-Boot: Quick reference](https://mediawiki.compulab.com/index.php/U-Boot:_Quick_reference)  
[Kernel arguments](https://linux-sunxi.org/Kernel_arguments)  
[Getting Started with M2 Zero](http://wiki.banana-pi.org/Getting_Started_with_M2_Zero)  


## Status Raspjamming OS

Kernel: 4.19.12  
ARM-CPU clock speed: 120 - 1008 MHz  
Active cores: 2  
GPU Memory: 16 MB  
Memory: 496 MB  

**Features disabled:**
* Ethernet (eth0)
* 2-Cores
* SPI1
* UART2

**To do list:**
* USB Ethernet gadget: OK
* Wifi: OK
* ACT-LED: OK
* WiringPi: NOK
* RPi.GPIO: NOK
* SPI1 - CS0 & CS1: NOK
* RS232 (UART3): need test
* Remove UART2: OK

**Consumption:**  
Idle  : 140 mA  
1-core: 260 mA (60 °C)  
2-core: 320 mA (70 °C, max. CPU temperature, CPU freq. adjustment active)  

**nBench mean value:**  
1008 MHz ... 5,868  
 960 MHz ... 5,602  
 816 MHz ... 4,762
 
