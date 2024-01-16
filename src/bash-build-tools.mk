define boxerbird::build-bash-executable
	@echo 'INFO: Bulding executable $@...'
	@mkdir -p $(dir $@)
	@echo '#!/usr/bin/env bash\n' > $@
	@cat $^ >> $@
	@echo >> $@
	@echo 'if [[ $${BASH_SOURCE[0]} == $${0} ]]; then' >> $@
	@echo '    ('  >> $@
	@echo '        set -euo pipefail'  >> $@
	@echo '        $(strip $(1)) "$$@"'  >> $@
    @echo '    )'  >> $@
	@echo 'fi'  >> $@
	@echo 'INFO: Bulding executable $@ completed.'
	@echo
endef

define boxerbird::build-bash-library
	@echo 'INFO: Bulding library $@...'
	@mkdir -p $(dir $@)
	@cat $^ > $@
	@echo 'INFO: Bulding library $@ completed.'
	@echo
endef
