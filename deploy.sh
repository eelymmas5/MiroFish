#!/bin/bash
# Deploy MiroFish - rebuild frontend and restart services
set -e

cd "$(dirname "$0")"

echo "Building frontend..."
npm run build

echo "Copying to /var/www/mirofish..."
rm -rf /var/www/mirofish/*
cp -r frontend/dist/* /var/www/mirofish/
chmod -R 755 /var/www/mirofish

echo "Restarting backend..."
systemctl restart mirofish-backend

echo "Reloading Caddy..."
systemctl reload caddy

echo "✅ MiroFish deployed! Access at http://152.42.231.162:3080"
