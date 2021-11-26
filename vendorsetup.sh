#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2019-2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

FDEVICE="olive"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	# General
	export TARGET_ARCH="arm64"
	export OF_KEEP_FORCED_ENCRYPTION=1
	export OF_PATCH_AVB20=1
	export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	#export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1
	export OF_NO_MIUI_PATCH_WARNING=1
	export OF_USE_GREEN_LED=0

	# Binaries
	export FOX_USE_BASH_SHELL=1
        export FOX_ASH_IS_BASH=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_ZIP_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_REPLACE_BUSYBOX_PS=1
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800"; # Tue Jan 1 2019 00:00:00 GMT

	# OTA
	export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

	# Enable the new TWRP auto-detection of system-as-root
	export OF_USE_TWRP_SAR_DETECT=1

	# Disable some operations relating only to Samsung devices
	export OF_NO_SAMSUNG_SPECIAL=1

	# Screen settings
	export OF_SCREEN_H=2160
	export OF_STATUS_INDENT_LEFT=60
	export OF_STATUS_INDENT_RIGHT=60
	export OF_CLOCK_POS=1
	export OF_ALLOW_DISABLE_NAVBAR=0

	# Disable app manager
	export FOX_DISABLE_APP_MANAGER=1

	# Advanced security
	export FOX_ADVANCED_SECURITY=1

	# Quick backup list
	export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"

	# Check for attempts by a ROM's installer to overwrite OrangeFox with another recovery
	export OF_CHECK_OVERWRITE_ATTEMPTS=1

	# Disable magisk addon
	export FOX_DELETE_MAGISK_ADDON=1

	# Maintainer stuff
	export FOX_VERSION="R11.1"
	export OF_MAINTAINER="JonnyRoller23"
	export OF_MAINTAINER_AVATAR="/home/solus/ofox_ava.png"

	# A12 hack
	export OF_SKIP_DECRYPTED_ADOPTED_STORAGE=1

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi

  	for var in eng user userdebug; do
  		add_lunch_combo omni_"$FDEVICE"-$var
  	done
fi
#
