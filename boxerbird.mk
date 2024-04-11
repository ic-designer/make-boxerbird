BOXERBIRD_PATH := $(dir $(lastword $(MAKEFILE_LIST)))
include $(BOXERBIRD_PATH)/src/bash-build-tools.mk
include $(BOXERBIRD_PATH)/src/common-targets.mk
include $(BOXERBIRD_PATH)/src/githooks.mk
include $(BOXERBIRD_PATH)/src/install-tools.mk
