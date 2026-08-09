# AITOS Architecture Overview

## Project Structure

**AITOS** = Artificial Intelligence Trading Operating System
**Version:** 0.17.0
**Python:** 3.11+
**Exchange:** Hyperliquid (Testnet)

---

## Package Breakdown

| Package | Version | Purpose |
|:--------|:--------|:--------|
| 01 | 0.1.0 | Foundation (interfaces, config, errors) |
| 02 | 0.2.0 | Data Ingestion |
| 03 | 0.3.0 | Feature Engineering |
| 04 | 0.4.0 | Indicator Library |
| 05 | 0.5.0 | Decision Engine |
| 06 | 0.6.0 | Risk Management |
| 07 | 0.7.0 | Evidence System |
| 08 | 0.8.0 | Analysis Engines |
| 09 | 0.9.0 | Backtesting Core |
| 10 | 0.10.0 | Execution Layer |
| 11 | 0.11.0 | Full Integration |
| 12 | 0.12.0 | Position Management |
| 13 | 0.13.0 | Portfolio Management |
| 14 | 0.14.0 | Backtesting Models |
| 15 | 0.15.0 | Monitoring & Alerting |
| 16 | 0.16.0 | Deployment (Docker) |
| 17 | 0.17.0 | Telegram Control |

---

## Data Flow

```
Market Data (Hyperliquid)
    ↓
Data Ingestion (P02)
    ↓
Feature Engineering (P03) + Indicator Library (P04)
    ↓
Analysis Engines (P08)
    ↓
Decision Engine (P05) + Evidence System (P07)
    ↓
Risk Management (P06)
    ↓
Execution Layer (P10) → Hyperliquid Exchange
    ↓
Position Management (P12) + Portfolio Management (P13)
    ↓
Monitoring (P15) → Telegram Alerts (P17)
```

---

## Tech Stack

| Layer | Technology |
|:------|:-----------|
| Language | Python 3.11+ |
| Modeling | Pydantic v2 |
| Database | PostgreSQL 16 / TimescaleDB |
| Cache | Redis 7 |
| Exchange | Hyperliquid (python-sdk) |
| Control | Telegram Bot |
| Deployment | Docker + Docker Compose |
| Tools | ruff (lint), mypy (types), pytest |

---

## Key Components

### Workers (implement IModule interface)
- `DecisionEngineWorker` - Trading decisions
- `RiskManagementWorker` - Risk checks
- `ExecutionWorker` - Order execution
- `PositionManagementWorker` - Position tracking
- `MonitoringWorker` - System monitoring
- `TelegramBotWorker` - Telegram control

### Control Plane
- `TradingControlService` - Live control (pause/resume/kill_switch)
- Telegram commands: `/pause`, `/resume`, `/kill_switch`

---

## Deployment

### Docker Compose Services
- `postgres` - PostgreSQL 14
- `redis` - Redis 7
- `aitos` - Main application
- `nginx` - Reverse proxy

### Commands
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f aitos

# Stop all services
docker-compose down
```
