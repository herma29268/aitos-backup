# AITOS Backup & Recovery

> Complete setup documentation, scripts, and configurations for the AITOS trading bot.
> If Hermes session is lost, use this repo to restore everything.

## 📁 Structure

```
aitos-backup/
├── README.md              ← You are here
├── scripts/
│   ├── 01-server-setup.sh     ← Full server setup (Stage 1)
│   ├── 02-project-build.sh    ← Project build (Stage 2)
│   ├── 03-integration-test.sh ← Integration tests (Stage 3)
│   ├── 04-backtest.sh         ← Backtesting (Stage 4)
│   └── ssh-connect.sh         ← SSH connection helper
├── configs/
│   ├── .env.template          ← Environment variables template
│   ├── sshd_config            ← SSH config (port 443)
│   └── docker-compose.yml     ← Docker compose config
└── docs/
    ├── SERVER_INFO.md         ← Server details
    ├── SETUP_LOG.md           ← What was done step by step
    ├── STAGE_REPORTS.md       ← Reports from each stage
    └── ARCHITECTURE.md        ← Project architecture overview
```

## 🚀 Quick Recovery

If you need to restore on a new server:

```bash
# 1. Clone this backup
git clone https://github.com/herma29268/aitos-backup.git

# 2. Run server setup
bash scripts/01-server-setup.sh

# 3. Run project build
bash scripts/02-project-build.sh

# 4. Connect Hermes
# Just point Hermes to docs/SERVER_INFO.md and docs/SETUP_LOG.md
```

## 🔐 Credentials

All credentials are stored securely in this repo (encrypted) or referenced by name.
- API keys are in the `.env` file on the server
- This repo only contains templates, not actual secrets
