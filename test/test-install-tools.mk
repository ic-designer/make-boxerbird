# Constants
override TEST_INSTALL_TOOLS.MK := $(lastword $(MAKEFILE_LIST))

# Targets
PHONY: test-install-tools
test-install-tools: \
		test-install-as-copy-no-files \
		test-install-as-copy-one-file \
		test-install-as-copy-two-files \
		test-install-as-executable-no-files \
		test-install-as-executable-one-file \
		test-install-as-executable-two-files \
		test-install-as-link-no-files \
		test-install-as-link-one-file \
		test-install-as-link-two-files


PHONY: test-install-as-copy-no-files
test-install-as-copy-no-files:
	@! $(MAKE) -q $(WORKDIR_TEST)/test-install-as-copy-no-files/installed.sh
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-copy-no-files/installed.sh:
	$(boxerbird::install-as-copy)


PHONY: test-install-as-copy-one-file
test-install-as-copy-one-file: $(WORKDIR_TEST)/test-install-as-copy-one-file/installed.sh
	@diff -y $< $(WORKDIR_TEST)/test-install-as-copy-one-file/alpha-src.sh
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-copy-one-file/installed.sh: \
		$(WORKDIR_TEST)/test-install-as-copy-one-file/alpha-src.sh
	$(boxerbird::install-as-copy)


PHONY: test-install-as-copy-two-files
test-install-as-copy-two-files: $(WORKDIR_TEST)/test-install-as-copy-two-files/installed.sh
	@diff -y $< $(WORKDIR_TEST)/test-install-as-copy-two-files/alpha-src.sh
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-copy-two-files/installed.sh: \
		$(WORKDIR_TEST)/test-install-as-copy-two-files/alpha-src.sh \
		$(WORKDIR_TEST)/test-install-as-copy-two-files/beta-src.sh
	$(boxerbird::install-as-copy)


PHONY: test-install-as-executable-no-files
test-install-as-executable-no-files:
	@! $(MAKE) -q $(WORKDIR_TEST)/test-install-as-executable-no-files/installed.sh
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-executable-no-files/installed.sh:
	$(boxerbird::install-as-executable)


PHONY: test-install-as-executable-one-file
test-install-as-executable-one-file: $(WORKDIR_TEST)/test-install-as-executable-one-file/installed.sh
	@diff -y $< $(WORKDIR_TEST)/test-install-as-executable-one-file/alpha-src.sh
	@test -x $<
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-executable-one-file/installed.sh: \
		$(WORKDIR_TEST)/test-install-as-executable-one-file/alpha-src.sh
	$(boxerbird::install-as-executable)


PHONY: test-install-as-executable-two-files
test-install-as-executable-two-files: $(WORKDIR_TEST)/test-install-as-executable-two-files/installed.sh
	@diff -y $< $(WORKDIR_TEST)/test-install-as-executable-two-files/alpha-src.sh
	@test -x $<
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-executable-two-files/installed.sh: \
		$(WORKDIR_TEST)/test-install-as-executable-two-files/alpha-src.sh \
		$(WORKDIR_TEST)/test-install-as-executable-two-files/beta-src.sh
	$(boxerbird::install-as-executable)


PHONY: test-install-as-link-no-files
test-install-as-link-no-files:
	@! $(MAKE) -q $(WORKDIR_TEST)/test-install-as-link-no-files/installed.sh
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-link-no-files/installed.sh:
	$(boxerbird::install-as-link)


PHONY: test-install-as-link-one-file
test-install-as-link-one-file: $(WORKDIR_TEST)/test-install-as-link-one-file/installed.sh
	@diff -y $< $(WORKDIR_TEST)/test-install-as-link-one-file/alpha-src.sh
	@test -L $<
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-link-one-file/installed.sh: \
		$(WORKDIR_TEST)/test-install-as-link-one-file/alpha-src.sh
	$(boxerbird::install-as-link)


PHONY: test-install-as-link-two-files
test-install-as-link-two-files: $(WORKDIR_TEST)/test-install-as-link-two-files/installed.sh
	@diff -y $< $(WORKDIR_TEST)/test-install-as-link-two-files/alpha-src.sh
	@test -L $<
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-install-as-link-two-files/installed.sh: \
		$(WORKDIR_TEST)/test-install-as-link-two-files/alpha-src.sh \
		$(WORKDIR_TEST)/test-install-as-link-two-files/beta-src.sh
	$(boxerbird::install-as-link)

$(WORKDIR_TEST)/%-src.sh: $(MAKEFILE_LIST)
	@mkdir -p $(dir $@)
	@echo 'function $(notdir $*) () { echo $(notdir $*) "$$@"; }' > $@
