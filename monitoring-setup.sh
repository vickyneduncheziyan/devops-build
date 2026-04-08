#!/bin/bash
# monitoring-setup.sh — Installs Uptime Kuma via Docker for app health monitoring

set -e

echo "=============================="
echo " Setting up Uptime Kuma"
echo "=============================="

# Pull and run Uptime Kuma on port 3001
docker run -d \
  --name uptime-kuma \
  --restart always \
  -p 3001:3001 \
  -v uptime-kuma:/app/data \
  louislam/uptime-kuma:latest

echo "=============================="
echo " Uptime Kuma is running!"
echo " Open: http://$(curl -s ifconfig.me):3001"
echo " 1. Create an admin account"
echo " 2. Add a monitor -> HTTP(s) -> http://localhost:80"
echo " 3. Set up notifications (Email/Telegram/Slack) for DOWN alerts"
echo "=============================="
