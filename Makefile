# Constants
WORKDIR_ROOT := $(CURDIR)/.make

#Targets
.PHONY: check
check: private_test

.PHONY: clean
clean: private_clean

.PHONY: test
test: private_test

# Includes
include make/private.mk
