#!/bin/bash
# ============================================
# AITOS SSH Connection Helper
# Connect to the AITOS server
# ============================================

SERVER_IP="46.249.100.236"
SERVER_PORT="443"
SERVER_USER="root"
SSH_KEY="$HOME/.ssh/hermes_aitos"

echo "🔐 Connecting to AITOS server..."
echo "   IP: $SERVER_IP"
echo "   Port: $SERVER_PORT"
echo "   User: $SERVER_USER"
echo ""

ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no -p "$SERVER_PORT" "${SERVER_USER}@${SERVER_IP}" "$@"
