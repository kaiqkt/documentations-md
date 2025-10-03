# Deployment Setup

This document describes how to build and run the Docsify documentation using Docker.

## Prerequisites

- You must have Docker installed on your system.

## Build the Docker Image

To build the Docker image, run the following command in your terminal:

```bash
docker build -t docsify-app .
```

This command builds a Docker image from the `Dockerfile` in the current directory and tags it with the name `docsify-app`.

## Run the Docker Container

To run the Docker container, use the following command:

```bash
docker run -p 3000:3000 docsify-app
```

This command starts a container from the `docsify-app` image and maps port 3000 of the container to port 3000 on your host machine.

## Access the Documentation

You can then access your documentation in your web browser at [http://localhost:3000](http://localhost:3000).
