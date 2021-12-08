FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI_append = " file://power_cap.override.yml \
                   file://boot.override.yml \
		   file://globalenables.override.yml \
                 "
