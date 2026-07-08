cmake_minimum_required(VERSION 3.16)
project(ezmonitor)

set(KF6_MIN_VERSION "6.10.0")

find_package(ECM ${KF6_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(ECMInstallIcons)

set(PLASMOID_ID de.agundur.ezmonitor)

install(DIRECTORY package/ DESTINATION ${KDE_INSTALL_DATADIR}/plasma/plasmoids/${PLASMOID_ID})

ecm_install_icons(
    ICONS icons/sc-apps-ezmonitor.svg
    DESTINATION ${KDE_INSTALL_ICONDIR}
)
