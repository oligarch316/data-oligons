# ----- Default
.PHONY: font

font: font.build ## Alias for `font.build`


# ----- Abstract
all::   font.build
clean:: font.clean


# ----- Build
.PHONY: font.build

fontBuildFlags += --name oligons
fontBuildFlags += --output build/font
fontBuildFlags += --asset-types json
fontBuildFlags += --font-types ttf woff woff2

font.build: ## Build font artifacts
	$(call inform,Building artifacts)
	mkdir -p build/font
	$(cmdFantasticon) $(fontBuildFlags) -- icons > /dev/null


# ----- Clean
.PHONY: font.clean

font.clean: ## Clean font artifacts
	$(call inform,Cleaning artifacts)
	rm --recursive build/font > /dev/null 2>&1 || true
