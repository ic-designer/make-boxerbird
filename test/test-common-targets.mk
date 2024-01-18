# Constants
override TEST_INSTALL_TOOLS.MK := $(lastword $(MAKEFILE_LIST))

# Targets
PHONY: test-common-targets
test-common-targets: \
		test-directory-target


PHONY: test-directory-target
test-directory-target: |$(WORKDIR_TEST)/test-directory-target/.
	@test -d $(WORKDIR_TEST)/$/.
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"
