inherit extrausers

EXTRA_USERS_PARAMS_append = " \
useradd -e '' -ou 0 -d /home/root -G sudo,root,priv-admin,ipmi,redfish -p 'gzW59equAcJAg' sysadmin; \
useradd -e '' -ou 0 -d /home/root -G sudo,root,priv-admin,ipmi,web,redfish -p 'kFdHdjRkot8KQ' admin; \
"
OBMC_IMAGE_EXTRA_INSTALL_append += " openssh-sftp-server"
OBMC_IMAGE_EXTRA_INSTALL_append += " phosphor-ipmi-ipmb"
OBMC_IMAGE_EXTRA_INSTALL_append += " python-smbus"
OBMC_IMAGE_EXTRA_INSTALL_append += " ipmitool"
OBMC_IMAGE_EXTRA_INSTALL_append += " gpiolib"
OBMC_IMAGE_EXTRA_INSTALL_append += " rest-dbus"
OBMC_IMAGE_EXTRA_INSTALL_append += " cpld"
OBMC_IMAGE_EXTRA_INSTALL_append += " mac-util"
OBMC_IMAGE_EXTRA_INSTALL_append += " ethtool"
OBMC_IMAGE_EXTRA_INSTALL_append += " packagegroup-inventec-apps-ipmi-oem"
OBMC_IMAGE_EXTRA_INSTALL_append += " phosphor-node-manager-proxy"
