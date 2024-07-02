name = INCEPTION

all:
	@printf "STEP LAUNCH ${name}...\n"
    @if[!$(docker-compose ps -a) == 0 ]; then \
    	make build; \
     else \
     	docker-compose -f ./srcs/docker-compose.yml --env-file .env up -d \
     fi

build:
	@printf "STEP BUILD ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file .env up -d --build

down:
	@printf "STEP END ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file .env down

re:
	@printf "STEP RE-BUILD ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file .env up -d --build

clean: down
	@printf "STEP CLEAN CONFIGURATION ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean:
	@printf "STEP CLEAN ALL INFRASTRUCTURE docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY	: all build down re clean fclean
