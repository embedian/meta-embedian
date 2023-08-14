# Workaround to fix do_compile() failure due to missing imx8mx-smarc.dtb
compile_mx8:prepend:smarcimx8qm4g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8qm-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8qm-mek.dtb
        fi
}

compile_mx8:prepend:smarcimx8qm8g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8qm-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8qm-mek.dtb
        fi
}

compile_mx8m:prepend:smarcimx8mp2g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mp-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mp-evk.dtb
        fi
}

compile_mx8m:prepend:smarcimx8mp4g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mp-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mp-evk.dtb
        fi
}

compile_mx8m:prepend:smarcimx8mp6g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mp-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mp-evk.dtb
        fi
}

compile_mx8m:prepend:pitximx8mp2g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mp-pitx.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mp-evk.dtb
        fi
}

compile_mx8m:prepend:pitximx8mp4g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mp-pitx.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mp-evk.dtb
        fi
}

compile_mx8m:prepend:pitximx8mp6g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mp-pitx.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mp-evk.dtb
        fi
}

compile_mx8m:prepend:smarcimx8mq2g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mq-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mq-evk.dtb
        fi
}

compile_mx8m:prepend:smarcimx8mq4g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mq-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mq-evk.dtb
        fi
}

compile_mx8m:prepend:smarcimx8mm2g() {
        echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mm-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mm-evk.dtb
        fi
}

compile_mx8m:prepend:smarcimx8mm4g() {
	echo "Copying DTB"
	if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mm-smarc.dtb ]; then
	 cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME} ${BOOT_STAGING}/imx8mm-evk.dtb
        fi
}
