#!/bin/bash -e

blue_underlined_bold_echo()
{
	echo -e "\e[34m\e[4m\e[1m$@\e[0m"
}

blue_bold_echo()
{
	echo -e "\e[34m\e[1m$@\e[0m"
}

red_bold_echo()
{
	echo -e "\e[31m\e[1m$@\e[0m"
}

IMGS_PATH=/opt/images/Yocto
UBOOT_IMAGE=imx-boot-sd.bin
KERNEL_IMAGE=Image
ROOTFS_IMAGE=rootfs.tar.bz2
BOOTLOADER_RESERVED_SIZE=4
PART1_SIZE=48
BOOTLOADER_OFFSET=32
DISPLAY=-hdmi
PART=p
BOOTPART=1
ROOTFSPART=2
BOOTDIR=/boot

check_board()
{
	if grep -q "i.MX8MP" /sys/devices/soc0/soc_id; then
		BOARD=smarc-imx8mp
		DTB_PREFIX=imx8mp-smarc
		BLOCK=mmcblk2

		if [[ $DISPLAY != "-lvds" && $DISPLAY != "-hdmi" && \
		      $DISPLAY != "" ]]; then
			red_bold_echo "ERROR: invalid display, should be lvds, hdmi or empty"
			exit 1
		fi
	else
		red_bold_echo "ERROR: Unsupported board"
		exit 1	
	fi


	if [[ ! -b /dev/${BLOCK} ]] ; then
		red_bold_echo "ERROR: Can't find eMMC device (/dev/${BLOCK})."
		red_bold_echo "Please verify you are using the correct options for your SMARC Module."
		exit 1
	fi
}

check_images()
{
	if [[ ! -f $IMGS_PATH/$UBOOT_IMAGE ]] ; then
		red_bold_echo "ERROR: \"$IMGS_PATH/$UBOOT_IMAGE\" does not exist"
		exit 1
	fi

        if [[ ! -f $IMGS_PATH/$KERNEL_IMAGE ]] ; then
                red_bold_echo "ERROR: \"$IMGS_PATH/$KERNEL_IMAGE\" does not exist"
                exit 1
        fi

        if [[ ! -f $IMGS_PATH/${DTB_PREFIX}${DISPLAY}.dtb ]] ; then
                red_bold_echo "ERROR: \"$IMGS_PATH/${DTB_PREFIX}${DISPLAY}.dtb\" does not exist"
                exit 1
        fi

        if [[ ! -f $IMGS_PATH/uEnv.txt ]] ; then
                red_bold_echo "ERROR: \"$IMGS_PATH/uEnv.txt\" does not exist"
                exit 1
        fi

	if [[ ! -f $IMGS_PATH/$ROOTFS_IMAGE ]] ; then
		red_bold_echo "ERROR: \"$IMGS_PATH/$ROOTFS_IMAGE\" does not exist"
		exit 1
	fi
}

delete_emmc()
{
	echo
	blue_underlined_bold_echo "Deleting current partitions"

	umount /dev/${BLOCK}${PART}* 2>/dev/null || true

	for ((i=1; i<=16; i++)); do
		if [[ -e /dev/${BLOCK}${PART}${i} ]]; then
			dd if=/dev/zero of=/dev/${BLOCK}${PART}${i} bs=1M count=1 2>/dev/null || true
		fi
	done
	sync

	dd if=/dev/zero of=/dev/${BLOCK} bs=1M count=${BOOTLOADER_RESERVED_SIZE}

	sync; sleep 1
}

create_emmc_parts()
{
	echo
	blue_underlined_bold_echo "Creating new partitions"

	SECT_SIZE_BYTES=`cat /sys/block/${BLOCK}/queue/hw_sector_size`
	PART1_FIRST_SECT=$(($BOOTLOADER_RESERVED_SIZE * 1024 * 1024 / $SECT_SIZE_BYTES))
        PART1_END_SECT=$((($BOOTLOADER_RESERVED_SIZE + $PART1_SIZE) * 1024 * 1024 / $SECT_SIZE_BYTES))
	PART2_FIRST_SECT=`expr ${PART1_END_SECT} + 1`

	(echo n; echo p; echo $BOOTPART; echo $PART1_FIRST_SECT; \
	 echo $PART1_END_SECT; echo n; echo p; echo $ROOTFSPART; \
	 echo $PART2_FIRST_SECT; echo; \
	 echo p; echo w) | fdisk -u /dev/${BLOCK} > /dev/null

	sync; sleep 1
	fdisk -u -l /dev/${BLOCK}
}

format_emmc_parts()
{
	echo
	blue_underlined_bold_echo "Formatting partitions"

        mkfs.vfat -F 16 /dev/${BLOCK}${PART}${BOOTPART} -n boot
	mkfs.ext4 /dev/${BLOCK}${PART}${ROOTFSPART} -L rootfs

	sync; sleep 1
}

install_bootloader_to_emmc()
{
	echo
	blue_underlined_bold_echo "Installing booloader"

	dd if=${IMGS_PATH}/${UBOOT_IMAGE} of=/dev/${BLOCK} bs=1K seek=${BOOTLOADER_OFFSET}
	sync
}

install_kernel_to_emmc()
{
        echo
        blue_underlined_bold_echo "Installing kernel"

        MOUNTDIR=/run/media/${BLOCK}${PART}${BOOTPART}
        mkdir -p ${MOUNTDIR}
        mount /dev/${BLOCK}${PART}${BOOTPART} ${MOUNTDIR}
	mkdir -p ${MOUNTDIR}/dtbs/
	cp -v ${IMGS_PATH}/${KERNEL_IMAGE} ${MOUNTDIR}
	cp -v ${IMGS_PATH}/${DTB_PREFIX}${DISPLAY}.dtb ${MOUNTDIR}/dtbs/imx8mp-smarc.dtb
	cp -v ${IMGS_PATH}/uEnv.txt ${MOUNTDIR}

	echo
        sync

        umount ${MOUNTDIR}
}

install_rootfs_to_emmc()
{
	echo
	blue_underlined_bold_echo "Installing rootfs"

	MOUNTDIR=/run/media/${BLOCK}${PART}${ROOTFSPART}
	mkdir -p ${MOUNTDIR}
	mount /dev/${BLOCK}${PART}${ROOTFSPART} ${MOUNTDIR}

	printf "Extracting files"
	tar --warning=no-timestamp -jxvf ${IMGS_PATH}/${ROOTFS_IMAGE} -C ${MOUNTDIR} --checkpoint=.1200

                # Create DTB symlink
                (cd ${MOUNTDIR}/${BOOTDIR}; ln -fs ${DTB_PREFIX}${DISPLAY}.dtb ${DTB_PREFIX}.dtb)

	echo
	sync

	umount ${MOUNTDIR}
}

stop_udev()
{
	if [ -f /lib/systemd/system/systemd-udevd.service ]; then
		systemctl -q mask --runtime systemd-udevd
		systemctl -q stop systemd-udevd
	fi
}

start_udev()
{
	if [ -f /lib/systemd/system/systemd-udevd.service ]; then
		systemctl -q unmask --runtime systemd-udevd
		systemctl -q start systemd-udevd
	fi
}

usage()
{
	echo
	echo "This script installs Yocto Rootfs on the SMARC-iMX8MP's internal eMMC storage device"
	echo
	echo " Usage: $(basename $0) <option>"
	echo
	echo " options:"
	echo " -h                           show help message"
	echo " -d <lvds|hdmi>  set display type, default is hdmi"
	echo
}

finish()
{
	echo
	blue_bold_echo "Yocto Kirkstone installed successfully"
	exit 0
}

#################################################
#           Execution starts here               #
#################################################

if [[ $EUID != 0 ]] ; then
	red_bold_echo "This script must be run with super-user privileges"
	exit 1
fi

blue_underlined_bold_echo "*** Embedian SMARC-iMX8MP on-module eMMC Recovery ***"
echo

while getopts d:h OPTION;
do
	case $OPTION in
	d)
		DISPLAY=$OPTARG
		;;
	h)
		usage
		exit 0
		;;
	*)
		usage
		exit 1
		;;
	esac
done

printf "Board: "
blue_bold_echo $BOARD

printf "Installing to internal storage device: "
blue_bold_echo eMMC

check_board
check_images
stop_udev
delete_emmc
create_emmc_parts
format_emmc_parts
install_bootloader_to_emmc
install_kernel_to_emmc
install_rootfs_to_emmc
start_udev
finish
