#!/bin/bash

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

show_menu() {
    clear
    echo -e "${BLUE}=================================${NC}"
    echo -e "${BLUE}    Docker Management System${NC}"
    echo -e "${BLUE}=================================${NC}"
    echo -e "\n${BLUE}Container Management:${NC}"
    echo -e "${YELLOW}1.  Start container${NC}"
    echo -e "${YELLOW}2.  Stop container${NC}"
    echo -e "${YELLOW}3.  Restart container${NC}"
    echo -e "${YELLOW}4.  Pause container${NC}"
    echo -e "${YELLOW}5.  Unpause container${NC}"
    echo -e "${YELLOW}6.  List containers${NC}"
    echo -e "${YELLOW}7.  Container logs${NC}"
    echo -e "${YELLOW}8.  Container details${NC}"
    echo -e "${YELLOW}9.  Remove container${NC}"
    echo -e "${YELLOW}10. Container stats${NC}"
    echo -e "${YELLOW}11. Execute command in container${NC}"
    echo -e "${YELLOW}12. Access container shell${NC}"
    echo -e "${YELLOW}13. Container top processes${NC}"
    echo -e "${YELLOW}14. Export container${NC}"
    echo -e "${YELLOW}15. Rename container${NC}"
    echo -e "${YELLOW}16. Update container${NC}"
    
    echo -e "\n${BLUE}Image Management:${NC}"
    echo -e "${YELLOW}17. List images${NC}"
    echo -e "${YELLOW}18. Pull image${NC}"
    echo -e "${YELLOW}19. Remove image${NC}"
    echo -e "${YELLOW}20. Image history${NC}"
    echo -e "${YELLOW}21. Image details${NC}"
    echo -e "${YELLOW}22. Build image${NC}"
    echo -e "${YELLOW}23. Tag image${NC}"
    echo -e "${YELLOW}24. Save image${NC}"
    echo -e "${YELLOW}25. Load image${NC}"
    
    echo -e "\n${BLUE}Volume Management:${NC}"
    echo -e "${YELLOW}26. List volumes${NC}"
    echo -e "${YELLOW}27. Create volume${NC}"
    echo -e "${YELLOW}28. Remove volume${NC}"
    echo -e "${YELLOW}29. Volume details${NC}"
    echo -e "${YELLOW}30. Prune volumes${NC}"
    
    echo -e "\n${BLUE}Network Management:${NC}"
    echo -e "${YELLOW}31. List networks${NC}"
    echo -e "${YELLOW}32. Create network${NC}"
    echo -e "${YELLOW}33. Remove network${NC}"
    echo -e "${YELLOW}34. Network details${NC}"
    echo -e "${YELLOW}35. Connect container to network${NC}"
    echo -e "${YELLOW}36. Disconnect container from network${NC}"
    
    echo -e "\n${BLUE}System:${NC}"
    echo -e "${YELLOW}37. System info${NC}"
    echo -e "${YELLOW}38. Disk usage${NC}"
    echo -e "${YELLOW}39. System cleanup${NC}"
    echo -e "${YELLOW}40. Docker version${NC}"
    echo -e "${YELLOW}41. Docker events${NC}"
    echo -e "${RED}42. Exit${NC}"
    echo
}

start_container() {
    read -p "$(echo -e ${BLUE}"Enter Container Name or ID to start: "${NC})" container
    if docker start "$container"; then
        echo -e "${GREEN}Container $container started successfully!${NC}"
    else
        echo -e "${RED}Failed to start container $container${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

stop_container() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID to stop: "${NC})" container
    if docker stop "$container"; then
        echo -e "${GREEN}Container $container Stopped Successfully!${NC}"
    else
        echo -e "${RED}Failed to stop container $container${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

restart_container() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID to restart: "${NC})" container
    if docker restart "$container"; then
        echo -e "${GREEN}Container $container restarted successfully!${NC}"
    else
        echo -e "${RED}Failed to restart container $container${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

pause_container() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID to pause: "${NC})" container
    if docker pause "$container"; then
        echo -e "${GREEN}Container $container paused successfully!${NC}"
    else
        echo -e "${RED}Failed to pause container $container${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

unpause_container() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID to unpause: "${NC})" container
    if docker unpause "$container"; then
        echo -e "${GREEN}Container $container unpaused successfully!${NC}"
    else
        echo -e "${RED}Failed to unpause container $container${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

list_containers() {
    echo -e "${BLUE}Current running containers:${NC}"
    docker ps
    echo -e "\n${BLUE}All containers (including stopped):${NC}"
    docker ps -a
    read -n 1 -s -r -p "Press any key to continue..."
}

view_logs() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID to view logs: "${NC})" container
    read -p "$(echo -e ${BLUE}"Enter number of lines (press Enter for all): "${NC})" lines
    read -p "$(echo -e ${BLUE}"Follow logs? (y/n): "${NC})" follow
    
    if [ "$follow" = "y" ]; then
        if [ -z "$lines" ]; then
            docker logs -f "$container"
        else
            docker logs -f --tail "$lines" "$container"
        fi
    else
        if [ -z "$lines" ]; then
            docker logs "$container"
        else
            docker logs --tail "$lines" "$container"
        fi
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

container_details() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID: "${NC})" container
    docker inspect "$container" | less
    read -n 1 -s -r -p "Press any key to continue..."
}

remove_container() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID to remove: "${NC})" container
    read -p "$(echo -e ${RED}"Remove with volumes? (y/n): "${NC})" with_volumes
    read -p "$(echo -e ${RED}"Force remove? (y/n): "${NC})" force
    
    options=""
    if [ "$with_volumes" = "y" ]; then
        options="$options -v"
    fi
    if [ "$force" = "y" ]; then
        options="$options -f"
    fi
    
    if docker rm $options "$container"; then
        echo -e "${GREEN}Container removed successfully${NC}"
    else
        echo -e "${RED}Failed to remove container${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

container_stats() {
    read -p "$(echo -e ${BLUE}"Show all containers? (y/n): "${NC})" all
    if [ "$all" = "y" ]; then
        docker stats --all --no-stream
    else
        docker stats --no-stream
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

execute_command() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID: "${NC})" container
    read -p "$(echo -e ${BLUE}"Enter command to execute: "${NC})" cmd
    docker exec "$container" $cmd
    read -n 1 -s -r -p "Press any key to continue..."
}

access_container_shell() {
    clear
    read -p "$(echo -e ${BLUE}"Enter container name or ID: "${NC})" container
    
    if ! docker ps -q -f name="$container" | grep -q .; then
        echo -e "${YELLOW}Container is not running. Starting container...${NC}"
        docker start "$container"
    fi
    
    echo -e "${BLUE}Accessing container shell...${NC}"
    echo -e "${YELLOW}Type 'exit' to return to the menu${NC}"
    echo -e "${BLUE}=================================${NC}"
    
    if docker exec -it "$container" which bash >/dev/null 2>&1; then
        docker exec -it "$container" bash
        clear
        echo -e "${GREEN}Returned from container shell${NC}"
        sleep 1
    elif docker exec -it "$container" which sh >/dev/null 2>&1; then
        docker exec -it "$container" sh
        clear
        echo -e "${GREEN}Returned from container shell${NC}"
        sleep 1
    else
        echo -e "${RED}No shell found in container${NC}"
        read -n 1 -s -r -p "Press any key to continue..."
    fi
}

container_top() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID: "${NC})" container
    docker top "$container"
    read -n 1 -s -r -p "Press any key to continue..."
}

export_container() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID: "${NC})" container
    read -p "$(echo -e ${BLUE}"Enter output filename: "${NC})" filename
    docker export "$container" > "$filename"
    echo -e "${GREEN}Container exported to $filename${NC}"
    read -n 1 -s -r -p "Press any key to continue..."
}

rename_container() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID: "${NC})" container
    read -p "$(echo -e ${BLUE}"Enter new name: "${NC})" new_name
    if docker rename "$container" "$new_name"; then
        echo -e "${GREEN}Container renamed successfully${NC}"
    else
        echo -e "${RED}Failed to rename container${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

update_container() {
    read -p "$(echo -e ${BLUE}"Enter container name or ID: "${NC})" container
    docker update "$container"
    read -n 1 -s -r -p "Press any key to continue..."
}

list_images() {
    echo -e "${BLUE}Available Docker images:${NC}"
    docker images
    read -n 1 -s -r -p "Press any key to continue..."
}

pull_image() {
    read -p "$(echo -e ${BLUE}"Enter image name to pull (format: name:tag or name for latest): "${NC})" image
    echo -e "${BLUE}Pulling image $image...${NC}"
    if docker pull "$image"; then
        echo -e "${GREEN}Image pulled successfully!${NC}"
    else
        echo -e "${RED}Failed to pull image${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

remove_image() {
    read -p "$(echo -e ${BLUE}"Enter image name or ID to remove: "${NC})" image
    read -p "$(echo -e ${RED}"Force remove? (y/n): "${NC})" force
    
    if [ "$force" = "y" ]; then
        docker rmi -f "$image"
    else
        docker rmi "$image"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

image_history() {
    read -p "$(echo -e ${BLUE}"Enter image name or ID: "${NC})" image
    docker history "$image"
    read -n 1 -s -r -p "Press any key to continue..."
}

image_details() {
    read -p "$(echo -e ${BLUE}"Enter image name or ID: "${NC})" image
    docker inspect "$image" | less
    read -n 1 -s -r -p "Press any key to continue..."
}

build_image() {
    read -p "$(echo -e ${BLUE}"Enter path to Dockerfile: "${NC})" path
    read -p "$(echo -e ${BLUE}"Enter tag for new image: "${NC})" tag
    docker build -t "$tag" "$path"
    read -n 1 -s -r -p "Press any key to continue..."
}

tag_image() {
    read -p "$(echo -e ${BLUE}"Enter source image: "${NC})" source
    read -p "$(echo -e ${BLUE}"Enter target tag: "${NC})" target
    docker tag "$source" "$target"
    read -n 1 -s -r -p "Press any key to continue..."
}

save_image() {
    read -p "$(echo -e ${BLUE}"Enter image name: "${NC})" image
    read -p "$(echo -e ${BLUE}"Enter output filename: "${NC})" filename
    docker save "$image" > "$filename"
    echo -e "${GREEN}Image saved to $filename${NC}"
    read -n 1 -s -r -p "Press any key to continue..."
}

load_image() {
    read -p "$(echo -e ${BLUE}"Enter filename to load: "${NC})" filename
    docker load < "$filename"
    read -n 1 -s -r -p "Press any key to continue..."
}

list_volumes() {
    echo -e "${BLUE}Available Docker volumes:${NC}"
    docker volume ls
    read -n 1 -s -r -p "Press any key to continue..."
}

create_volume() {
    read -p "$(echo -e ${BLUE}"Enter volume name: "${NC})" volume
    docker volume create "$volume"
    read -n 1 -s -r -p "Press any key to continue..."
}

remove_volume() {
    read -p "$(echo -e ${BLUE}"Enter volume name: "${NC})" volume
    docker volume rm "$volume"
    read -n 1 -s -r -p "Press any key to continue..."
}

volume_details() {
    read -p "$(echo -e ${BLUE}"Enter volume name: "${NC})" volume
    docker volume inspect "$volume"
    read -n 1 -s -r -p "Press any key to continue..."
}

prune_volumes() {
    read -p "$(echo -e ${RED}"Are you sure you want to remove all unused volumes? (y/n): "${NC})" confirm
    if [ "$confirm" = "y" ]; then
        docker volume prune
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

list_networks() {
    echo -e "${BLUE}Available Docker networks:${NC}"
    docker network ls
    read -n 1 -s -r -p "Press any key to continue..."
}

create_network() {
    read -p "$(echo -e ${BLUE}"Enter network name: "${NC})" network
    read -p "$(echo -e ${BLUE}"Enter driver (bridge/overlay/host/none): "${NC})" driver
    if [ -n "$driver" ]; then
        docker network create --driver "$driver" "$network"
    else
        docker network create "$network"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

remove_network() {
    read -p "$(echo -e ${BLUE}"Enter network name: "${NC})" network
    if docker network rm "$network"; then
        echo -e "${GREEN}Network removed successfully${NC}"
    else
        echo -e "${RED}Failed to remove network${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

network_details() {
    read -p "$(echo -e ${BLUE}"Enter network name: "${NC})" network
    docker network inspect "$network"
    read -n 1 -s -r -p "Press any key to continue..."
}

connect_container_network() {
    read -p "$(echo -e ${BLUE}"Enter container name: "${NC})" container
    read -p "$(echo -e ${BLUE}"Enter network name: "${NC})" network
    if docker network connect "$network" "$container"; then
        echo -e "${GREEN}Container connected to network successfully${NC}"
    else
        echo -e "${RED}Failed to connect container to network${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

disconnect_container_network() {
    read -p "$(echo -e ${BLUE}"Enter container name: "${NC})" container
    read -p "$(echo -e ${BLUE}"Enter network name: "${NC})" network
    if docker network disconnect "$network" "$container"; then
        echo -e "${GREEN}Container disconnected from network successfully${NC}"
    else
        echo -e "${RED}Failed to disconnect container from network${NC}"
    fi
    read -n 1 -s -r -p "Press any key to continue..."
}

system_info() {
    echo -e "${BLUE}Docker System Information:${NC}"
    docker system info
    read -n 1 -s -r -p "Press any key to continue..."
}

disk_usage() {
    echo -e "${BLUE}Docker Disk Usage:${NC}"
    docker system df -v
    read -n 1 -s -r -p "Press any key to continue..."
}

system_cleanup() {
    echo -e "${BLUE}System Cleanup Options:${NC}"
    echo -e "${YELLOW}1. Remove unused containers${NC}"
    echo -e "${YELLOW}2. Remove unused images${NC}"
    echo -e "${YELLOW}3. Remove unused networks${NC}"
    echo -e "${YELLOW}4. Remove unused volumes${NC}"
    echo -e "${YELLOW}5. Remove everything unused${NC}"
    read -p "$(echo -e ${BLUE}"Choose an option: "${NC})" cleanup_choice
    
    case $cleanup_choice in
        1) docker container prune ;;
        2) docker image prune ;;
        3) docker network prune ;;
        4) docker volume prune ;;
        5) docker system prune -a --volumes ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
    read -n 1 -s -r -p "Press any key to continue..."
}

docker_version() {
    echo -e "${BLUE}Docker Version Information:${NC}"
    docker version
    read -n 1 -s -r -p "Press any key to continue..."
}

docker_events() {
    echo -e "${BLUE}Showing Docker events (press Ctrl+C to stop)...${NC}"
    docker events
}

# Main loop
while :; do
    show_menu
    read -p "$(echo -e ${BLUE}"Choose an option: "${NC})" choice
    case $choice in
        1) start_container ;;
        2) stop_container ;;
        3) restart_container ;;
        4) pause_container ;;
        5) unpause_container ;;
        6) list_containers ;;
        7) view_logs ;;
        8) container_details ;;
        9) remove_container ;;
        10) container_stats ;;
        11) execute_command ;;
        12) access_container_shell ;;
        13) container_top ;;
        14) export_container ;;
        15) rename_container ;;
        16) update_container ;;
        17) list_images ;;
        18) pull_image ;;
        19) remove_image ;;
        20) image_history ;;
        21) image_details ;;
        22) build_image ;;
        23) tag_image ;;
        24) save_image ;;
        25) load_image ;;
        26) list_volumes ;;
        27) create_volume ;;
        28) remove_volume ;;
        29) volume_details ;;
        30) prune_volumes ;;
        31) list_networks ;;
        32) create_network ;;
        33) remove_network ;;
        34) network_details ;;
        35) connect_container_network ;;
        36) disconnect_container_network ;;
        37) system_info ;;
        38) disk_usage ;;
        39) system_cleanup ;;
        40) docker_version ;;
        41) docker_events ;;
        42) echo -e "${GREEN}Exiting...${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid option. Please try again.${NC}"
           read -n 1 -s -r -p "Press any key to continue..." ;;
    esac
done
