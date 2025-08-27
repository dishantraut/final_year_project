# Makefile for TodoListProject
# Usage:
#   make up     -> Start containers (wait until healthy)
#   make down   -> Stop containers
#   make logs   -> View logs (follow mode)
#   make ps     -> Show container status
#   make restart -> Restart containers
#   make clean  -> Stop + remove volumes

PROJECT_NAME = final_year_project

# Start containers and wait until all healthchecks pass
up:
	@echo "🚀 Starting $(PROJECT_NAME) services..."
	@docker compose up -d --wait
	@echo "✅ All services are healthy!"
	@docker compose ps

# Stop containers (but keep volumes/data)
down:
	@echo "🛑 Stopping $(PROJECT_NAME) services..."
	@docker compose down

# Restart services (wait for healthy)
restart: down up

# View container status
ps:
	@docker compose ps

# Build service images (pull latest base images)
build:
	@echo "🔧 Building $(PROJECT_NAME) images..."
	@docker compose build --pull
	@echo "✅ Build complete."

# Tail logs (Ctrl+C to stop)
logs:
	@docker compose logs -f

# Clean up everything (⚠️ removes volumes/data)
clean:
	@echo "⚠️ Removing containers and volumes for $(PROJECT_NAME)..."
	@docker compose down -v

# Show a quick system view for debugging (images, volumes, networks, containers, swarm)
do:
	@echo "=== docker images ==="
	@docker images
	@echo "\n=== docker volumes ls ==="
	@docker volume ls
	@echo "\n=== docker network ls ==="
	@docker network ls
	@echo "\n=== docker ps -a ==="
	@docker ps -a
	@echo "\n=== docker swarm info ==="
	@docker info --format '{{json .Swarm}}' || docker swarm
