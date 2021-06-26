# Configure target build to use native tools of itself and to use a qemu wrapper
# and optionally to generate introspection data
EXTRA_OEMESON_class-target = " \
    -Dgi_cross_use_prebuilt_gi=true \
    -Dgi_cross_binary_wrapper=${B}/g-ir-scanner-qemuwrapper \
    -Dgi_cross_ldd_wrapper=${B}/g-ir-scanner-lddwrapper \
    -Dgi_cross_pkgconfig_sysroot_path=${PKG_CONFIG_SYSROOT_DIR} \
    ${@'-Dgir_dir_prefix=${libdir}' if d.getVar('MULTILIBS') else ''} \
"
