# Constants
override TEST_BASH_BUILD_TOOLS.MK := $(lastword $(MAKEFILE_LIST))

# Targets
PHONY: test-bash-build-tools
test-bash-build-tools: \
		test-build-bash-library-no-files \
		test-build-bash-library-one-file \
		test-build-bash-library-two-files \
		test-build-bash-executable-no-files \
		test-build-bash-executable-one-file \
		test-build-bash-executable-two-files


PHONY: test-build-bash-library-no-files
test-build-bash-library-no-files:
	@! $(MAKE) -q $(WORKDIR_TEST)/test-build-bash-library-no-files/library.sh
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-library-no-files/library.sh:
	$(boxerbird::build-bash-library)


PHONY: test-build-bash-library-one-file
test-build-bash-library-one-file: \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/library-actual.sh \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/library-expected.sh
	@diff -y $^
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-library-one-file/library-actual.sh: \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/alpha-src.sh
	@$(boxerbird::build-bash-library)

$(WORKDIR_TEST)/test-build-bash-library-one-file/library-expected.sh:
	@mkdir -p $(dir $@)
	@echo 'function alpha () { echo alpha "$$@"; }' > $@


PHONY: test-build-bash-library-two-files
test-build-bash-library-two-files: \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/library-actual.sh \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/library-expected.sh
	@diff -y $^
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-library-two-files/library-actual.sh: \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/alpha-src.sh \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/beta-src.sh
	@$(boxerbird::build-bash-library)

$(WORKDIR_TEST)/test-build-bash-library-two-files/library-expected.sh:
	@mkdir -p $(dir $@)
	@echo 'function alpha () { echo alpha "$$@"; }' > $@
	@echo 'function beta () { echo beta "$$@"; }' >> $@


PHONY: test-build-bash-executable-no-files
test-build-bash-executable-no-files:
	@! $(MAKE) -q $(WORKDIR_TEST)/test-build-bash-executable-no-files/executable.sh
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-executable-no-files/executable.sh:
	$(boxerbird::build-bash-executable)


PHONY: test-build-bash-executable-one-file
test-build-bash-executable-one-file: \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/executable.sh
	@test "alpha" = "$(shell $^)"
	@test "alpha beta" = "$(shell $^ beta)"
	@test "alpha beta gamma" = "$(shell $^ beta gamma)"
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-executable-one-file/executable.sh: \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/alpha-src.sh
	@$(call boxerbird::build-bash-executable, alpha)


PHONY: test-build-bash-executable-two-files
test-build-bash-executable-two-files: \
		$(WORKDIR_TEST)/test-build-bash-executable-two-files/executable.sh
	@test "alpha beta" = "$(shell $^)"
	@test "alpha gamma beta gamma" = "$(shell $^ gamma)"
	@test "alpha gamma delta beta gamma delta" = "$(shell $^ gamma delta)"
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-executable-two-files/executable.sh: \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/alpha-src.sh \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/beta-src.sh
	@$(call boxerbird::build-bash-executable, alpha "$$@" beta)


$(WORKDIR_TEST)/%-src.sh: $(MAKEFILE_LIST)
	@mkdir -p $(dir $@)
	@echo 'function $(notdir $*) () { echo $(notdir $*) "$$@"; }' > $@
