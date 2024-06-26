DC = docker compose

build:
	@$(DC) build

up:
	@$(DC) up -d

down:
	@$(DC) down

shell: up
	@$(DC) exec -it arduino bash

shell-root: up
	@$(DC) exec -it -u root arduino bash

ide: up
	@$(DC) exec -it arduino sh -c "./arduino"