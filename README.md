# Docker
Learning Docker


What is Docker?

Docker is an open-source containerization platform that allows developers to build, package, ship, and run applications along with all their dependencies in lightweight, portable containers.

In simple terms:

Docker packages an application and everything it needs (code, libraries, runtime, configurations) into a container so it runs the same way on any machine.

Why Docker?

Before Docker:

Developer Machine
    ↓
Works on my laptop

Testing Server
    ↓
Fails ❌

Production Server
    ↓
Different environment ❌

Problems:

Different operating systems
Different library versions
Missing dependencies
Environment mismatch

With Docker:

Docker Image
      ↓
Developer
      ↓
Testing
      ↓
Production

The application runs consistently everywhere.

What is a Container?

A container is a lightweight, isolated environment that contains:

Application code
Runtime (e.g., Java, Python, Node.js)
Libraries
Dependencies
Configuration files

Containers share the host operating system kernel, making them much smaller and faster than virtual machines.

Docker Architecture
                Docker Hub
                     ▲
               Pull / Push Images
                     │
              Docker Engine
         ┌───────────┴───────────┐
         │                       │
   Docker Client            Docker Daemon
   (docker CLI)         (Builds & runs containers)
                             │
                       Images & Containers
Components
Docker Client: You run commands like docker run and docker build.
Docker Daemon: Executes those commands and manages images, containers, networks, and volumes.
Docker Hub: A public repository for Docker images.
Docker Workflow
Dockerfile
      │
      ▼
docker build
      │
      ▼
Docker Image
      │
docker run
      ▼
Docker Container
Docker Image vs Container
Docker Image	Docker Container
Blueprint/template	Running instance of an image
Read-only	Read-write
Cannot execute	Executes the application

Example:

Image = Recipe
Container = Cake made from the recipe
Docker vs Virtual Machine
Docker	Virtual Machine
Shares host OS kernel	Has its own guest OS
Lightweight	Heavy
Starts in seconds	Takes minutes
Uses less memory	Uses more memory
High performance	More resource usage
Basic Docker Commands
# Download an image
docker pull nginx

# List images
docker images

# Run a container
docker run -d -p 8080:80 --name web nginx

# List running containers
docker ps

# Stop a container
docker stop web

# Start a container
docker start web

# View logs
docker logs web

# Execute a command inside a container
docker exec -it web bash

# Remove a container
docker rm -f web
Advantages of Docker
Fast application deployment
Consistent environments across development, testing, and production
Lightweight compared to VMs
Easy scalability
Efficient resource utilization
Simplifies CI/CD pipelines
Supports microservices architecture
Common Use Cases
Web application deployment
Microservices
CI/CD pipelines
Testing and development environments
Running databases (MySQL, PostgreSQL, MongoDB)
Cloud-native applications
Kubernetes workloads
