Docker

Docker is an open-source containerization platform that packages an application along with its libraries, dependencies, runtime, and configuration into a container, ensuring the application runs consistently across development, testing, and production environments.

Why Docker?
Eliminates "Works on my machine" issues.
Lightweight compared to Virtual Machines (shares host OS kernel).
Faster deployment and scaling.
Better resource utilization and isolation.
Simplifies CI/CD and microservices deployment.

Docker Architecture

Developer
    │
docker CLI (docker run/build/pull)
    │
Docker Daemon (dockerd)
    │
 ├── Images
 ├── Containers
 ├── Networks
 └── Volumes
    │
Docker Registry (Docker Hub/Private Registry)

Components

Component	Description
Docker Client	Executes Docker commands (docker run, docker build).
Docker Daemon	Background service that creates images, containers, networks, and volumes.
Docker Images	Read-only templates used to create containers.
Docker Containers	Running instances of images with a writable layer.
Docker Registry	Stores and distributes Docker images (Docker Hub or private registry).

What Happens When docker run nginx is Executed?
Docker CLI sends request to Docker Daemon.
Daemon checks if the image exists locally.
If not, it pulls the image from Docker Hub.
Image layers are downloaded.
Docker creates a writable container layer.
Namespaces provide process/network/file isolation.
cgroups apply CPU and memory limits.
Network interface is created.
Container starts and the application begins running.


Docker Commands (Group-wise)

1. Information Commands
Command	Purpose
docker version	Docker client & server version
docker info	System information
docker login	Login to registry
docker logout	Logout from registry
docker system df	Show Docker disk usage

2. Image Commands
Command	Purpose
docker search nginx	Search image
docker pull nginx	Download image
docker images / docker image ls	List images
docker inspect nginx	Image details
docker history nginx	Show image layers
docker tag nginx myapp:v1	Create tag
docker push repo/image:v1	Upload image
docker save nginx > nginx.tar	Export image
docker load < nginx.tar	Import image
docker rmi nginx	Remove image

3. Container Commands
Command	Purpose
docker create nginx	Create container only
docker run nginx	Create & start
docker run -d nginx	Run in background
docker run --name web nginx	Assign name
docker run -p 8080:80 nginx	Port mapping
docker run -v data:/app nginx	Mount volume
docker run -e ENV=prod nginx	Environment variable
docker run -it ubuntu bash	Interactive terminal
docker ps / docker ps -a	List containers
docker stop/start/restart <id>	Manage lifecycle
docker pause/unpause <id>	Pause/Resume
docker kill <id>	Force stop
docker rm -f <id>	Delete container
docker rename old new	Rename container
docker inspect <id>	Detailed information

4. Debugging & Monitoring
Command	Purpose
docker logs <id>	Container logs
docker logs -f <id>	Live logs
docker logs --tail 100 <id>	Last 100 logs
docker exec -it <id> bash	Access container shell
docker top <id>	Running processes
docker stats	CPU & Memory usage
docker events	Docker events
docker inspect <id>	Full container configuration

5. File Operations
Command	Purpose
docker cp file.txt container:/tmp	Host → Container
docker cp container:/tmp/file.txt .	Container → Host

6. Volume Commands
Command	Purpose
docker volume create myvol	Create volume
docker volume ls	List volumes
docker volume inspect myvol	Volume details
docker volume rm myvol	Delete volume
docker volume prune	Remove unused volumes

7. Network Commands
Command	Purpose
docker network ls	List networks
docker network create mynet	Create network
docker network inspect mynet	Network details
docker network connect mynet container	Connect container
docker network disconnect mynet container	Disconnect container
docker network rm mynet	Delete network

8. Build Commands
Command	Purpose
docker build -t app:v1 .	Build image
docker build --no-cache .	Ignore cache
docker build -f Dockerfile.dev .	Custom Dockerfile

9. Docker Compose
Command	Purpose
docker compose up -d	Start services
docker compose down	Stop & remove services
docker compose restart	Restart services
docker compose logs	View logs
docker compose ps	List running services
docker compose up --scale web=3 -d	Scale containers

10. Cleanup Commands
Command	Purpose
docker container prune	Remove stopped containers
docker image prune	Remove unused images
docker volume prune	Remove unused volumes
docker network prune	Remove unused networks
docker system prune	Remove all unused resources
docker system prune -a	Remove everything unused
Practical Example
docker pull nginx
docker images
docker run -d --name nginx-server -p 8080:80 nginx
docker ps
docker logs nginx-server
docker exec -it nginx-server bash
docker stop nginx-server
docker start nginx-server
docker rm -f nginx-server

Access:

http://<Server-IP>:8080
