.DEFAULT_GOAL := help
.PHONY: help image stl all

help: ## prints this message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9A-Za-z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
image: ## output png image
	openscad -o drain-cover-bathroom.png --imgsize 1024,1024 --camera 0,-290,80,0,0,30 drain-cover-bathroom.scad
stl: ## output stl
	openscad -o drain-cover-bathroom.stl drain-cover-bathroom.scad
all: image stl ## output image and stl

ci-image:
	xvfb-run -a openscad -o drain-cover-bathroom.png --imgsize 1024,1024 --camera 0,-290,80,0,0,30 drain-cover-bathroom.scad
ci-all: ci-image stl
