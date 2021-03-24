require  bmc_firmware_version.inc

OS_RELEASE_FIELDS = "ID ID_LIKE NAME VERSION VERSION_ID PRETTY_NAME BMC_IMAGE_NAME PLATFORM_NAME"

# Replace VERSION_ID so that it can carry more meaningful information
VERSION_ID = "2.9.0-${@run_git(d, 'describe --long')}"

# Replace PRETTY_NAME to add MACHINE_NAME and VERSION_ID
PRETTY_NAME = "${MACHINE_NAME} V${VERSION_ID}! (Base: ${DISTRO_NAME} ${VERSION})"
PLATFORM_NAME = "${PLATFORM_ID}"
BMC_IMAGE_NAME = "${PLATFORM_ID}.${BMC_IMAGE}.${VERSION_ID}"

