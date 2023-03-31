# ~ Variables
theDate = $(shell date +"%d %B, %Y")

# ~ Targets
.PHONY: all $(MAKECMDGOALS)

all: pdfs ## Make everything

pdfs: constitution-doc ## Make all PDFs

constitution-doc: ## Build the constitution as a PDF
	mkdir -p out
	pandoc \
		-V geometry:margin=2cm \
		-V date:"Last Amended: $(theDate)" \
		--lua-filter ${LUA_FILTERS_DIR}/include-files.lua \
		-o out/constitution.pdf \
		constitution/constitution.md

finalise-constitution: constitution-doc ## Copy the compiled PDF to the main folder.
	cp out/constitution.pdf constitution/

watch-pdfs: ## Build PDFs upon changes
	@fswatch --event Updated -o ./constitution/ | xargs -I{} make pdfs
	# @commando -c echo constitution | grep --line-buffered Modified | conscript make pdfs

help: ## List all available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.* ?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
