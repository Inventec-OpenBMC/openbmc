FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-peci-Add-support-for-PECI-bus-driver-core.patch \
                   file://0002-peci-Add-Aspeed-PECI-adapter-driver.patch \
                   file://0003-peci-npcm-add-NPCM-PECI-driver.patch \
                   file://0004-peci-fix-error-handling-in-peci_dev_ioctl.patch \
                   file://0005-hwmon-Add-PECI-dimmtemp-driver.patch \
                   file://0006-mfd-intel-peci-client-Add-Intel-PECI-client-driver.patch \
                   file://0007-hwmon-Add-PECI-cputemp-driver.patch \
                   file://0008-peci-cputemp-label-CPU-cores-from-zero-instead-of-on.patch \
                   file://0009-peci-Sync-peci-verion-with-Intel-BMC-linux.patch \
                   file://0010-Implement-a-memory-driver-share-memory.patch \
                 "
