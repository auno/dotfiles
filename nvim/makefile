.DEFAULT_GOAL := all

all: update

.PHONY: verify-ownership
verify-ownership:
	test -z "$(find -user root)"

update: verify-ownership
	nvim --headless "+Lazy! sync" +qa

clean:
	rm -rf \
		lazy-lock.json \
		~/.local/share/nvim \
		~/.local/state/nvim
