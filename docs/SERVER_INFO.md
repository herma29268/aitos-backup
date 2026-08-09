# AITOS Server Information

## Server Details

| Field | Value |
|:------|:------|
| **IP Address** | 46.249.100.236 |
| **SSH Port** | 443 |
| **SSH User** | root |
| **SSH Key** | `~/.ssh/hermes_aitos` (Ed25519) |
| **OS** | Ubuntu 24.04 LTS |
| **RAM** | 2 GB |
| **CPU** | 1 vCPU |
| **Disk** | 40 GB SSD |
| **Provider** | ParsPack |

## Services Running

| Service | Port | Status |
|:--------|:-----|:-------|
| SSH | 443 | ✅ Active |
| PostgreSQL | 5432 | ✅ Active |
| Redis | 6379 | ✅ Active |
| Docker | 2375 | ✅ Active |

## Database

| Field | Value |
|:------|:------|
| **Host** | localhost |
| **Port** | 5432 |
| **Database** | aitos |
| **User** | aitos_app |
| **Password** | aitos_secure_2024 |

## Connections

### Hyperliquid Testnet
| Field | Value |
|:------|:------|
| **Wallet Address** | 0x5dd78c90bcd8ee2b8e46423f26960dd35fef98a0 |
| **API Wallet** | 0xcEDC26d59B3eC5AB454B97363C3962d1Ff5F4B77 |
| **Network** | Testnet |
| **Account Value** | $999.00 |

### Telegram Bot
| Field | Value |
|:------|:------|
| **Bot Token** | Configured in .env |
| **Allowed User ID** | 7087863578 |

## SSH Key Management

### Adding SSH Key
```bash
# On the server
echo "<YOUR_PUBLIC_KEY>" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

### Key Fingerprint
```
SHA256:LEIu9XuKk/s3nnuHuDTRtUxak/HadpdSr1lKbsWhkkE hermes-agent-aitos
```
