.DEFAULT_GOAL := all

ARTIFACTS =
.PHONY: clean
clean:
	echo rm -f $(ARTIFACTS)

LINK_TARGETS = \
	x11vncrc \
	atoolrc \
	screenrc \
	zsh/zshenv \
	vim/vimrc

define LINK_RULE =
$(2): $(1)
LINKS += $(2)
ARTIFACTS += $(2)
endef

$(foreach link_target,$(LINK_TARGETS),$(eval $(call LINK_RULE,$(link_target),$(addprefix $(HOME)/., $(notdir $(link_target))))))

$(LINKS):
	ln -s $(shell realpath $< --relative-base=$(dir $@)) $@

all: $(LINKS)

