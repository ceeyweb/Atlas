.DEFAULT_GOAL:=help
.PHONY: help up restart build down dev prod

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

up: ## Start Atlas container on background
	@docker-compose -p ceey -f ../docker/development/docker-compose.yml up -d atlas

restart: ## Restart Atlas container
	@docker-compose -p ceey -f ../docker/development/docker-compose.yml restart atlas

build: ## Rebuild and start Atlas container on background
	@docker-compose -p ceey -f ../docker/development/docker-compose.yml up -d --build atlas

down: ## Stop and remove all CEEY containers
	@docker-compose -p ceey -f ../docker/development/docker-compose.yml down

dev: ## Build Atlas image for local development (ceey_atlas)
	@docker-compose -p ceey -f ../docker/development/docker-compose.yml build atlas

prod: ## Build Atlas image for production (ceey/pms)
	@docker build -f .docker/production/Dockerfile -t ceeyweb/atlas:$(or $(T),latest) .

deploy: ## Build Atlas image for production and push it to Docker Hub
	@docker build -f .docker/production/Dockerfile -t ceeyweb/atlas:$(or $(T),latest) .
	@docker push ceeyweb/atlas:$(or $(T),latest)
