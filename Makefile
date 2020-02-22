.DEFAULT_GOAL:=help
.PHONY: help prod

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

up: ## Create and start Atlas container on background
	@docker-compose -p ceey -f ../docker/development/docker-compose.yml up -d atlas

down: ## Stop and remove Atlas container
	@docker-compose -p ceey -f ../docker/development/docker-compose.yml down atlas

dev: ## Build Atlas image for local development (ceey_atlas)
	@docker-compose -p ceey -f ../docker/development/docker-compose.yml build atlas

prod: ## Build PMS image for production (ceey/pms)
	@docker build -f .docker/production/Dockerfile -t ceey/atlas .
