@echo off

REM Set environment variables for the Frappe Docker setup
set APPS_TO_INSTALL=custom_booking mahakaal
set FRONTEND_PORT=7676

REM Run the Docker Compose setup
docker compose -f cm.yml up -d

echo Setup started. Wait 5-10 minutes, then visit http://localhost:%FRONTEND_PORT%
