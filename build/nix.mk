# ----- Default
.PHONY: nix

nix: nix.build ## Alias for `nix.build`


# ----- Abstract
all::   nix.build
clean:: nix.clean


# ----- Build
.PHONY: nix.build

nix.build: nix.build.oligons ## Alias for `nix.build.oligons`

nix.build.%: ## Build nix package named <%>
	$(call inform,Building package '$*')
	$(cmdNix) build --out-link build/package/$(basename $*) .#$*


# ----- Clean
.PHONY: nix.clean

nix.clean: ## Clean nix packages
	$(call inform,Cleaning packages)
	rm --recursive build/package > /dev/null 2>&1 || true
