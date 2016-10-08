export GO_EASY_ON_ME = 1

export ARCHS = armv7 arm64
export SDKVERSION = 8.1
export TARGET = iphone:clang:8.1

# export DEBUG = 1
ifeq ($(DEBUG),1)
	PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)+debug
else
	PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TheosExample1
TheosExample1_FILES = Tweak.xm
# TheosExample1_FRAMEWORKS =
# UIKit CoreGraphics CoreFoundation QuartzCore AudioToolbox AVFoundation
# TheosExample1_PRIVATE_FRAMEWORKS =
# TheosExample1_LIBRARIES =
# TheosExample1_CODESIGN_FLAGS = -SEntitlements.plist

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += settings
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
