RDEPENDS_${PN}-extras_remove = " \
       phosphor-rest \
       phosphor-gevent \
       "

#Add python utility.(e.g gpioutil,...)
RDEPENDS_${PN}-extrasdevtools_append += " ipmitool"
RDEPENDS_${PN}-extrasdevtools_append += " openssh-sftp-server"
RDEPENDS_${PN}-extras += " python3-smbus"
RDEPENDS_${PN}-extras += " phosphor-webui"

#Install publickey for image file verification
RDEPENDS_${PN}-extras += " phosphor-image-signing"
