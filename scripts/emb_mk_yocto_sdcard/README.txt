How to use the Embedian SD card creation script:
=================================================

This utility is provided on an "AS IS" basis.
This is the script we use to create our recovery SD card.
For machines with Android support, it is a part of a larger script we use to create our recovery SD card, which also includes Android.
It is a good example for using the output of the Yocto build to create a bootable SD card, and use it to flash the target NAND flash/eMMC.

Note:
Before running this script you need to bitbake fsl-image-gui.


Usage:
sudo MACHINE=<smarcimx8mp4g|smarcimx8mp6g> ./emb-create-yocto-sdcard.sh [options] /dev/sdX
(Change /dev/sdX to your device name)

options:
  -h            Display help message
  -s            Only show partition sizes to be written, without actually write them
  -a            Automatically set the rootfs partition size to fill the SD card
  -r            Select alternative rootfs for recovery images (default: build_x11/tmp/deploy/images/<machine name>/fsl-image-validation-imx.tar.bz2)

If you don't use the '-a' option, a default rootfs size of 3700MiB will be used.
The '-r' option allows you to create a bootable sdcard with an alternative image for the installation to NAND flash or eMMC.
Example: "-r tmp/deploy/images/<machine name>/fsl-image-qt5-validation-imx" -- selects the "Qt5 image with X11" recovery image


Once the script is done, use the SD card to boot, and then to flash your internal storage/s either use the icons,
or the following linux shell script:
install_yocto.sh
