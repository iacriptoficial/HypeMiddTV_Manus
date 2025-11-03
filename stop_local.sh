#!/bin/bash

echo "🛑 Parando HypeMiddTV Trading Bot..."
echo ""

# Parar Frontend
echo "🎨 Parando Frontend..."
if lsof -ti:3000 > /dev/null 2>&1; then
    lsof -ti:3000 | xargs kill -9 2>/dev/null
    echo "   ✅ Frontend parado"
else
    echo "   ℹ️  Frontend não estava rodando"
fi

# Parar Backend
echo ""
echo "🔧 Parando Backend..."
if pgrep -f "uvicorn server:app" > /dev/null; then
    pkill -f "uvicorn server:app"
    echo "   ✅ Backend parado"
else
    echo "   ℹ️  Backend não estava rodando"
fi

echo ""
echo "✅ Ambiente parado com sucesso!"
echo ""
