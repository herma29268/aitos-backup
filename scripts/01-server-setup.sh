#!/bin/bash
# ============================================
# AITOS Server Setup Script - Stage 1
# Run this on a fresh Ubuntu 24.04 server
# ============================================

set -e

echo "🔧 Starting AITOS Server Setup..."

# --- 1. System Update ---
echo "📦 Updating system..."
apt-get update && apt-get upgrade -y

# --- 2. Install base packages ---
echo "📦 Installing base packages..."
apt-get install -y software-properties-common curl git wget gnupg lsb-release ca-certificates

# --- 3. Install Python 3.11 ---
echo "🐍 Installing Python 3.11..."
add-apt-repository -y ppa:deadsnakes/ppa
apt-get update
apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip

# --- 4. Install PostgreSQL ---
echo "🗄️ Installing PostgreSQL..."
apt-get install -y postgresql postgresql-contrib
systemctl enable postgresql
systemctl start postgresql

# --- 5. Install Docker ---
echo "🐳 Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh
systemctl enable docker
systemctl start docker

# --- 6. Install Redis ---
echo "🔴 Installing Redis..."
apt-get install -y redis-server
systemctl enable redis-server
systemctl start redis-server

# --- 7. Install OpenSSH ---
echo "🔐 Installing OpenSSH..."
apt-get install -y openssh-server

# --- 8. Create database ---
echo "🗄️ Creating database..."
su - postgres -c "psql -c \"CREATE USER aitos_app WITH PASSWORD 'aitos_secure_2024';\""
su - postgres -c "psql -c \"CREATE DATABASE aitos OWNER aitos_app;\""
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE aitos TO aitos_app;\""

# --- 9. Verify ---
echo ""
echo "✅ Setup complete! Versions:"
python3.11 --version
psql --version
docker --version
redis-cli ping

echo ""
echo "📋 Next steps:"
echo "1. Configure SSH port: nano /etc/ssh/sshd_config"
echo "2. Add SSH key: nano ~/.ssh/authorized_keys"
echo "3. Run: bash scripts/02-project-build.sh"
