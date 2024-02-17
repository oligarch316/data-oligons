#!/usr/bin/env -S make -f

# ----- Boilerplate
.DELETE_ON_ERROR:
.ONESHELL:
.SILENT:
.SUFFIXES:

MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
MAKEFLAGS += --no-print-directory
MAKEFLAGS += --warn-undefined-variables

SHELL       := bash
.SHELLFLAGS := -eu -o pipefail -c


# ----- Commands
cmdAwk         = $(shell command -v awk         || echo 'awk')
cmdNpx         = $(shell command -v npx         || echo 'npx')
cmdFantasticon = $(shell command -v fantasticon || echo '$(cmdNpx) fantasticon')
cmdNix         = $(shell command -v nix         || echo 'nix')


# ----- Default
.PHONY: default

default: nix ## Alias for `nix`


# ----- Abstract
.PHONY: all clean

all::   ## Build all artifacts
clean:: ## Clean all artifacts


# ----- Include
# Include core sub-makefiles in desired order
include build/font.mk
include build/nix.mk
include build/help.mk

# Include optional local settings
-include build/local.mk
