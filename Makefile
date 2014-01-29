TARGET := native:clang:10.9
ARCHS := x86_64
GO_EASY_ON_ME := 1

include theos/makefiles/common.mk

THEOS_BUILD_DIR = build

LIBRARY_NAME = dockify
dockify_FILES = dockify.xm
dockify_FRAMEWORKS = Cocoa QuartzCore CoreGraphics
dockify_CFLAGS = -I$(THEOS)/include -I./Dock -fobjc-gc

include $(THEOS_MAKE_PATH)/library.mk
