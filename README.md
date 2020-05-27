
# Raspjamming-Image for Banana Pi M2 Zero

![Raspjamming login screen](https://github.com/GrazerComputerClub/Banana-Pi-M2-Zero/raw/master/raspjamming20.05_bananapi.png)


## Decription

Raspjamming is a Raspbian lite based linux distribution for use at Raspberry Pi jams. Especially for use with [Raspjamming](https://raspjamming.gc2.at/) Event, organised from the [GC2 - Grazer Computer Club](https://gc2.at). 

## Main features
see [releases](https://github.com/GrazerComputerClub/Banana-Pi-M2-Zero/releases)

## Download

Go to [releases](https://github.com/GrazerComputerClub/Banana-Pi-M2-Zero/releases) to download compressed image and use [etcher](https://www.balena.io/etcher) for Linux or [Rufus](https://rufus.ie) for Windows to write it to the sd card. 
After forst boot expand filesystem with 'sudo raspi-config' (7 Advance Options -> A1 Expand Filesystem).


# Banana-Pi-M2-Zero
Repository contains Raspjamming OS files for supporting Banana Pi M2 Zero (BPI-M2 Zero) 
Special thanks to https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal for providing the original kernel data.

## Specification

* Allwinner H2+ SoC (4x Cortex-A7)
* 512 MB DDR3
* Wifi 2,4 GHz, 802.11b/g/n single-band radio (65 Mps)
* Bluetooth 4.0 (BLE)
* 40 Pin GPIO + UART

## Datasheets and Shematic:

[BPi-M2-Zero schematic](https://drive.google.com/file/d/0B4PAo2nW2KfnMW5sVkxWSW9qa28/view)  
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

* Hardware PWM
* Audio out via GPIO-PWM
* I2S
* Camera
* Support Pi-XO, xGame0-HAT

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
* UART2 (GPIO)

**To do list:**
* USB ethernet gadget: OK
* USB client: OK
* WiFi: OK
* ACT-LED: OK
* GPIO Librarys (tools)
  * WiringPi: OK
  * RPi.GPIO (python2): untested  
  * RPi.GPIO (python3): OK
  * gpiozero (python3): OK
* Remove UART2: OK
* Debug UART (UART0): OK (visible as UART2, Uboot Messages, Console)
* BT UART: unknown (visible as UART1)
* GPIO
  * GPIO RS232 (UART3): OK (visible as UART0, Kernel Messages, Console)
  * GPIO SPI0 - CS0 & CS1: OK
  * GPIO I2C-1 (400 kHz): OK
  * GPIO I/O: OK (WiringPi 2.60.200413) 
* 4K Console: OK 
* 4K X-Windows: OK (CPU overheating >77°C at idle, unuseable)
* Force HDMI 720p Resolution: NOK
* Shutdown button (PL3 - Pin355): NOK (pin ist not set correctly to input after boot, active low!) 
* Device-Tree at shell: NOK (new Kernel needed)  
* User GPIO access: NOK (new Kernel needed)  

## Pin access via sysfs

[https://linux-sunxi.org/GPIO](https://linux-sunxi.org/GPIO)  

(position of letter in alphabet - 1) * 32 + pin number  
PL3 = (12-1) *32 + 3 = 355  

echo 355 > /sys/class/gpio/export  
echo "in" > /sys/class/gpio/gpio355/direction  
cat /sys/class/gpio/gpio355/value  


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
