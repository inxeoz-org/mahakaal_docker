
# Prerequisites

- git
- docker or podman
- docker compose v2 or podman compose

> Install containerization software according to the official maintainer documentation. Avoid package managers when not recommended, as they frequently cause compatibility issues.

# Clone this repo

```bash
git clone https://github.com/frappe/frappe_docker
cd frappe_docker
```

# Define custom apps

If you don't want to install specific apps, skip this section.

To include custom apps in your image, create an `apps.json` file in the repository root (see examples like `apps_mahakaal.json` or `apps_mapit.json`):

```json
[
  {
    "url": "https://github.com/inxeoz/mahakaal_darshan",
    "branch": "develop"
  }
]
```

# Run the setup

## Option 1: Build from Source

Use the provided `run.sh` script to build and run the containers. It handles the base64 encoding, building, and starting the services.

```bash
./run.sh <apps_json_file> <apps_to_install> [port]
```

- `<apps_json_file>`: Path to your apps.json file (e.g., `apps_mahakaal.json`)
- `<apps_to_install>`: Space-separated list of app names to install (e.g., "mahakaal" or "erpnext hrms mahakaal")
- `[port]`: Optional frontend port (default: 8080)

Examples:

```bash
# For mahakaal setup
./run.sh apps_mahakaal.json "mahakaal" 8890

# For mapit setup
./run.sh apps_mapit.json "erpnext hrms healthcare payments non_profit agriculture lms mahakaal" 8881

# Custom setup
./run.sh my_apps.json "my_app" 9000
```

The script will:
- Stop and remove existing containers
- Build the image with your apps
- Start the services
- Display the URL to access the application

### Windows

Use Git Bash or WSL to run the script, as it uses bash syntax.

Alternatively, manually set variables and run compose:

```bash
export APPS_JSON_BASE64=$(base64 -w 0 apps.json)
export APPS_TO_INSTALL="your apps here"
export FRONTEND_PORT=8080
docker compose -f pwd.yml build
docker compose -f pwd.yml up -d
```

## Option 2: Use a Pre-built Image

If you have a pre-built image (e.g., from Docker Hub), create a compose file like `docker_pwd.yml` with the backend using your image:

```yaml
backend:
  restart: always
  image: your-dockerhub-username/your-repo-name:v1.0
```

Then run:

```bash
export APPS_TO_INSTALL="your_app_names"
export FRONTEND_PORT=8000
docker compose -f docker_pwd.yml up -d
```

Wait 5-10 minutes for initialization, then access at http://localhost:8000.

# CACHE_BUST

```bash
CACHE_BUST=$(date +%s) docker compose -f pwd.yml build backend

```
### in windows
```bash
$env:CACHE_BUST = [int](Get-Date -UFormat %s)
docker compose -f pwd.yml build --build-arg CACHE_BUST=$env:CACHE_BUST

```


#TOPICS

> --no-cache
> CACHE_BUST
