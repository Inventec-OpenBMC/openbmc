FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append_transformers-nuv = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRC_URI_append_transformers-nuv = " file://fixed_phy.cfg \
                                    file://0001-Add-the-enable-espi-patch.patch \
                                    file://0002-Add-enable-espi-four-channel-config.patch \
                                    file://0003-Bug-631-SW-Transformers-OpenBMC-Support-mc-selftest-.patch \
				    file://0004-Add-Windbond-W25Q512JVFIM.patch \
                                    "
