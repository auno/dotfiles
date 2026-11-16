.DEFAULT_GOAL := all

SUBDIRS = \
	mise \
	nvim

RECURSIVE_TARGETS = \
	all \
	update \
	clean

LINK_TARGETS = \
	x11vncrc \
	atoolrc \
	screenrc \
	zsh/zshenv \
	vim \
	cargo/config.toml:.cargo/config.toml \

%/:
	mkdir -p $@

define LINK_RULE =
$(2): $(1) | $(dir $(2))
LINKS += $(2)
ARTIFACTS += $(2)
endef

$(foreach link_target,$(LINK_TARGETS),\
	$(eval $(call LINK_RULE,\
		$(word 1,$(subst :, ,$(link_target))),\
		$(addprefix $(HOME)/,\
			$(if $(word 2,$(subst :, ,$(link_target))),\
				$(word 2,$(subst :, ,$(link_target))),\
				$(addprefix .,$(notdir $(link_target))))))))

define MAKE_SUBDIRS
$(foreach subdir,$(SUBDIRS),
$(MAKE) -C "$(subdir)" $(1)
)
endef

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
