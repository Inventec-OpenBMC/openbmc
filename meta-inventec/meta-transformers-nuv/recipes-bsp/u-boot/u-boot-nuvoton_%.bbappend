FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append_transformers-nuv = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRC_URI_append_transformers-nuv = " file://fixed_phy.cfg \
                                    file://0001-Add-the-enable-espi-patch.patch \
                                    "
