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
test-build-bash-library-one-file: $(WORKDIR_TEST)/test-build-bash-library-one-file/library.sh
	@test "$(shell cat $<)" = "test-build-bash-library-one-file/alpha" || (cat $< && exit 1)
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-library-one-file/library.sh: \
		$(WORKDIR_TEST)/test-build-bash-library-one-file/alpha-src.sh
	@$(boxerbird::build-bash-library)


PHONY: test-build-bash-library-two-files
test-build-bash-library-two-files: $(WORKDIR_TEST)/test-build-bash-library-two-files/library.sh
	@test "$(shell cat $<)" = \
"test-build-bash-library-two-files/alpha \
test-build-bash-library-two-files/beta" || (cat $< && exit 1)
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-library-two-files/library.sh: \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/alpha-src.sh \
		$(WORKDIR_TEST)/test-build-bash-library-two-files/beta-src.sh
	@$(boxerbird::build-bash-library)


PHONY: test-build-bash-executable-no-files
test-build-bash-executable-no-files:
	@! $(MAKE) -q $(WORKDIR_TEST)/test-build-bash-executable-no-files/executable.sh
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-executable-no-files/executable.sh:
	$(boxerbird::build-bash-executable)


PHONY: test-build-bash-executable-one-file
test-build-bash-executable-one-file: \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/executable-actual.sh \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/executable-expected.sh
	@diff -y $^
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-executable-one-file/executable-actual.sh: \
		$(WORKDIR_TEST)/test-build-bash-executable-one-file/alpha-src.sh
	@$(call boxerbird::build-bash-executable, alpha)

$(WORKDIR_TEST)/test-build-bash-executable-one-file/executable-expected.sh:
	@echo 'INFO: Bulding executable $@...'
	@echo '#!/usr/bin/env bash\n' > $@
	@echo 'test-build-bash-executable-one-file/alpha' >> $@
	@echo  >> $@
	@echo 'if [[ $${BASH_SOURCE[0]} == $${0} ]]; then' >> $@
	@echo '    ('  >> $@
	@echo '        set -euo pipefail'  >> $@
	@echo '        alpha "$$@"'  >> $@
	@echo '    )'  >> $@
	@echo 'fi'  >> $@
	@echo 'INFO: Bulding executable $@ completed.'


PHONY: test-build-bash-executable-two-files
test-build-bash-executable-two-files: \
		$(WORKDIR_TEST)/test-build-bash-executable-two-files/executable-actual.sh \
		$(WORKDIR_TEST)/test-build-bash-executable-two-files/executable-expected.sh
	@diff -y $^
	@printf "\e[1;32mPassed: $(TEST_BASH_BUILD_TOOLS.MK)::$@\e[0m\n"

$(WORKDIR_TEST)/test-build-bash-executable-two-files/executable-actual.sh: \
		$(WORKDIR_TEST)/test-build-bash-executable-two-files/alpha-src.sh \
		$(WORKDIR_TEST)/test-build-bash-executable-two-files/beta-src.sh
	@$(call boxerbird::build-bash-executable, beta)

$(WORKDIR_TEST)/test-build-bash-executable-two-files/executable-expected.sh:
	@echo 'INFO: Bulding executable $@...'
	@echo '#!/usr/bin/env bash\n' > $@
	@echo 'test-build-bash-executable-two-files/alpha' >> $@
	@echo 'test-build-bash-executable-two-files/beta' >> $@
	@echo  >> $@
	@echo 'if [[ $${BASH_SOURCE[0]} == $${0} ]]; then' >> $@
	@echo '    ('  >> $@
	@echo '        set -euo pipefail'  >> $@
	@echo '        beta "$$@"'  >> $@
	@echo '    )'  >> $@
	@echo 'fi'  >> $@
	@echo 'INFO: Bulding executable $@ completed.'


$(WORKDIR_TEST)/%-src.sh:
	@mkdir -p $(dir $@)
	@echo "$*" > $@
