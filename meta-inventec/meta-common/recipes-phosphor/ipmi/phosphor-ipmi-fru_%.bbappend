FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-Patched-to-check-Multi-Record-Area-first-record-head.patch \
		   file://0002-Block-checksum-validification-part-for-fru-parsing.patch \
" 
