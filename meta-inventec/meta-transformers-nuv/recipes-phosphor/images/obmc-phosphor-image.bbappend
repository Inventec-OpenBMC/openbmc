inherit buv-image
inherit extrausers
EXTRA_USERS_PARAMS_append = " \
useradd -e '' -ou 0 -d /home/root -G priv-admin,root,sudo,ipmi,web,redfish -p 'gzW59equAcJAg' sysadmin; \
useradd -e '' -ou 0 -d /home/root -G priv-admin,root,sudo,ipmi,web,redfish -p 'kFdHdjRkot8KQ' admin; \
"
OBMC_IMAGE_EXTRA_INSTALL_append += " openssh-sftp-server"
OBMC_IMAGE_EXTRA_INSTALL_append += " phosphor-ipmi-ipmb"
OBMC_IMAGE_EXTRA_INSTALL_append += " python3-smbus"
OBMC_IMAGE_EXTRA_INSTALL_append += " ipmitool"
OBMC_IMAGE_EXTRA_INSTALL_append += " gpiolib"
#BMC_IMAGE_EXTRA_INSTALL_append += " rest-dbus"
#OBMC_IMAGE_EXTRA_INSTALL_append += " cpld"
OBMC_IMAGE_EXTRA_INSTALL_append += " mmc-utils"
OBMC_IMAGE_EXTRA_INSTALL_append += " transformers-init"
OBMC_IMAGE_EXTRA_INSTALL_append += " libsafec"
OBMC_IMAGE_EXTRA_INSTALL_append += " intel-asd"
OBMC_IMAGE_EXTRA_INSTALL_append += " intel-ipmi-oem"
OBMC_IMAGE_EXTRA_INSTALL_append += " inventec-util"
OBMC_IMAGE_EXTRA_INSTALL_append += " inv-ipmi-oem"
OBMC_IMAGE_EXTRA_INSTALL_append += " inventec-dcmi-power"
OBMC_IMAGE_EXTRA_INSTALL_append += " peci-pcie"
OBMC_IMAGE_EXTRA_INSTALL_append += " cpldupdate-i2c"
OBMC_IMAGE_EXTRA_INSTALL_append += " bios-update"
OBMC_IMAGE_EXTRA_INSTALL_append += " monitor-bios-update"
#OBMC_IMAGE_EXTRA_INSTALL_append += " inv-transformers-ipmi-oem"
#OBMC_IMAGE_EXTRA_INSTALL_append += " inv-psu-update"
OBMC_IMAGE_EXTRA_INSTALL_append += " smbios-mdr"
#OBMC_IMAGE_EXTRA_INSTALL_append += " gpio-event-handler"
OBMC_IMAGE_EXTRA_INSTALL_append += "inventec-mac-config"

OBMC_IMAGE_EXTRA_INSTALL_append += "usb-network"
OBMC_IMAGE_EXTRA_INSTALL_append += "phosphor-ipmi-flash"
