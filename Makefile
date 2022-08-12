all: pdfs ## Make everything


pdfs: constitution-doc ## Make all PDFs


constitution-doc: ## Build the constitution as a PDF
	@mkdir -p out
	@pandoc constitution/README.md -o out/constitution.pdf


help: ## List all available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.* ?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: all $(MAKECMDGOALS)


.DEFAULT_GOAL := help
