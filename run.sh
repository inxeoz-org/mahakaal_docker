#!/usr/bin/env bash

if [ $# -lt 2 ]; then
  echo "Usage: $0 <apps_json_file> <apps_to_install> [port]"
  echo "Example: $0 apps_mahakaal.json 'mahakaal' 8890"
  exit 1
fi

APPS_JSON_FILE=$1
APPS_TO_INSTALL=$2
FRONTEND_PORT=${3:-8080}

if [ ! -f "$APPS_JSON_FILE" ]; then
  echo "Apps JSON file not found: $APPS_JSON_FILE"
  exit 1
fi

export APPS_TO_INSTALL
export FRONTEND_PORT
export APPS_JSON_BASE64=$(base64 -w 0 $APPS_JSON_FILE)

docker compose -f pwd.yml down --volumes

echo "############# APPS_JSON_BASE64 ################"
echo $APPS_JSON_BASE64
echo "############# APPS_JSON_BASE64 ################"

docker compose -f pwd.yml build

docker compose -f pwd.yml up -d

echo "Visit this URL:"
echo "http://localhost:$FRONTEND_PORT/"