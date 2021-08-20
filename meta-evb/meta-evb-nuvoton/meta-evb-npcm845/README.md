Nuvoton NPCM845 Evaluation Board
================

This is the Nuvoton NPCM845 evaluation board layer.
The NPCM845 is an ARM based SoC with external DDR RAM and 
supports a large set of peripherals made by Nuvoton. 

# Dependencies
This layer depends on:

```
  URI: github.com/NNuvoton-Israel/openbmc.git
  branch: npcm-v2.10
```

# Contacts for Patches

Please submit any patches against the meta-evb-npcm845 layer to the maintainer of nuvoton:
* Joseph Liu, <KWLIU@nuvoton.com>
* Stanley Chu, <YSCHU@nuvoton.com>
* Tyrone Ting, <KFTING@nuvoton.com>
* Medad Cchien, <CTCCHIEN@nuvoton.com>

# Table of Contents

- [Dependencies](#dependencies)
- [Contacts for Patches](#contacts-for-patches)
- [Getting Started](#getting-started)
  * [Setting up EVB](#setting-up-evb)
  * [Building your OpenBMC project](#building-your-openbmc-project)
  * [Programming Firmware for the first time](#programming-firmware-for-the-first-time)
    + [Bootloader](#bootloader)
    + [OpenBMC](#openbmc)

# Getting Started

## Setting up EVB

### 1) Strap settings
* By default, only turn on strap 4 of the SW_STRAP1_8 dip switch.
* The other straps remain off.

### 2) Power Source selector
* JP_5V_SEL set to 1-2, If On-Board VR(12V->5V) is used to power the EVB (<span style="color: green">Remcommanded)
* JP_5V_SEL set to 2-3, If USB VBUS is used to power the EVB

### 3) BMC Console

* Connect a Mini-USB cable to J_USB_TO_UART
* You will get 4 serial port options from your terminal settings.
* Please select second serial port and set baud rate to 115200.
* After EVB is powered on, you will get BMC logs from the terminal.

### 4) Secure boot status
* When you see the following BMC message, it means that secure boot is enabled.
```ruby
Nuvoton Technologies: BMC NPCM8XX
.....
.....
TipROM 0x104 ** Secure boot is enabled
.....
.....
```

## Building your OpenBMC project

### 1) Target EVB NPCM845
Source the setup script as follows:
```ruby
. setup evb-npcm845
```

### 2) Configuration

If secure boot is enabled, please enable [SECURED TIPFW](https://github.com/Nuvoton-Israel/openbmc/blob/npcm-v2.10/meta-evb/meta-evb-nuvoton/meta-evb-npcm845/conf/machine/evb-npcm845.conf#L8)
```ruby
SECURED_TIPFW = "True"
```

To enable memory ECC function, please enable [MC_CAPABILITY_ECC_EN](https://github.com/Nuvoton-Israel/openbmc/blob/npcm-v2.10/meta-nuvoton/recipes-bsp/images/npcm8xx-igps/BootBlockAndHeader_ArbelEVB.xml#L181)
```ruby
<BinField>
	<!-- MC_CONFIG. 
		Bit 0: MC_CAPABILITY_ECC_EN (0x01)
		 -->
	<name>MC_CONFIG</name>          
	<config>
		<offset>0x134</offset>       
		<size>0x1</size> 
	</config>
	<content format='32bit'>0x01</content>  
</BinField>
```
### 3) Build
[Inventory manager distro](https://github.com/openbmc/phosphor-inventory-manager)
```
bitbake obmc-phosphor-image
```

[Entity manager distro](https://github.com/openbmc/entity-manager)
```
DISTRO=arbel-evb-entity bitbake obmc-phosphor-image
```

## Programming Firmware for the first time

### Bootloader

#### Flashing through IGPS
Python 2.7 is required.<br/>

1. Setting up:
* Connect a Mini-USB cable to J_USB_TO_UART 
* Turn on strap 9 of the SW_STRAP9-16 dip switch and issue power-on reset

2. Image programming:
* Non scure boot
```
python ./ProgramAll_Basic.py
```

* Secure boot is enabled
```
python ./ProgramAll_Secure.py
```
### OpenBMC

#### Flash in UBOOT

* User can program bootloader or openbmc image in u-boot.
* Because the flash 0 size of EVB is smaller than the openbmc image, so the full openbmc image will be programmed to EVB flash 1.
* Therefore, the openbmc is booted from flash 1.

1. Setting up:
* Power on your EVB and stop BMC at u-boot stage.
* Prepare an ethernet cable and connect to J_SGMII

* Set BMC ip and tftp server ip in uboot env
```ruby
setenv gatewayip            192.168.0.254
setenv serverip             192.168.0.128
setenv ipaddr               192.168.0.12
setenv netmask              255.255.255.0
```
* Set bootargs in uboot env
```ruby
setenv autoload  no
setenv autostart no
setenv baudrate 115200
setenv bootcmd 'run romboot'
setenv bootdelay 2
setenv common_bootargs 'setenv bootargs earlycon=${earlycon} root=/dev/ram0 console=${console} mem=${mem}'
setenv console 'ttyS0,115200n8'
setenv earlycon 'uart8250,mmio32,0xf0000000'
setenv mem 880M
setenv romboot 'sf probe 0:1; run common_bootargs; echo Booting Kernel from flash; echo +++ uimage at 0x${uimage_flash_addr}; echo Using bootargs: ${bootargs};bootm ${uimage_flash_addr}'
setenv stderr serial
setenv stdin serial
setenv stdout serial
setenv uimage_flash_addr 0x88200000
```
* Save uboot env to flash
```ruby
saveenv
```

2. Image programming:

* Flash full openbmc image
```ruby
sf probe 0:1
setenv ethact gmac2
tftp 10000000 image-bmc
cp.b 0x10000000 0x88000000 ${filesize}
```

* Flash linux kernel
```ruby
sf probe 0:1
setenv ethact gmac2
tftp 10000000 image-kernel
cp.b 0x10000000 0x88200000 ${filesize}
```

* Flash bootloader
```ruby
setenv ethact gmac2
tftp 10000000 image-u-boot
cp.b 0x10000000 0x80000000 ${filesize}
```

3. Booting to OpenBMC:

* Enter boot command
```ruby
run romboot
```

4. OpenBMC Login Prompts.

* User: root
* Password: 0penBmc
```ruby
[  OK  ] Reached target Login Prompts.

Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro) 0.1.0 evb-npcm845 ttyS0

evb-npcm845 login:
```
