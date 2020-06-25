
# Raspjamming OS for Banana Pi M2 Zero

![Raspjamming login screen](https://github.com/GrazerComputerClub/Banana-Pi-M2-Zero/raw/master/RaspjammingOS20.06_BPi_M2Z.png)


## Decription

Raspjamming OS is a Raspberry Pi OS (32-bit) Lite based linux distribution for use at Raspberry Pi jams. Especially for use with [Raspjamming-Event](https://raspjamming.gc2.at/), organised from the [GC2 - Grazer Computer Club](https://gc2.at). 

## Main features
see [releases](https://github.com/GrazerComputerClub/Raspjamming-OS_Banana-Pi-M2-Zero/releases)

## Download

Go to [releases](https://github.com/GrazerComputerClub/Raspjamming-OS_Banana-Pi-M2-Zero/releases) to download compressed image and use [etcher](https://www.balena.io/etcher) for Linux or [Rufus](https://rufus.ie) for Windows to write it to sd card. 
After first boot expand filesystem with 'sudo raspi-config' (7 Advance Options -> A1 Expand Filesystem).


# Banana-Pi-M2-Zero
Repository contains Raspjamming OS files for supporting Banana Pi M2 Zero (BPI-M2 Zero) 
Special thanks to https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal for providing the first kernel data  
Special thanks to https://www.armbian.com for providing Kernel 4 build system


## Specification

* Allwinner H2+ SoC (4x Cortex-A7)
* 512 MB DDR3
* Wifi 2,4 GHz, 802.11b/g/n single-band radio (65 Mps)
* Bluetooth 4.0 (BLE)
* 40 Pin GPIO + UART

## Datasheets and schematic

[BPi-M2-Zero schematic](https://drive.google.com/file/d/0B4PAo2nW2KfnMW5sVkxWSW9qa28/view)  
[Allwinner H2+](http://wiki.friendlyarm.com/wiki/images/0/08/Allwinner_H2%2B_Datasheet_V1.2.pdf)  
[AP6212 WiFi+BT](http://wiki.friendlyarm.com/wiki/images/5/57/AP6212_V1.1_09022014.pdf)  

## Links

[U-Boot](https://linux-sunxi.org/U-Boot)  
[U-Boot: Quick reference](https://mediawiki.compulab.com/index.php/U-Boot:_Quick_reference)  
[Kernel arguments](https://linux-sunxi.org/Kernel_arguments)  
[Getting Started with M2 Zero](http://wiki.banana-pi.org/Getting_Started_with_M2_Zero)  

## GPIO - numbers (WiringPi)

![WiringPi gpio readall](https://github.com/GrazerComputerClub/Banana-Pi-M2-Zero/raw/master/BananaPiM2ZeroWiringPi.png)


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

Kernel: 4.19.129 / 4.19.12  
ARM-CPU clock speed: 120 - 1008 MHz  
Active cores: 2  
GPU Memory: 16 MB  
Memory: 496 MB  

**Features disabled:**
* Ethernet (eth0)
* 2-Cores
* SPI1
* UART2 (GPIO) - to do - need dtd update

**To do list:**
* USB ethernet gadget: OK
* USB client: OK
* WiFi: OK
* ACT-LED: OK
* Shutdown button (PL3 - Pin355): **NOK** (pin ist not set correctly to input after boot, maybe edge mode? active low!) 
* GPIO Librarys (tools)
  * WiringPi: OK
  * WiringPi - ISR: untested, missing?
  * C# - WiringPi wrapper: untested 
  * RPi.GPIO (python2): untested  
  * RPi.GPIO (python3): OK
  * RPi.GPIO (python3) - Event: **NOK** (not implemented)
  * gpiozero (python3): OK (but events not working)
  * libgpiod: untested
* Remove UART2: OK
* Debug UART (UART0): OK (visible as UART2, Uboot Messages, Console)
* BT: unknown
* BT UART: unknown (visible as UART1)
* GPIO
  * GPIO RS232 (UART3): OK (visible as UART0, Kernel Messages, Console)
  * GPIO SPI0 - CS0 & CS1: OK
  * GPIO I2C-1 (400 kHz): OK
  * GPIO I/O: OK (WiringPi 2.60.200413) 
  * GPIO init: **NOK** (GPIOs not set correctly to input mode after boot)
  * GPIO pullup: **NOK** (Raspberry Pi, GPIO00-GPIO07 pull-up is activated default)
  * GPIO Event/ISR: OK
* GC2xHAT: 
  * HC-SR04 - C/C#: NOK (C# invalid values)
  * HC-SR04 - gpiozero(Python3): NOK (event missing)
  * 3xSwitch: OK
  * LEDs: OK
  * TM1637: OK (some errors)
  * Power 3.3V: OK (but default on, rpi default off)
  * DHT: NOK (C# ok, C nok)
  * ATMEGA: NOK (resetpin must be set to 2, but still reading device id wrong - spi error?) 
  * ESP01: ?
  * AM2320.py: NOK ('board not supported' error)
  * HAT EEPROM: NOK (manuel implementation needed)  
* 4K Console: OK 
* 4K X-Windows: OK (CPU overheating >77°C at idle, unuseable)
* Force HDMI 720p Resolution: **NOK**
* Device-Tree at shell: NOK (new Kernel needed)  
* User GPIO access: NOK (new Kernel needed)
* Application tests:
  * mplayer: OK
  * emulator Gamebatte: OK 
  * emulator PicoDrive: OK
  * PICO-8: OK
  * armbianmonitor: OK
  
## Pin access via sysfs

[https://linux-sunxi.org/GPIO](https://linux-sunxi.org/GPIO)  

(position of letter in alphabet - 1) * 32 + pin number  
PL3 = (12-1) *32 + 3 = 355  

echo 355 > /sys/class/gpio/export  
echo "in" > /sys/class/gpio/gpio355/direction  
cat /sys/class/gpio/gpio355/value  

### strange behavior (sysfs and wringpi)

``echo 0 > /sys/class/gpio/export``  
``echo "in" > /sys/class/gpio/gpio0/direction``  changes wiringpi GPIO Mode to 'IN'  
``cat /sys/class/gpio/gpio0/value``  changes wiringpi GPIO Mode to 'ALT2'  
It looks like wiringPi can not read wenn Mode 'ALT2' is active (always zero).  
**This creates following error:** If event/ISR is activated on GPIO, reading the input is not possible anymore.


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
nbench.txt
**Banana Pi M2 Zero**  

1008 MHz: 5,868  [results](https://github.com/GrazerComputerClub/Banana-Pi-M2-Zero/raw/master/nbench.txt) 
960 MHz: 5,602  
816 MHz: 4,762  

**Raspberry Pi**  

Pi 2 ,  900 MHz: 5,2  
Pi Zero, 1150 MHz: 4,662  
Pi Zero, 1000 MHz: 4,010  

for more benchmark results please see github [Benchmark](https://github.com/GrazerComputerClub/Benchmark) repro

## Read HAT

```
i2cdump -y 0 0x50 c  
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef  
00: 52 2d 50 69 01 00 02 00 8c 00 00 00 01 00 00 00    R-Pi?.?.?...?...  
10: 50 00 00 00 01 dc 73 71 97 89 f3 91 3a 40 5f 8c    P...??sq????:@_?  
20: 00 75 ec 91 20 6c 00 01 1e 1a 47 72 61 7a 65 72    .u?? l.???Grazer  
30: 20 43 6f 6d 70 75 74 65 72 20 43 6c 75 62 20 28     Computer Club (  
40: 41 75 73 74 72 69 61 29 47 43 32 2d 78 48 41 54    Austria)GC2-xHAT  
50: 20 28 52 61 73 70 6a 61 6d 6d 69 6e 67 20 48 41     (Raspjamming HA  
60: 54 29 de f1 02 00 01 00 20 00 00 00 00 00 00 00    T)???.?. .......  
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................  
80: 00 00 00 00 00 00 00 00 00 00 ed 6e 00 00 00 00    ..........?n....  
```

0x28 ... length organisation  
0x29 ... length product  
0x2A ... organisation & product
