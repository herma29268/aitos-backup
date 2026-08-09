#!/bin/bash
# ============================================
# AITOS Project Build Script - Stage 2
# Run this after 01-server-setup.sh
# ============================================

set -e

echo "🏗️ Starting AITOS Project Build..."

# --- 1. Clone repository ---
echo "📥 Cloning AITOS repository..."
cd /opt
mkdir -p aitos
cd aitos

# Clone from GitHub (replace with your token if private)
git clone https://github.com/herma29268/aitos.git .

# --- 2. Extract Package 17 (latest) ---
echo "📦 Extracting Package 17..."
python3.11 -c "
import zipfile
with zipfile.ZipFile('Package17_AITOS_Telegram_Control_Operations.zip', 'r') as zf:
    zf.extractall('.')
print('✅ Package 17 extracted')
"

# --- 3. Setup Python virtual environment ---
echo "🐍 Setting up Python environment..."
python3.11 -m venv venv
source venv/bin/activate

# --- 4. Install dependencies ---
echo "📚 Installing dependencies..."
pip install --upgrade pip
pip install -e '.[dev]'
pip install pyyaml

# --- 5. Configure .env ---
echo "⚙️ Configuring environment..."
cat > .env << 'EOF'
# AITOS Environment Configuration

# --- General ---
AITOS_ENVIRONMENT=development
AITOS_PROJECT_VERSION=0.17.0

# --- Database (PostgreSQL) ---
AITOS_DB_HOST=localhost
AITOS_DB_PORT=5432
AITOS_DB_NAME=aitos
AITOS_DB_USER=aitos_app
AITOS_DB_PASSWORD=aitos_secure_2024

# --- Hyperliquid Testnet ---
HYPERLIQUID_API_WALLET_ADDRESS=<YOUR_API_WALLET_ADDRESS>
HYPERLIQUID_API_PRIVATE_KEY=<YOUR_API_PRIVATE_KEY>
HYPERLIQUID_WALLET_ADDRESS=<YOUR_WALLET_ADDRESS>
HYPERLIQUID_TESTNET=true

# --- Telegram Bot ---
TELEGRAM_BOT_TOKEN=<YOUR_TELEGRAM_BOT_TOKEN>
TELEGRAM_ALLOWED_USER_IDS=<YOUR_TELEGRAM_USER_ID>

# --- Redis ---
REDIS_URL=redis://localhost:6379/0
EOF

# --- 6. Initialize database tables ---
echo "🗄️ Initializing database..."
python3.11 -c "
import asyncio
from sqlalchemy.ext.asyncio import create_async_engine

async def init_db():
    engine = create_async_engine('postgresql+asyncpg://aitos_app:aitos_secure_2024@localhost:5432/aitos')
    
    from aitos.risk_management import models as rm
    from aitos.execution import models as ex
    from aitos.portfolio import models as pm
    from aitos.position_management import models as pos
    from aitos.monitoring import models as mon
    from aitos.operations import models as ops
    from aitos.backtesting import models as bt
    
    async with engine.begin() as conn:
        for mod in [rm, ex, pm, pos, mon, ops, bt]:
            if hasattr(mod, 'Base'):
                await conn.run_sync(mod.Base.metadata.create_all)
                print(f'  ✅ {mod.__name__} tables created')
    
    print('✅ All database tables initialized')
    await engine.dispose()

asyncio.run(init_db())
"

# --- 7. Fix script permissions ---
echo "🔧 Fixing permissions..."
chmod +x scripts/*.sh deploy/entrypoint.sh 2>/dev/null || true

# --- 8. Run tests ---
echo "🧪 Running tests..."
python -m pytest tests/test_deployment.py -ra --tb=short

# --- 9. Verify ---
echo ""
echo "✅ Build complete!"
echo "Python: $(python3.11 --version)"
echo "AITOS: $(pip show aitos | grep Version)"
echo ""
echo "📋 Next steps:"
echo "1. Edit .env with your API keys"
echo "2. Test Hyperliquid connection"
echo "3. Test Telegram bot"
