#!/bin/bash

set -e

for var in DB_HOST DB_NAME DB_USER DB_PASSWORD; do
    if [ -z "${!var}" ]; then
        echo "ERROR: $var is not set. Please export it before running this script."
        exit 1
    fi
done

echo "Starting Sengoku app..."
echo "  DB_HOST: $DB_HOST"
echo "  DB_NAME: $DB_NAME"
echo "  DB_USER: $DB_USER"

docker-compose up -d --build

echo ""
echo "   App started! Frontend is running on port 80."

