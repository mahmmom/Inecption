BLUE    := \033[34m
GREEN   := \033[32m
YELLOW  := \033[33m
RED     := \033[31m
RESET   := \033[0m

all: inception

inception:
	@echo "${BLUE}Building and starting Inception...${RESET}"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

down:
	@echo "${GREEN}Stopping and removing containers...${RESET}"
	@docker-compose -f ./srcs/docker-compose.yml down --remove-orphans

clean: down
	@echo "${YELLOW}Removing all images, volumes, and orphans...${RESET}"
	@docker rmi -f $$(docker images -a -q) 2> /dev/null || true

fclean: clean
	@echo "${RED}Forcibly removing all Docker images and data...${RESET}"
	@docker-compose -f ./srcs/docker-compose.yml down --rmi all -v --remove-orphans 2>/dev/null || true
	@sudo rm -rf ~/data/wordpress ~/data/mariadb ~/data 2>/dev/null || true

re: fclean all

.PHONY: all clean fclean re down inception
