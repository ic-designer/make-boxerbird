define boxerbird::install-as-copy
	@echo "INFO: Installing copy $@..."
	@install -dv $(dir $@)
	@install -Sv $< $@
	diff $@ $<
	@echo "INFO: Installing copy $@ completed."
endef

define boxerbird::install-as-executable
	@echo "INFO: Installing executable $@..."
	@install -dv $(dir $@)
	@install -Sv -m 544 $< $@
	diff $@ $<
	test -x $@
	@echo "INFO: Installing executable $@ completed."
endef

define boxerbird::install-as-link
	@echo "INFO: Installing link $@..."
	@install -dv $(dir $@)
	@ln -sfv $(realpath $<) $@
	diff $@ $<
	test -L $@
	@echo "INFO: Installing link $@ completed."
endef
