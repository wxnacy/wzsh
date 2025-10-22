# Makefile for wzsh installation

WZSH_DIR := $(CURDIR)
BACKUP_SUFFIX := .bak.$(shell date +%Y%m%d%H%M%S)

define link_file
	@echo "Checking $(2)"
	@if [ -L "$(2)" ]; then \
		if [ "$(readlink $(2))" = "$(1)" ]; then \
			echo "✓ Already linked correctly"; \
		else \
			echo "Relinking $(2) -> $(1)"; \
			ln -sf "$(1)" "$(2)"; \
		fi; \
	elif [ -e "$(2)" ]; then \
		echo "Backing up existing $(2) to $(2)$(BACKUP_SUFFIX)"; \
		mv "$(2)" "$(2)$(BACKUP_SUFFIX)"; \
		echo "Linking $(2) -> $(1)"; \
		ln -sf "$(1)" "$(2)"; \
	else \
		echo "Linking $(2) -> $(1)"; \
		ln -sf "$(1)" "$(2)"; \
	fi
endef

install:
	@echo "Starting wzsh installation..."

	@echo "The final step is to complete the configuration of Wzsh"
	@echo "Run these commands"
	@printf '\tln -sf %s %s\n' "$(WZSH_DIR)" "$(HOME)/.zsh"
	@printf '\tln -sf %s %s\n' "$(WZSH_DIR)/zshenv" "$(HOME)/.zshenv"
	@printf '\tln -sf %s %s\n' "$(WZSH_DIR)/zprofile" "$(HOME)/.zprofile"
	@printf '\tln -sf %s %s\n' "$(WZSH_DIR)/zshrc" "$(HOME)/.zshrc"
	@printf '\tzsh\n'
	$(if $(filter $(HOME)/.zsh,$(WZSH_DIR)), \
		@echo "Skipping linking $(HOME)/.zsh because it already points to $(WZSH_DIR).", \
		$(call link_file,$(WZSH_DIR),$(HOME)/.zsh))
	$(call link_file,$(WZSH_DIR)/zshenv,$(HOME)/.zshenv)
	$(call link_file,$(WZSH_DIR)/zprofile,$(HOME)/.zprofile)
	$(call link_file,$(WZSH_DIR)/zshrc,$(HOME)/.zshrc)

	@echo ""
	@echo "wzsh installation complete!"
	@echo "Starting zsh..."
	@zsh

.PHONY: install
