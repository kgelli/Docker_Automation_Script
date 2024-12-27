# Docker Management System

A comprehensive command-line interface tool for managing Docker containers, images, volumes, and networks. This script provides an interactive menu-driven interface to perform common Docker operations without needing to remember complex Docker commands.

## Features

### Container Management
- Start, stop, restart, pause, and unpause containers
- View container logs with customizable options
- Display detailed container information
- Remove containers with volume and force options
- Monitor container statistics
- Execute commands inside containers
- Access container shells (bash/sh)
- View container processes
- Export and rename containers

### Image Management
- List available images
- Pull new images from registries
- Remove images with force option
- View image history and details
- Build images from Dockerfiles
- Tag and save images
- Load images from files

### Volume Management
- List, create, and remove volumes
- View volume details
- Prune unused volumes

### Network Management
- List available networks
- Create networks with custom drivers
- Remove networks
- View network details
- Connect/disconnect containers to/from networks

### System Operations
- View system information
- Monitor disk usage
- Perform system cleanup
- View Docker version
- Monitor Docker events

## Prerequisites

- Docker installed and running on your system
- Bash shell
- Basic understanding of Docker concepts

## Installation

1. Download the script:
```bash
curl -O https://raw.githubusercontent.com/username/docker-automation-script/master/docker_automation.sh
```

2. Make the script executable:
```bash
chmod +x docker_automation.sh
```

## Usage

Run the script:
```bash
./docker_automation.sh
```

Use the numbered menu to select the desired operation. Follow the prompts to provide necessary information for each operation.

## Menu Structure

The menu is organized into five main sections:

1. Container Management (Options 1-16)
2. Image Management (Options 17-25)
3. Volume Management (Options 26-30)
4. Network Management (Options 31-36)
5. System Operations (Options 37-41)

## Color Coding

The interface uses color coding for better visibility:
- Blue: Headers and prompts
- Yellow: Menu options
- Green: Success messages
- Red: Error messages and warnings

## Error Handling

The script includes basic error handling for Docker operations. Failed operations will display appropriate error messages in red.
