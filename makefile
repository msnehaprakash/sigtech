COMPOSE_FILE = docker/docker-compose.yml
DOCKER_COMPOSE = docker compose -f $(COMPOSE_FILE)

# Default target
.PHONY: all
all: up

# Start containers 
.PHONY: up
up:
	$(DOCKER_COMPOSE) up

# Stop containers
.PHONY: down
down:
	$(DOCKER_COMPOSE) down

# Restart containers
.PHONY: restart
restart: down up

# Rebuild containers without cache
.PHONY: 
build:
	$(DOCKER_COMPOSE) build --no-cache

# View logs
.PHONY: logs
logs:
	$(DOCKER_COMPOSE) logs -f
	
# Clean up containers, networks, images, and volumes
.PHONY: clean
clean: down
	$(DOCKER_COMPOSE) rm -f
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans
	