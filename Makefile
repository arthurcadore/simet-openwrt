.PHONY: all stop start build clean toolchain

include ./env/.git_credentials
export

all: start

build: toolchain
	@echo "Building..."
	@docker compose build

start:
	@echo "Starting..."
	@docker compose up 

stop:
	@echo "Stopping..."
	@docker compose down

clean: stop
	docker ps -a -q | xargs -r docker stop
	docker ps -a -q | xargs -r docker rm
	docker images -q | xargs -r docker rmi -f
	docker volume ls -q | xargs -r docker volume rm

toolchain:
	@echo "Installing toolchain..."
	@echo "GIT_USER=$${GIT_USER}"
	@echo "GIT_REPO=$${GIT_REPO}"
	@echo "GIT_URL=$${GIT_URL}"
	@git clone https://$${GIT_USER}:$${GIT_PASSWORD}@$${GIT_URL} ./build/$${GIT_REPO}
	