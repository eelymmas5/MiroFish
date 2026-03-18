#!/bin/bash
# Deploy MiroFish - rebuild frontend and restart services
set -e

cd "$(dirname "$0")"

echo "Building frontend..."
VITE_BASE_PATH=/mirofish/ VITE_API_BASE_URL=/mirofish npm run build

echo "Copying to /var/www/mirofish..."
rm -rf /var/www/mirofish/*
cp -r frontend/dist/* /var/www/mirofish/
chmod -R 755 /var/www/mirofish

echo "Restarting backend..."
systemctl restart mirofish-backend

echo "Reloading Caddy..."
systemctl reload caddy

echo "✅ MiroFish deployed! Access at https://152.42.231.162/mirofish/"
