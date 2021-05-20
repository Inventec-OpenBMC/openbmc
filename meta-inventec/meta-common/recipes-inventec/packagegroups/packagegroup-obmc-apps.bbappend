RDEPENDS_${PN}-extras_remove = " \
       phosphor-rest \
       phosphor-gevent \
       "

#Add python utility.(e.g gpioutil,...)
RDEPENDS_${PN}-extrasdevtools_append += " ipmitool"
RDEPENDS_${PN}-extrasdevtools_append += " openssh-sftp-server"
RDEPENDS_${PN}-extras += " python3-smbus"

#Install publickey for image file verification
RDEPENDS_${PN}-extras += " phosphor-image-signing"

RDEPENDS_${PN}-health-monitor_remove_transformers = "phosphor-health-monitor"
