THEOS_PACKAGE_DIR_NAME = debs
TARGET = :clang
ARCHS = armv7 arm64
FINALPACKAGE = 1
THEOS_DEVICE_IP=192.168.0.10
THEOS_DEVICE_PORT=22

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Blow
Blow_FILES = Blow.xm $(wildcard *.m)
Blow_USE_SUBSTRATE = 1
#Blow_FRAMEWORKS = UIKit
#Blow_PRIVATE_FRAMEWORKS
#Blow_LIBRARIES

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-stage::
	$(ECHO_NOTHING)find $(FW_STAGING_DIR) -iname '*.png' -exec pincrush-osx -i {} \;$(ECHO_END)

after-install::
	install.exec "killall -9 Instagram"
