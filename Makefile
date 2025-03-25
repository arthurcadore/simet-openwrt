include ./env/.git_credentials
export

all: build start

build:
	@echo "Building..."
	@docker-compose build

start:
	@echo "Starting..."
	@docker-compose up -d

stop:
	@echo "Stopping..."
	@docker-compose down

clean: stop
	docker ps -a -q | xargs -r docker stop
	docker ps -a -q | xargs -r docker rm
	docker images -q | xargs -r docker rmi -f
	docker volume ls -q | xargs -r docker volume rm

toolchain:
	@echo "Installing toolchain..."
	@echo "GIT_USER=$${GIT_USER}"
	@git clone https://$${GIT_USER}:$${GIT_PASSWORD}@git.intelbras.com.br/remp495/feed-toolchain-3006 ./build/feed-toolchain-3006
	