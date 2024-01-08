define boxerbird::install-as-copy
	@install -dv $(dir $@)
	@install -Sv $< $@
	diff $@ $<
	@echo
endef

define boxerbird::install-as-executable
	@install -dv $(dir $@)
	@install -Sv -m 544 $< $@
	diff $@ $<
	test -x $@
	@echo
endef

define boxerbird::install-as-link
	@install -dv $(dir $@)
	@ln -sfv $(realpath $<) $@
	diff $@ $<
	test -L $@
	@echo
endef
