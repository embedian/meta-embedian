# Workaround to fix do_compile() failure due to missing imx8mp-smarc.dtb
do_compile_prepend() {
	echo "Copying DTB"
        if [ -f ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mp-smarc.dtb ]; then
          cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/imx8mp-smarc.dtb ${S}/iMX8M/imx8mp-evk.dtb
        fi
}
