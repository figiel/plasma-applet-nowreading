project(plasma-applet-nowreading)
 
find_package(KDE4 REQUIRED)
 
include(KDE4Defaults)
 
install(DIRECTORY package/
        DESTINATION ${DATA_INSTALL_DIR}/plasma/plasmoids/nowreading)
 
install(FILES package/metadata.desktop
        DESTINATION ${SERVICES_INSTALL_DIR} RENAME plasma-applet-nowreading.desktop)
