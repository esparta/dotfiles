PACKAGES = $(wildcard src/*.pkg)
TARGETS = $(notdir $(basename ${PACKAGES}))

PACKAGE_MANAGER = pacman
COMMAND = -S
OPTS = --needed --noconfirm
EXP = [[:blank:]]*([\#;].*)$

.PHONY: list
list:
	@echo This is the list of available targets
	@# How do you get the list of targets in a makefile?
	@# https://stackoverflow.com/a/26339924
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null \
		| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
		| sort | grep -E -v -e '^[^[:alnum:]]' -e '^$@$$' \
		| xargs

u2f: curl
	@echo "Downloading 70-u2f.rules"
	@sudo curl -o /etc/udev/rules.d/70-u2f.rules \
		https://raw.githubusercontent.com/Yubico/libu2f-host/master/70-u2f.rules
	@echo "In order to make this work you must re-start the computer"

curl:
ifeq (, $(shell which curl))
	$(error "No curl. Please use make install PACKAGE=basic")
endif

$(TARGETS):
	@echo "Installing package $@"
	@grep -vxE '$(EXP)' src/$@.pkg \
		| paste -s -d" " \
		| xargs sudo $(PACKAGE_MANAGER) $(COMMAND) $(OPTS)
link:
	@bash src/linking.sh

vundle:
	@git clone https://github.com/VundleVim/Vundle.vim.git \
		~/.vim/bundle/Vundle.vim
repos:
	@bash src/repos.sh
