name = INCEPTION

all:
	@printf "CHECKING ${name}'s VOLUMES...\n"
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress
ifeq ($(shell docker ps -q), "")
	@figlet "STEP RE-LAUNCH ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file .env up -d
else
	@figlet "STEP BUILD ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file .env up -d --build
endif
	@printf "\n\n\n"
	@docker ps -a

build:
	@figlet "STEP BUILD ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file .env up -d --build

down:
	@figlet "STEP DROP ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file .env down

re: build
	@figlet "STEP RE-BUILD ${name}...\n"

clean: down
	@figlet "STEP CLEAN CONFIGURATION ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean: clean
	@figlet "STEP CLEAN ALL INFRASTRUCTURE docker\n"
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data

.PHONY: all build down re clean fclean
