# Banana-Pi-M2-Zero
Raspjamming OS files for supporting Banana Pi M2 Zero (BPI-M2 Zero) 

Special thanks to https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal for providing the original data.

## Specification

* Allwinner H2+ SoC (4x Cortex-A7)
* 512 MB DDR3
* Wifi 2,4 GHz, 802.11b/g/n single-band radio (65 Mps)
* Bluetooth 4.0 (BLE)
* 40 Pin GPIO + UART

## Datasheet:

[Allwinner H2+](http://wiki.friendlyarm.com/wiki/images/0/08/Allwinner_H2%2B_Datasheet_V1.2.pdf)  
[AP6212 WiFi+BT](http://wiki.friendlyarm.com/wiki/images/5/57/AP6212_V1.1_09022014.pdf)  

## Links

[U-Boot](https://linux-sunxi.org/U-Boot)  
[U-Boot: Quick reference](https://mediawiki.compulab.com/index.php/U-Boot:_Quick_reference)  
[Kernel arguments](https://linux-sunxi.org/Kernel_arguments)  
[Getting Started with M2 Zero](http://wiki.banana-pi.org/Getting_Started_with_M2_Zero)  


## Project goal

* Get as near as possible to Raspbbery Pi Zero W (replacement)
* 100% GPIO compatible to Raspberry Pi
* Support GC2-xHAT
* Support USB-HAT

**unlikely/impossible:**

* Support Pi-XO, xGame0-HAT
* Audio out via GPIO-PWM
* I2S

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
* USB client: NOK
* Wifi: OK
* ACT-LED: OK
* WiringPi: under develop
* RPi.GPIO: NOK
* SPI0 - CS0: OK
* SPI0 - CS1: NOK (software workaround?)
* GPIO RS232 (UART3): OK (Console)
* Remove UART2: OK?
* Remove UART0: OK (Console)
* GPIO UART: OK
* GPIO SPI0, cs0, cs1: need test
* GPIO I2C: need test
* GPIO I/O: need test
* 4K Console: OK
* 4K X-Windows: OK (CPU overheating >77°C at idle)
* Force HDMI: NOK

## Measurements

### Consumption & temperature (22 °C ambient):  

**Banana Pi M2 Zero**  

Console/no Video:  
Idle           : 140 mA (47 °C)  
1-core (stress): 260 mA (60 °C)  
2-core (stress): 320 mA (70 °C, max. CPU temperature, CPU freq. adjustment active 816-1008 MHz)  
4K X-Windows:  
Idle           : 350 mA (77 °C, CPU overheated, CPU freq. adjustment active 120 MHz)  

**Raspberry Pi Zero W**  

Idle           : 110 mA (38 °C)  
1-core (stress): 190 mA (45 °C)  

### CPU Performance (nBench mean value):  

**Banana Pi M2 Zero**  

1008 MHz: 5,868  
960 MHz: 5,602  
816 MHz: 4,762  

**Raspberry Pi**  

Pi 2 ,  900 MHz: 5,2  
Pi Zero, 1150 MHz: 4,662  
Pi Zero, 1000 MHz: 4,010  
