#!/bin/bash

sudo service klipper stop
cd ~/klipper

# Update MCU RPi
echo "Start update MCU RPi"
echo ""
make clean
# Uncomment if menuconfig changes
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
make KCONFIG=/home/pi/klipper_config/script/config.linux_mcu
read -p "MCU RPi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash KCONFIG_CONFIG=/home/pi/klipper_config/script/config.linux_mcu
echo "Finish update MCU RPi"
echo ""

# Update MCU BTT EBB36
echo "Start update BTT EBB36"
echo ""
make clean
# Uncomment if menuconfig changes
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.btt_ebb36
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.btt_ebb36
read -p "MCU BTT EBB36 firmware built, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
python3 /home/pi/katapult/scripts/flash_can.py -f ./out/klipper.bin -u a5972f9dc61c
read -p "MCU BTT EBB36 firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
echo "Finish update MCU BTT EBB36"
echo ""

# Update MCU BTT Octopus
echo "Start update BTT Octopus"
echo ""
make clean
# Uncomment if menuconfig changes
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.btt_octopus
make KCONFIG_CONFIG=/home/pi/klipper_config/script/config.btt_octopus
read -p "MCU BTT Octopus firmware built, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
python3 /home/pi/katapult/scripts/flash_can.py -f ./out/klipper.bin -d /dev/serial/by-id/usb-katapult_stm32f446xx_2F0040000650534E4E313020-if00
read -p "MCU BTT Octopus firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
echo "Finish update MCU BTT Octopus"
echo ""

sudo service klipper start
