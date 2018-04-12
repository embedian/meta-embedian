TOOLCHAIN_SUFFIX ?= "-tisdk"

require meta-toolchain-smarc-tisdk.inc
require recipes-core/meta/meta-toolchain-arago-qte.bb

PR = "${INC_PR}.0"

TOOLCHAIN_TARGET_TASK += "boost"

toolchain_create_sdk_env_script_append() {
    echo -e 'export PS1="\[\\e[32;1m\][linux-devkit]\[\\e[0m\]:\w> "' >> $script
}
