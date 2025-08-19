.DEFAULT_GOAL := all

SUBDIRS = \
	mise

RECURSIVE_TARGETS = \
	all \
	update \
	clean

LINK_TARGETS = \
	x11vncrc \
	atoolrc \
	screenrc \
	zsh/zshenv \
	vim

define LINK_RULE =
$(2): $(1)
LINKS += $(2)
ARTIFACTS += $(2)
endef

define MAKE_SUBDIRS
$(foreach subdir,$(SUBDIRS),
$(MAKE) -C "$(subdir)" $(1)
)
endef

$(foreach link_target,$(LINK_TARGETS),$(eval $(call LINK_RULE,$(link_target),$(addprefix $(HOME)/., $(notdir $(link_target))))))

.PHONY: $(LINKS)
$(LINKS): %: | git-pull
	ln --symbolic --no-target-directory --relative --force $< $@

.PHONY: all
all: update symlinks

.PHONY:
git-pull:
	git pull
	git submodule update --init --recursive

.PHONY: symlinks
symlinks: $(LINKS)

.PHONY: update
update: git-pull symlinks
	$(MAKE) $@-recursive

.PHONY: clean
clean: clean-recursive
	rm -f $(ARTIFACTS)

$(addsuffix -recursive,$(RECURSIVE_TARGETS)): %-recursive:
	$(call MAKE_SUBDIRS,$*)
