# Embedian SDK full filesystem image

require smarc-image.inc

IMAGE_INSTALL += "\
    packagegroup-arago-base \
    packagegroup-smarc-console \
    packagegroup-arago-base-tisdk \
    packagegroup-arago-test \
    packagegroup-arago-test-addons \
    ${@bb.utils.contains('MACHINE_FEATURES','sgx','packagegroup-arago-tisdk-graphics','',d)} \
    packagegroup-arago-tisdk-qte \
    ${@bb.utils.contains('MACHINE_FEATURES','dsp','packagegroup-arago-tisdk-opencl','',d)} \
    ${@bb.utils.contains('MACHINE_FEATURES','dsp','packagegroup-arago-tisdk-opencl-extra','',d)} \
    packagegroup-arago-tisdk-connectivity \
    packagegroup-arago-tisdk-crypto \
    packagegroup-arago-tisdk-matrix \
    packagegroup-arago-tisdk-matrix-extra \
    packagegroup-arago-tisdk-amsdk \
    packagegroup-smarct437x-sdk \
    packagegroup-smarc-tisdk-addons \
    "

export IMAGE_BASENAME = "smarct437x-rootfs-image"
