# How to Create and Share a Docker Image on Docker Hub

This guide explains how to create a Docker image from your running Frappe setup and push it to Docker Hub for sharing.

## Prerequisites

- Docker installed and running
- A Docker Hub account
- Running Frappe containers (built via `./run.sh`)

## Step 1: Commit the Backend Container to a New Image

The backend container contains the built Frappe bench with your apps. Commit it to create a shareable image:

```bash
# Get the container ID
CONTAINER_ID=$(docker ps -qf "name=frappe_docker-backend")

# Commit to a local image
docker commit $CONTAINER_ID frappe_docker_gen:latest
```

## Step 2: Tag the Image for Docker Hub

```bash
docker tag frappe_docker_gen:latest your-dockerhub-username/your-repo-name:v1.0
```

Replace `your-dockerhub-username/your-repo-name:v1.0` with your actual Docker Hub username and desired repo/tag.

## Step 3: Login to Docker Hub

```bash
docker login
```

Enter your credentials when prompted.

## Step 4: Push the Image

```bash
docker push your-dockerhub-username/your-repo-name:v1.0
```

## Step 5: Verify on Docker Hub

Go to https://hub.docker.com/r/your-dockerhub-username/your-repo-name/tags and confirm the image is uploaded.

## Using the Pushed Image

To use the image in a new setup:

1. Create a new compose file (e.g., `docker_pwd.yml`) by copying `pwd.yml` and replacing the backend build section with:

```yaml
backend:
  restart: always
  image: your-dockerhub-username/your-repo-name:v1.0
```

2. Set environment variables:

```bash
export APPS_TO_INSTALL="your_app_names"
export FRONTEND_PORT=8000
```

3. Run the setup:

```bash
docker compose -f docker_pwd.yml up -d
```

Wait 5-10 minutes for initialization, then visit http://localhost:8000.

## Additional Notes

- Use semantic versioning for tags (e.g., v1.0.0)
- Include a README in your Docker Hub repo describing the image contents and setup
- For production, consider building from scratch using Docker Bake instead of committing

## Troubleshooting

- Ensure the backend container is running when committing
- If push fails, check login and repo permissions
- For full functionality, always run with the complete compose setup (DB, Redis, etc.)</content>
<parameter name="filePath">how_to_create_docker_image.md