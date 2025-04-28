.DEFAULT_GOAL := help

help: ## prints this message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9A-Za-z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
image: ## output png image
	openscad -o drain-cover.png --imgsize 1024,1024 --camera 0,-290,60,0,0,20 drain-cover.scad
stl: ## output stl
	openscad -o drain-cover.stl drain-cover.scad
