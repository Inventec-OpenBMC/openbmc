inherit extrausers

EXTRA_USERS_PARAMS_append = " \
useradd -e '' -ou 0 -d /home/root -G priv-admin,root,sudo,ipmi,web,redfish -p 'gzW59equAcJAg' sysadmin; \
useradd -e '' -ou 0 -d /home/root -G priv-admin,root,sudo,ipmi,web,redfish -p 'kFdHdjRkot8KQ' admin; \
"
OBMC_IMAGE_EXTRA_INSTALL_append += " openssh-sftp-server"
OBMC_IMAGE_EXTRA_INSTALL_append += " python3-smbus"
OBMC_IMAGE_EXTRA_INSTALL_append += " ipmitool"
OBMC_IMAGE_EXTRA_INSTALL_append += " gpiolib"
OBMC_IMAGE_EXTRA_INSTALL_append += " mmc-utils"
OBMC_IMAGE_EXTRA_INSTALL_append += " starscream-init"
OBMC_IMAGE_EXTRA_INSTALL_append += " libsafec"
OBMC_IMAGE_EXTRA_INSTALL_append += " packagegroup-inventec-apps-ipmi-oem"
OBMC_IMAGE_EXTRA_INSTALL_append += " inventec-util"
OBMC_IMAGE_EXTRA_INSTALL_append += " inv-ipmi-oem"
OBMC_IMAGE_EXTRA_INSTALL_append += " inventec-dcmi-power"
OBMC_IMAGE_EXTRA_INSTALL_append += " smbios-mdr"
OBMC_IMAGE_EXTRA_INSTALL_append += " inv-psu-update"
OBMC_IMAGE_EXTRA_INSTALL_append += " inventec-mac-config"
OBMC_IMAGE_EXTRA_INSTALL_append += " phosphor-nvme"

