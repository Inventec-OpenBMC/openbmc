FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI_append = " file://chassis-capabilities.override.yml \
		   file://boot.override.yml \
                 "
