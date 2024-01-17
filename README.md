# Boxerbird
[![Makefile CI](https://github.com/ic-designer/make-boxerbird/actions/workflows/makefile.yml/badge.svg)](https://github.com/ic-designer/make-boxerbird/actions/workflows/makefile.yml)

## Usage

The Boxerbird `make` utilities can be loaded using following code snippet.

```make
BOXERBIRD.MK := $(WORKDIR_DEPS)/boxerbird/boxerbird.mk
$(BOXERBIRD.MK):
	@echo "Loading Boxerbird Makefile Utilities..."
	git clone git@github.com:ic-designer/make-boxerbird.git --branch 0.1.0 $(dir $@)
	@echo
-include $(BOXERBIRD.MK)
```
