include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = TheosExample1
TheosExample1_FILES = TheosExample1ListController.mm
TheosExample1_INSTALL_PATH = /Library/PreferenceBundles
TheosExample1_FRAMEWORKS = UIKit
TheosExample1_PRIVATE_FRAMEWORKS = Preferences
TheosExample1_CFLAGS += -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/TheosExample1.plist$(ECHO_END)
