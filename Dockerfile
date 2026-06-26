Dockerfile - Complete Detailed Guide
What is a Dockerfile?

A Dockerfile is a text file that contains a set of instructions used to build a Docker Image automatically.

Instead of manually installing software inside a container, you write the steps in a Dockerfile, and Docker builds the image for you.

Think of it as a recipe for creating a Docker image.

Why Do We Need Dockerfile?

Without Dockerfile:

Pull Ubuntu
      │
      ▼
Run Container
      │
Install Python
      │
Install Nginx
      │
Copy Application
      │
Configure Environment
      │
Save Image

Every developer must repeat these steps manually.

With Dockerfile:

Dockerfile
      │
docker build
      │
Docker Image
      │
docker run
      │
Container

Everything is automated and reproducible.

Dockerfile Workflow
Dockerfile
     │
     ▼
docker build
     │
     ▼
Docker Image
     │
     ▼
docker run
     │
     ▼
Running Container
Basic Dockerfile Example
FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y nginx

CMD ["nginx", "-g", "daemon off;"]

Build it:

docker build -t my-nginx .

Run it:

docker run -d -p 8080:80 my-nginx
Dockerfile Instructions
1. FROM (Mandatory)

Defines the base image.

FROM ubuntu:22.04

Examples:

FROM ubuntu
FROM nginx
FROM python:3.12
FROM node:20
FROM alpine

Without FROM, Docker cannot build the image.

2. RUN

Executes commands during image build.

RUN apt-get update

Install packages:

RUN apt-get install -y nginx

Multiple commands:

RUN apt-get update && \
    apt-get install -y nginx curl git
Difference

RUN executes only once during build.

3. CMD

Defines the default command when the container starts.

CMD ["nginx","-g","daemon off;"]

Another example:

CMD ["python","app.py"]

Only one CMD is allowed.

If multiple exist:

CMD ["echo","Hello"]

CMD ["python","app.py"]

Only the last one runs.

4. ENTRYPOINT

Specifies the main executable.

ENTRYPOINT ["python"]

With CMD:

ENTRYPOINT ["python"]

CMD ["app.py"]

Runs:

python app.py
CMD vs ENTRYPOINT
CMD	ENTRYPOINT
Default command	Fixed executable
Can be overridden	Harder to override
Optional	Usually the main process
5. COPY

Copies files from the host to the image.

Project:

project/

app.py

Dockerfile

Dockerfile:

COPY app.py /app/

Meaning:

Host
app.py
    │
    ▼
Image
/app/app.py

Copy entire folder:

COPY . /app
6. ADD

Similar to COPY but has extra features.

ADD app.tar.gz /app/

Automatically extracts archives.

Can also download URLs (though COPY is generally preferred for local files).

COPY vs ADD
COPY	ADD
Copies local files	Copies local files + extracts archives
Preferred	Use only when needed
7. WORKDIR

Sets the working directory.

WORKDIR /app

Now:

COPY . .

RUN pip install -r requirements.txt

runs inside /app.

Without WORKDIR:

RUN cd /app

This directory change does not persist across Dockerfile instructions.

8. ENV

Sets environment variables.

ENV APP_ENV=production

Multiple:

ENV DB_HOST=mysql

ENV DB_PORT=3306

Access inside the container:

echo $APP_ENV
9. EXPOSE

Documents the port the application listens on.

EXPOSE 80

Important:

Does not publish the port.
Use -p during docker run.

Run:

docker run -p 8080:80 myapp
10. LABEL

Adds metadata.

LABEL author="Pradeep"

LABEL version="1.0"

Useful for image information.

11. USER

Run the application as a specific user.

USER appuser

Better security than running as root.

12. ARG

Defines build-time variables.

ARG VERSION=1.0

Build:

docker build --build-arg VERSION=2.0 .

Available only during image build.

13. VOLUME

Creates a mount point.

VOLUME ["/data"]

Used for persistent data.

Complete Dockerfile Example
Python Flask Application

Project:

flask-app/

Dockerfile

requirements.txt

app.py
app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Docker is Awesome!"

app.run(host="0.0.0.0", port=5000)
requirements.txt
flask
Dockerfile
FROM python:3.12

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python","app.py"]
Build Image
docker build -t flask-app .

Options:

docker build -t flask-app:v1 .

docker build -f Dockerfile.dev .

docker build --no-cache .

docker build --build-arg VERSION=2 .
Run Container
docker run -d \
--name flask \
-p 5000:5000 \
flask-app

Open:

http://localhost:5000
Docker Build Process
Dockerfile
      │
FROM python
      │
RUN pip install
      │
COPY files
      │
EXPOSE
      │
CMD
      │
Image Created

Each instruction creates a new image layer.

Docker Image Layers
Layer 5

CMD

----------------

Layer 4

COPY

----------------

Layer 3

RUN

----------------

Layer 2

WORKDIR

----------------

Layer 1

FROM python

Benefits:

Faster rebuilds (layer caching)
Shared storage between images
Efficient image downloads
Dockerfile Best Practices

✅ Use a small base image (e.g., alpine when appropriate).

FROM alpine

✅ Combine related RUN commands to reduce layers.

RUN apt-get update && \
    apt-get install -y curl git && \
    apt-get clean

✅ Use .dockerignore.

Example .dockerignore:

.git
node_modules
*.log
__pycache__

Prevents unnecessary files from being copied into the build context.

✅ Pin image versions.

Instead of:

FROM python:latest

Use:

FROM python:3.12

✅ Run as a non-root user when possible.

USER appuser
Important Dockerfile Commands
Command	Purpose
FROM	Base image
RUN	Execute build-time commands
COPY	Copy files
ADD	Copy files and extract archives
WORKDIR	Set working directory
CMD	Default startup command
ENTRYPOINT	Main executable
EXPOSE	Document application port
ENV	Environment variables
ARG	Build-time variables
LABEL	Metadata
USER	Run as a specific user
VOLUME	Persistent storage
Docker Build Commands
# Build image
docker build -t app .

# Build with version tag
docker build -t app:v1 .

# Specify Dockerfile
docker build -f Dockerfile.dev .

# Build without cache
docker build --no-cache .

# Pass build arguments
docker build --build-arg VERSION=2.0 .

# List images
docker images

# Run image
docker run app

# Remove image
docker rmi app
Interview Questions
1. What is a Dockerfile?

A text file containing instructions to build a Docker image automatically.

2. What is the difference between RUN and CMD?
RUN: Executes during image build and creates a new image layer.
CMD: Specifies the default command executed when the container starts.
3. What is the difference between CMD and ENTRYPOINT?
CMD: Provides default arguments or a default command that can be overridden.
ENTRYPOINT: Defines the main executable for the container and is intended to always run.
4. What is the difference between COPY and ADD?
COPY: Copies local files and directories.
ADD: Can also extract local archives automatically (and supports additional features), so COPY is preferred unless those features are needed.
5. Why use WORKDIR?

It sets the default working directory for subsequent instructions, making Dockerfiles cleaner and avoiding repeated cd commands.

6. Does EXPOSE publish a port?

No. It only documents the intended listening port. You must use docker run -p host_port:container_port to publish it.

Quick Revision
FROM        → Base Image
RUN         → Execute build commands
COPY        → Copy files
ADD         → Copy/extract files
WORKDIR     → Working directory
ENV         → Environment variables
EXPOSE      → Document port
CMD         → Default startup command
ENTRYPOINT  → Main executable
ARG         → Build-time variable
LABEL       → Metadata
USER        → Run as non-root user
VOLUME      → Persistent storage

Dockerfile flow:

Write Dockerfile
        │
        ▼
docker build -t myapp .
        │
        ▼
Docker Image
        │
        ▼
docker run myapp
        │
        ▼
Running Container
