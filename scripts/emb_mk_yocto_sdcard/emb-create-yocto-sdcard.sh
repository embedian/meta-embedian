#!/bin/bash
set -e

#### Script version ####
SCRIPT_NAME=${0##*/}
readonly SCRIPT_VERSION="0.7"

#### Exports Variables ####
#### global variables ####
readonly ABSOLUTE_FILENAME=`readlink -e "$0"`
readonly ABSOLUTE_DIRECTORY=`dirname ${ABSOLUTE_FILENAME}`
readonly SCRIPT_POINT=${ABSOLUTE_DIRECTORY}
readonly SCRIPT_START_DATE=`date +%Y%m%d`

readonly YOCTO_ROOT="${SCRIPT_POINT}/../../../../"

readonly BSP_TYPE="YOCTO"
	if [[ "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" || "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" || "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g" || "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g" || "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" ]]; then
readonly YOCTO_BUILD=${YOCTO_ROOT}/build-xwayland
	fi
	if [[ "${MACHINE}" = "smarcfimx6q1g" || "${MACHINE}" = "smarcfimx6q2g" || "${MACHINE}" = "smarcfimx6qp1g" || "${MACHINE}" = "smarcfimx6qp2g" || "${MACHINE}" = "smarcfimx6dl1g" || "${MACHINE}" = "smarcfimx6solo" || "${MACHINE}" = "smarcfimx7d2g" || "${MACHINE}" = "smarcfimx7d" || "${MACHINE}" = "smarcfimx7s" ]]; then
readonly YOCTO_BUILD=${YOCTO_ROOT}/build-fb
	fi
readonly YOCTO_DEFAULT_IMAGE=fsl-image-qt6-validation-imx

readonly YOCTO_SCRIPTS_PATH=${SCRIPT_POINT}
readonly YOCTO_IMGS_PATH=${YOCTO_BUILD}/tmp/deploy/images/${MACHINE}

## display (one of "-hdmi", "-lvds", "-dp", "")
readonly DISPLAY="-hdmi"

# $1 -- block device
# $2 -- output images dir
readonly LPARAM_BLOCK_DEVICE=${1}
readonly LPARAM_OUTPUT_DIR=${2}
readonly P1_MOUNT_DIR="${G_TMP_DIR}/p1"
readonly P2_MOUNT_DIR="${G_TMP_DIR}/p2"

	if [[ "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" || "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" || "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g" || "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g" || "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" ]]; then
readonly BOOTLOAD_RESERVE_SIZE=4
	fi
	if [[ "${MACHINE}" = "smarcfimx6q1g" || "${MACHINE}" = "smarcfimx6q2g" || "${MACHINE}" = "smarcfimx6qp1g" || "${MACHINE}" = "smarcfimx6qp2g" || "${MACHINE}" = "smarcfimx6dl1g" || "${MACHINE}" = "smarcfimx6solo" || "${MACHINE}" = "smarcfimx7d2g" || "${MACHINE}" = "smarcfimx7d" || "${MACHINE}" = "smarcfimx7s" ]]; then
readonly BOOTLOAD_RESERVE_SIZE=1
	fi

	if [[ "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" || "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" || "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g" || "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g" || "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" ]]; then
readonly KERNEL_IMAGE=Image
	fi
	if [[ "${MACHINE}" = "smarcfimx6q1g" || "${MACHINE}" = "smarcfimx6q2g" || "${MACHINE}" = "smarcfimx6qp1g" || "${MACHINE}" = "smarcfimx6qp2g" || "${MACHINE}" = "smarcfimx6dl1g" || "${MACHINE}" = "smarcfimx6solo" || "${MACHINE}" = "smarcfimx7d2g" || "${MACHINE}" = "smarcfimx7d" || "${MACHINE}" = "smarcfimx7s" ]]; then
readonly KERNEL_IMAGE=zImage
	fi

readonly PART1_SIZE=48
readonly BOOTPART=1
readonly ROOTFSPART=2
readonly SPARE_SIZE=4

# Sizes are in MiB
	if [[ "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" || "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" || "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" ]]; then
BOOTLOADER_OFFSET=32
	fi
	if [[ "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g" || "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g" ]]; then
BOOTLOADER_OFFSET=33
	fi
	if [[ "${MACHINE}" = "smarcfimx6q1g" || "${MACHINE}" = "smarcfimx6q2g" || "${MACHINE}" = "smarcfimx6qp1g" || "${MACHINE}" = "smarcfimx6qp2g" || "${MACHINE}" = "smarcfimx6dl1g" || "${MACHINE}" = "smarcfimx6solo" || "${MACHINE}" = "smarcfimx7d2g" || "${MACHINE}" = "smarcfimx7d" || "${MACHINE}" = "smarcfimx7s" ]]; then
BOOTLOADER_OFFSET=2
	fi

AUTO_FILL_SD=0
LOOP_MAJOR=7

# This function performs sanity check to verify  that the target device is removable devise of proper size
function check_device()
{
	# Check that parameter is a valid block device
	if [ ! -b "$1" ]; then
          echo "$1 is not a valid block device, exiting"
	  exit 1
        fi

	local dev=$(basename $1)

	# Check that /sys/block/$dev exists
	if [ ! -d /sys/block/$dev ]; then
	  echo "Directory /sys/block/${dev} missing, exiting"
	  exit 1
        fi

	# Get device parameters
	local removable=$(cat /sys/block/${dev}/removable)
	local size_bytes=$((512*$(cat /sys/class/block/${dev}/size)))
	local size_gb=$((size_bytes/1000000000))

	# Non-removable SD card readers require additional check
	if [ "${removable}" != "1" ]; then
          local drive=$(udisksctl info -b /dev/${dev}|grep "Drive:"|cut -d"'" -f 2)
          local mediaremovable=$(gdbus call --system --dest org.freedesktop.UDisks2 \
				  --object-path ${drive} --method org.freedesktop.DBus.Properties.Get \
				  org.freedesktop.UDisks2.Drive MediaRemovable)
	  if [[ "${mediaremovable}" = *"true"* ]]; then
	    removable=1
	  fi
	fi

	# Check that device is either removable or loop
	if [ "$removable" != "1" -a $(stat -c '%t' /dev/$dev) != ${LOOP_MAJOR} ]; then
          echo "$1 is not a removable device, exiting"
	  exit 1
        fi

	# Check that device is attached
	if [ ${size_bytes} -eq 0 ]; then
          echo "$1 is not attached, exiting"
          exit 1
	fi

	# Check that device has a valid size
	echo "Detected removable device $1, size=${size_gb}GB"
}

YOCTO_RECOVERY_ROOTFS_PATH=${YOCTO_IMGS_PATH}

echo "================================================"
echo "=  Embedian recovery SD card creation script  ="
echo "================================================"

help() {
	bn=`basename $0`
	echo " Usage: MACHINE=<smarcimx8qm4g|smarcimx8qm8g|smarcimx8mp2g|smarcimx8mp4g|smarcimx8mp6g|pitximx8mp2g|pitximx8mp4g|pitximx8mp6g|smarcimx8mq2g|smarcimx8mq4g|smarcimx8mm2g|smarcimx8mm4g|smarcfimx6q2g|smarcfimx6q1g|smarcfimx6qp2g|smarcfimx6qp1g|smarcfimx6dl1g|smarcfimx6solo|smarcfimx7d2g|smarcfimx7d|smarcfimx7s> $bn <options> device_node"
	echo
	echo " options:"
	echo " -h		display this Help message"
	echo " -s		only Show partition sizes to be written, without actually write them"
	echo " -a		Automatically set the rootfs partition size to fill the SD card (leaving spare ${SPARE_SIZE}MiB)"
	echo " -r ROOTFS_NAME	select an alternative Rootfs for recovery images"
	echo " 		(default: \"${YOCTO_RECOVERY_ROOTFS_PATH}/${YOCTO_DEFAULT_IMAGE}\")"
	echo " -n TEXT_FILE	add a release Notes text file"
	echo
}

if [[ $EUID -ne 0 ]] ; then
	echo "This script must be run with super-user privileges"
	exit 1
fi

if [["${MACHINE}" != "smarcimx8qm4g" && "${MACHINE}" != "smarcimx8qm8g" && "${MACHINE}" != "smarcimx8mp2g" && "${MACHINE}" != "smarcimx8mp4g" && "${MACHINE}" != "smarcimx8mp6g" && "${MACHINE}" != "pitximx8mp2g" && "${MACHINE}" != "pitximx8mp4g" && "${MACHINE}" != "pitximx8mp6g" && "${MACHINE}" != "smarcimx8mq2g" && "${MACHINE}" != "smarcimx8mq4g" && "${MACHINE}" != "smarcimx8mm2g" && "${MACHINE}" != "smarcimx8mm4g" && "${MACHINE}" != "smarcfimx6qp2g" && "${MACHINE}" != "smarcfimx6qp1g" && "${MACHINE}" != "smarcfimx6q2g" && "${MACHINE}" != "smarcfimx6q1g" && "${MACHINE}" != "smarcfimx6dl1g" && "${MACHINE}" != "smarcfimx6solo" && "${MACHINE}" != "smarcfimx7d2g" && "${MACHINE}" != "smarcfimx7d" && "${MACHINE}" != "smarcfimx7s" ]] ; then
	echo "Unsupported machine!!"
	exit 1
fi


# Parse command line
moreoptions=1
node="na"
cal_only=0

while [ "$moreoptions" = 1 -a $# -gt 0 ]; do
	case $1 in
	    -h) help; exit 3 ;;
	    -s) cal_only=1 ;;
	    -a) AUTO_FILL_SD=1 ;;
	    -r) shift;
			YOCTO_RECOVERY_ROOTFS_MASK_PATH=`readlink -e "${1}.tar.bz2"`;
			YOCTO_RECOVERY_ROOTFS_PATH=`dirname ${YOCTO_RECOVERY_ROOTFS_MASK_PATH}`
			YOCTO_RECOVERY_ROOTFS_BASE_IN_NAME=`basename ${1}`
	    ;;
	    -n) shift;
			RELEASE_NOTES_FILE=${1}
	    ;;
	    *)  moreoptions=0;;
	esac
	[ "$moreoptions" = 0 ] && [ $# -gt 1 ] && help && exit 1
	[ "$moreoptions" = 1 ] && shift
done

        part=""
        if [ `echo ${LPARAM_BLOCK_DEVICE} | grep -c mmcblk` -ne 0 ]; then
                part="p"
        fi

# allow only removable/loopback devices, to protect host PC
echo "MACHINE=${MACHINE}"
echo "SD card rootfs:  ${YOCTO_DEFAULT_IMAGE}"
echo "Recovery rootfs: ${YOCTO_DEFAULT_IMAGE}"
echo "================================================"
check_device ${LPARAM_BLOCK_DEVICE}
echo "================================================"
read -p "Press Enter to continue"

function delete_device
{
	echo
	echo "Deleting current partitions"
        for ((i=0; i<10; i++))
        do
                if [ `ls ${LPARAM_BLOCK_DEVICE}${part}$i 2> /dev/null | grep -c ${LPARAM_BLOCK_DEVICE}${part}$i` -ne 0 ]; then
                        dd if=/dev/zero of=${LPARAM_BLOCK_DEVICE}${part}$i bs=512 count=1024
                fi
        done
        sync

        ((echo d; echo 1; echo d; echo 2; echo d; echo 3; echo d; echo w) | fdisk ${LPARAM_BLOCK_DEVICE} &> /dev/null) || true
        sync

	dd if=/dev/zero of=${LPARAM_BLOCK_DEVICE} bs=1M count=160
	sync; sleep 1
}

function ceildiv
{
    local num=$1
    local div=$2
    echo $(( (num + div - 1) / div ))
}

function create_parts
{
	echo
	echo "Creating new partitions"
        # Get total card size
        TOTAL_SIZE=`fdisk -s ${LPARAM_BLOCK_DEVICE}`
        TOTAL_SIZE=`expr ${TOTAL_SIZE} / 1024`
        ROOTFS_SIZE=`expr ${TOTAL_SIZE} - ${BOOTLOAD_RESERVE_SIZE} - ${PART1_SIZE} - ${SPARE_SIZE}`

        echo "ROOT SIZE=${ROOTFS_SIZE} TOTAl SIZE=${TOTAL_SIZE}"

        BLOCK=`echo ${LPARAM_BLOCK_DEVICE} | cut -d "/" -f 3`
        SECT_SIZE_BYTES=`cat /sys/block/${BLOCK}/queue/physical_block_size`

        BOOTLOAD_RESERVE_SIZE_BYTES=$((BOOTLOAD_RESERVE_SIZE * 1024 * 1024))
        PART1_SIZE_BYTES=$((PART1_SIZE * 1024 * 1024))
        PART1_END_BYTES=`expr ${BOOTLOAD_RESERVE_SIZE_BYTES} + ${PART1_SIZE_BYTES}`
        ROOTFS_SIZE_BYTES=$((ROOTFS_SIZE * 1024 * 1024))

        PART1_FIRST_SECT=`ceildiv ${BOOTLOAD_RESERVE_SIZE_BYTES} ${SECT_SIZE_BYTES}`
        PART1_END_SECT=`ceildiv ${PART1_END_BYTES} ${SECT_SIZE_BYTES}`
        PART2_FIRST_SECT=`expr ${PART1_END_SECT} + 1 `

        (echo n; echo p; echo $BOOTPART; echo $PART1_FIRST_SECT; \
         echo $PART1_END_SECT; echo n; echo p; echo $ROOTFSPART; \
         echo $PART2_FIRST_SECT; echo; echo p; echo w) | fdisk -u ${LPARAM_BLOCK_DEVICE} > /dev/null

        sleep 2; sync;
        fdisk -l ${LPARAM_BLOCK_DEVICE}

        sleep 2; sync;
}

function format_parts
{
	echo
	echo "Formatting partitions"
      	mkfs.vfat -F 16 ${LPARAM_BLOCK_DEVICE}${part}1 -n boot
       	mkfs.ext4 ${LPARAM_BLOCK_DEVICE}${part}2 -L rootfs
	sync; sleep 1
}

function install_bootloader
{
	echo
	echo "Installing U-Boot"
	if [[ "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" || "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" || "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" || "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g" || "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g" ]]; then
	dd if=${YOCTO_IMGS_PATH}/imx-boot-${MACHINE}-sd.bin-flash_evk of=${LPARAM_BLOCK_DEVICE} bs=1K seek=${BOOTLOADER_OFFSET}; sync
	fi
	if [[ "${MACHINE}" = "smarcfimx6q1g" || "${MACHINE}" = "smarcfimx6q2g" || "${MACHINE}" = "smarcfimx6qp1g" || "${MACHINE}" = "smarcfimx6qp2g" || "${MACHINE}" = "smarcfimx6dl1g" || "${MACHINE}" = "smarcfimx6solo" || "${MACHINE}" = "smarcfimx7d2g" || "${MACHINE}" = "smarcfimx7d" || "${MACHINE}" = "smarcfimx7s" ]]; then
	dd if=${YOCTO_IMGS_PATH}/u-boot.imx of=${LPARAM_BLOCK_DEVICE} bs=512 seek=${BOOTLOADER_OFFSET}; sync
	fi
}

function mount_parts
{
        mkdir -p ${P1_MOUNT_DIR}
        mkdir -p ${P2_MOUNT_DIR}
        sync

        mount ${LPARAM_BLOCK_DEVICE}${part}1  ${P1_MOUNT_DIR}
        mount ${LPARAM_BLOCK_DEVICE}${part}2  ${P2_MOUNT_DIR}
        sleep 2; sync;
}

function unmount_parts
{
        umount ${P1_MOUNT_DIR}
	umount ${P2_MOUNT_DIR}

        rm -rf ${P1_MOUNT_DIR}
        rm -rf ${P2_MOUNT_DIR}
}

function install_yocto
{
	echo
   	echo "Flashing \"Image, device tree and uEnv.txt\" partition"
		cp -v ${YOCTO_IMGS_PATH}/${KERNEL_IMAGE} ${P1_MOUNT_DIR}/
                mkdir -p ${P1_MOUNT_DIR}/dtbs/
	if [[ "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" ]]; then
                cp -v ${YOCTO_IMGS_PATH}/imx8mp-smarc${DISPLAY}.dtb ${P1_MOUNT_DIR}/dtbs/imx8mp-smarc.dtb
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_8mp.txt ${P1_MOUNT_DIR}/uEnv.txt
	elif [[ "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" ]]; then
                cp -v ${YOCTO_IMGS_PATH}/imx8qm-smarc${DISPLAY}.dtb ${P1_MOUNT_DIR}/dtbs/imx8qm-smarc.dtb
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_8qm.txt ${P1_MOUNT_DIR}/uEnv.txt
	elif [[ "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" ]]; then
		cp -v ${YOCTO_IMGS_PATH}/imx8mp-pitx.dtb ${P1_MOUNT_DIR}/dtbs/imx8mp-pitx.dtb
		cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_8mp_pitx.txt ${P1_MOUNT_DIR}/uEnv.txt
	elif [[ "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g" ]]; then
                cp -v ${YOCTO_IMGS_PATH}/imx8mq-smarc${DISPLAY}.dtb ${P1_MOUNT_DIR}/dtbs/imx8mq-smarc.dtb
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_8mq.txt ${P1_MOUNT_DIR}/uEnv.txt
	elif [[ "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g" ]]; then
                cp -v ${YOCTO_IMGS_PATH}/imx8mm-smarc.dtb ${P1_MOUNT_DIR}/dtbs/imx8mm-smarc.dtb
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_8mm.txt ${P1_MOUNT_DIR}/uEnv.txt
	elif [[ "${MACHINE}" = "smarcfimx6q2g" || "${MACHINE}" = "smarcfimx6q1g" ]]; then
		cp -v ${YOCTO_IMGS_PATH}/imx6q-smarc.dtb ${P1_MOUNT_DIR}/dtbs/imx6q-smarc.dtb
		cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_6qdl.txt ${P1_MOUNT_DIR}/uEnv.txt
		cp -v ${YOCTO_IMGS_PATH}/u-boot.imx ${P1_MOUNT_DIR}/u-boot.imx

	elif [[ "${MACHINE}" = "smarcfimx6qp2g" || "${MACHINE}" = "smarcfimx6qp1g" ]]; then
		cp -v ${YOCTO_IMGS_PATH}/imx6qp-smarc.dtb ${P1_MOUNT_DIR}/dtbs/imx6qp-smarc.dtb
		cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_6qdl.txt ${P1_MOUNT_DIR}/uEnv.txt
		cp -v ${YOCTO_IMGS_PATH}/u-boot.imx ${P1_MOUNT_DIR}/u-boot.imx
	elif [[ "${MACHINE}" = "smarcfimx6dl1g" || "${MACHINE}" = "smarcfimx6solo" ]]; then
		cp -v ${YOCTO_IMGS_PATH}/imx6dl-smarc.dtb ${P1_MOUNT_DIR}/dtbs/imx6dl-smarc.dtb
		cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_6qdl.txt ${P1_MOUNT_DIR}/uEnv.txt
		cp -v ${YOCTO_IMGS_PATH}/u-boot.imx ${P1_MOUNT_DIR}/u-boot.imx
	elif [[ "${MACHINE}" = "smarcfimx7d2g" || "${MACHINE}" = "smarcfimx7d" || "${MACHINE}" = "smarcfimx7s" ]]; then
                cp -v ${YOCTO_IMGS_PATH}/imx7d-smarc.dtb ${P1_MOUNT_DIR}/dtbs/imx6dl-smarc.dtb
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_7ds.txt ${P1_MOUNT_DIR}/uEnv.txt
                cp -v ${YOCTO_IMGS_PATH}/u-boot.imx ${P1_MOUNT_DIR}/u-boot.imx

	else
		echo "Unsupported machine!!"
		exit 1
	fi

	echo
	echo "Installing Yocto Root File System"
	tar jxvf ${YOCTO_IMGS_PATH}/${YOCTO_DEFAULT_IMAGE}-${MACHINE}.tar.bz2 -C ${P2_MOUNT_DIR}/
	sync
}

function copy_images
{
	echo
	echo "Copying Yocto images to /opt/images/"
	mkdir -p ${P2_MOUNT_DIR}/opt/images/Yocto

	# Copy image for eMMC
	if [ -f ${YOCTO_IMGS_PATH}/${YOCTO_DEFAULT_IMAGE}-${MACHINE}.tar.bz2 ]; then
		pv ${YOCTO_IMGS_PATH}/${YOCTO_DEFAULT_IMAGE}-${MACHINE}.tar.bz2 > ${P2_MOUNT_DIR}/opt/images/Yocto/rootfs.tar.bz2
	else
		echo "rootfs.tar.gz file is not present. Installation on \"eMMC\" will not be supported."
	fi

        echo
        echo "Copying Kernel Images to /opt/images/"
                cp ${YOCTO_IMGS_PATH}/${KERNEL_IMAGE} ${P2_MOUNT_DIR}/opt/images/Yocto/${KERNEL_IMAGE}

        echo
        echo "Copying Kernel Device Tree Blob to /opt/images/"
                cp -v ${YOCTO_IMGS_PATH}/*.dtb ${P2_MOUNT_DIR}/opt/images/Yocto/

        echo
        echo "Copying Kernel Parameter uEnv.txt to /opt/images/"
	if [[ "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" ]]; then
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_emmc_8mp.txt ${P2_MOUNT_DIR}/opt/images/Yocto/uEnv.txt
	elif [[ "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" ]]; then
		cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_emmc_8mp_pitx.txt ${P2_MOUNT_DIR}/opt/images/Yocto/uEnv.txt
	elif [[ "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" ]]; then
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_emmc_8qm.txt ${P2_MOUNT_DIR}/opt/images/Yocto/uEnv.txt
	elif [[ "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g" ]]; then
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_emmc_8mq.txt ${P2_MOUNT_DIR}/opt/images/Yocto/uEnv.txt
	elif [[ "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g" ]]; then
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_emmc_8mm.txt ${P2_MOUNT_DIR}/opt/images/Yocto/uEnv.txt
	elif [[ "${MACHINE}" = "smarcfimx6qp2g" || "${MACHINE}" = "smarcfimx6qp1g" || "${MACHINE}" = "smarcfimx6q2g" || "${MACHINE}" = "smarcfimx6q1g" || "${MACHINE}" = "smarcfimx6dl1g" || "${MACHINE}" = "smarcfimx6solo" ]]; then
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_emmc_6qdl.txt ${P2_MOUNT_DIR}/opt/images/Yocto/uEnv.txt
	elif [[ "${MACHINE}" = "smarcfimx7d2g" || "${MACHINE}" = "smarcfimx7d" || "${MACHINE}" = "smarcfimx7s" ]]; then
                cp -v ${YOCTO_SCRIPTS_PATH}/uEnv_emmc_7ds.txt ${P2_MOUNT_DIR}/opt/images/Yocto/uEnv.txt
	else
		echo "Unsupported machine!!"
		exit 1
	fi

	if [[ "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" || "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" || "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" || "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g" || "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g" ]]; then
		cp ${YOCTO_IMGS_PATH}/imx-boot-${MACHINE}-sd.bin-* ${P2_MOUNT_DIR}/opt/images/Yocto
		(cd ${P2_MOUNT_DIR}/opt/images/Yocto; ln -fs imx-boot-${MACHINE}-sd.bin-flash_evk imx-boot-sd.bin)
	else
		cp ${YOCTO_IMGS_PATH}/u-boot.imx ${P2_MOUNT_DIR}/opt/images/Yocto/u-boot.imx
	fi
}

function copy_scripts
{
	echo
	echo "Copying scripts"

        if [[ "${MACHINE}" = "smarcimx8mp2g" || "${MACHINE}" = "smarcimx8mp4g" || "${MACHINE}" = "smarcimx8mp6g" ]]; then
	cp ${YOCTO_SCRIPTS_PATH}/smarc-imx8mp-create-yocto-emmc.sh ${P2_MOUNT_DIR}/usr/bin/
        elif [[ "${MACHINE}" = "pitximx8mp2g" || "${MACHINE}" = "pitximx8mp4g" || "${MACHINE}" = "pitximx8mp6g" ]]; then
	cp ${YOCTO_SCRIPTS_PATH}/pitx-imx8mp-create-yocto-emmc.sh ${P2_MOUNT_DIR}/usr/bin/
	elif [[ "${MACHINE}" = "smarcimx8qm4g" || "${MACHINE}" = "smarcimx8qm8g" ]]; then
	cp ${YOCTO_SCRIPTS_PATH}/smarc-imx8qm-create-yocto-emmc.sh ${P2_MOUNT_DIR}/usr/bin/
	elif [[ "${MACHINE}" = "smarcimx8mq2g" || "${MACHINE}" = "smarcimx8mq4g"  ]]; then
        cp ${YOCTO_SCRIPTS_PATH}/smarc-imx8mq-create-yocto-emmc.sh ${P2_MOUNT_DIR}/usr/bin/
        elif [[ "${MACHINE}" = "smarcimx8mm2g" || "${MACHINE}" = "smarcimx8mm4g"  ]]; then
        cp ${YOCTO_SCRIPTS_PATH}/smarc-imx8mm-create-yocto-emmc.sh ${P2_MOUNT_DIR}/usr/bin/
	elif [[ "${MACHINE}" = "smarcfimx6qp2g" || "${MACHINE}" = "smarcfimx6qp1g" || "${MACHINE}" = "smarcfimx6q2g" || "${MACHINE}" = "smarcfimx6q1g" || "${MACHINE}" = "smarcfimx6dl1g" || "${MACHINE}" = "smarcfimx6solo" ]]; then
	cp ${YOCTO_SCRIPTS_PATH}/smarc-fimx6qdl-create-yocto-emmc.sh ${P2_MOUNT_DIR}/usr/bin/
	elif [[ "${MACHINE}" = "smarcfimx7d2g" || "${MACHINE}" = "smarcfimx7d" || "${MACHINE}" = "smarcfimx7s" ]]; then
	cp ${YOCTO_SCRIPTS_PATH}/smarc-fimx7-create-yocto-emmc.sh ${P2_MOUNT_DIR}/usr/bin/
        else
                echo "Unsupported machine!!"
                exit 1
        fi
}

umount ${LPARAM_BLOCK_DEVICE}${part}*  2> /dev/null || true

delete_device
create_parts
format_parts

mount_parts
install_yocto
copy_images
copy_scripts

echo
echo "Syncing"
sync | pv -t

unmount_parts

install_bootloader

echo
echo "Done"
echo "========Flash to SD card Completed!========="

exit 0
