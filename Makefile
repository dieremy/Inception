name = INCEPTION

HAS_COMMAND := $(shell which figlet >/dev/null 2>&1 && echo yes || echo no)

ifeq ($(HAS_COMMAND), yes)
  PRINT := figlet
else
  PRINT := printf
endif

all:
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/grype
ifeq ($(shell docker ps -q), "")
	@$(PRINT) "STEP RE-LAUNCH ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file .env up -d
else
	@$(PRINT) "STEP BUILD ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file .env up -d --build
endif
	@printf "\n\n"
	@docker ps -a -s
	@printf "\n\n"
	@docker system df

build:
	@$(PRINT) "STEP BUILD ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file .env up -d --build

down:
	@$(PRINT) "STEP DROP ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file .env down

re: down build
	@$(PRINT) "STEP RE-BUILD ${name}...\n"

clean: down
	@$(PRINT) "STEP CLEAN CONFIGURATION ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*
	@sudo rm -rf ~/data/grype/*

fclean: clean
	@$(PRINT) "STEP CLEAN ALL INFRASTRUCTURE docker\n"
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data

.PHONY: all build down re clean fclean
