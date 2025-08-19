.DEFAULT_GOAL := all
SHELL = bash
MISE ?= mise

.PHONY: all
all: update

.PHONY: update
update:
	( . <("$(MISE)" env --cd "$(HOME)" | grep 'export MISE_'); "$(MISE)" upgrade )

.PHONY: clean
clean:
	rm -f $(ARTIFACTS)
