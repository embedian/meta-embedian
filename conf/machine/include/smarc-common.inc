DISTRO_FEATURES_FILTER_NATIVESDK += "wayland"

MACHINE_USES_VIVANTE_KERNEL_DRIVER_MODULE ?= "0"

# Overrides for imx-base.inc
DEFAULTTUNE_mx8mp ?= "cortexa53-crypto"

IMX_DEFAULT_BSP = "nxp"

MACHINE_SOCARCH_FILTER_remove = "alsa-lib gstreamer1.0 imx-codec"

# Use latest SDMA firmware from firmware-imx instead of upstream linux-firmware
MACHINE_FIRMWARE_remove_mx8 = "linux-firmware-imx-sdma-imx7d"

MACHINE_FIRMWARE_append_mx8    = " linux-firmware-ath10k firmware-imx-sdma firmware-imx-regulatory"
MACHINE_FIRMWARE_remove_mx8mp  = "firmware-imx-easrc-imx8mn firmware-imx-xcvr-imx8mp firmware-sof-imx"
MACHINE_FIRMWARE_append_mx8mp  = " firmware-imx-easrc firmware-imx-xcvr sof-imx"

# NXP WiFi firmware & extra Wlan SDK
MACHINE_FIRMWARE_append = " ${@bb.utils.contains('MACHINE_FEATURES', 'nxp8987', 'linux-firmware-nxp89xx', '', d)}"
MACHINE_FIRMWARE_append = " ${@bb.utils.contains('MACHINE_FEATURES', 'nxp8997', 'linux-firmware-nxp89xx', '', d)}"
MACHINE_EXTRA_RRECOMMENDS_append = " ${@bb.utils.contains('MACHINE_FEATURES', 'nxp8987', 'nxp-wlan-sdk kernel-module-nxp89xx', '', d)}"
MACHINE_EXTRA_RRECOMMENDS_append = " ${@bb.utils.contains('MACHINE_FEATURES', 'nxp8997', 'nxp-wlan-sdk kernel-module-nxp89xx', '', d)}"

# MCore Demo apps to /lib/firmware
MACHINE_EXTRA_RRECOMMENDS_append_mx8mp  = " imx-m7-demos"

MACHINE_GSTREAMER_1_0_PLUGIN_mx8 ?= "imx-gst1.0-plugin"

PREFERRED_VERSION_weston_mx8 ?= "9.0.0.imx"

PREFERRED_VERSION_wayland-protocols_mx8 = "1.20.imx"

PREFERRED_VERSION_libdrm_mx8 ?= "2.4.102.imx"

PREFERRED_VERSION_isp-imx ?= "4.2.2.6.1"
PREFERRED_VERSION_basler-camera ?= "4.2.2.6.1"

PREFERRED_VERSION_optee-client_mx8 = "3.10.0.imx"
PREFERRED_VERSION_optee-os_mx8 = "3.10.0.imx"
PREFERRED_VERSION_optee-test_mx8 = "3.10.0.imx"

SOC_DEFAULT_IMAGE_FSTYPES_remove = "wic.gz"
SOC_DEFAULT_IMAGE_FSTYPES_append = " wic.bz2 tar.bz2"

OPTEE_BOOT_IMAGE_mx8 ?= "tee.bin"

IMAGE_BOOT_FILES_append = " \
    ${@bb.utils.contains('COMBINED_FEATURES', 'xen', 'xen', '', d)} \
"

IMAGE_INSTALL_append = " \
    ${@bb.utils.contains('COMBINED_FEATURES', 'jailhouse', 'jailhouse', '', d)} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'packagegroup-fsl-optee-imx', '', d)} \
    ${@bb.utils.contains('COMBINED_FEATURES', 'xen', 'imx-xen xen-tools', '', d)} \
"

MACHINE_FEATURES_append_imx    = " nxp8987"

# Overrides for all MACHINE.conf with optee support
UBOOT_CONFIG_OPTEE_CONFIG = "mx${OPTEE_BIN_EXT}_optee_config"
UBOOT_CONFIG[sd-optee] = "${UBOOT_CONFIG_OPTEE_CONFIG},sdcard"


# LF still doesn't support wireless now, need to remove it temporarily
# qca9377 is not ready for imx8mmevk
MACHINE_FEATURES_remove = "qca9377 mrvl8997"
