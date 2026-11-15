# organon: skills, review agents and work seats for Cortex Code and Claude Code
#
# Run `make` with no arguments for the list.

SHELL       := /usr/bin/env bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

DEST ?= $(HOME)/.snowflake/cortex

.PHONY: help
help: ## Show this help
	@echo
	@echo "  organon: skills, review agents and work seats for Cortex Code and Claude Code"
	@echo
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36m%-14s\033[0m %s\n", $$1, $$2}'
	@echo

# --- install ----------------------------------------------------------------

.PHONY: install
install: ## Copy the skills and agents into Cortex Code's folder (DEST= to change)
	@scripts/install "$(DEST)"

# --- checks -----------------------------------------------------------------

.PHONY: lint
lint: ## Static checks on the scripts
	@printf '  %-14s ' 'shellcheck'; if command -v shellcheck >/dev/null; then shellcheck scripts/install tests/run.sh packaging/release-notes.sh && echo ok; else echo 'not installed, skipped'; fi
	@printf '  %-14s ' 'python parse'; python3 -W error::SyntaxWarning -c 'import ast, sys; ast.parse(open(sys.argv[1]).read(), sys.argv[1])' bin/organon-check && echo ok

.PHONY: test
test: ## The checker's own tests, both directions
	@tests/run.sh

.PHONY: kit
kit: ## Every skill and agent loads with its tools and its cores
	@printf '  %-14s ' 'kit'; bin/organon-check && echo ok

.PHONY: check
check: lint test kit ## Everything a commit has to pass
	@echo
	@echo "  lint, tests and the kit pass"
