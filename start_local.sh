#!/bin/bash

echo "🚀 Iniciando HypeMiddTV Trading Bot..."
echo ""

# Verificar se MongoDB está rodando
echo "📦 Verificando MongoDB..."
if ! sudo systemctl is-active --quiet mongod; then
    echo "   Iniciando MongoDB..."
    sudo systemctl start mongod
    sleep 2
fi
echo "   ✅ MongoDB rodando"

# Iniciar Backend
echo ""
echo "🔧 Iniciando Backend..."
cd /home/ubuntu/HypeMiddTV_Manus/backend
if pgrep -f "uvicorn server:app" > /dev/null; then
    echo "   ⚠️  Backend já está rodando"
else
    nohup uvicorn server:app --host 0.0.0.0 --port 8000 > backend.log 2>&1 &
    sleep 3
    echo "   ✅ Backend iniciado na porta 8000"
fi

# Iniciar Frontend
echo ""
echo "🎨 Iniciando Frontend..."
cd /home/ubuntu/HypeMiddTV_Manus/frontend
if lsof -ti:3000 > /dev/null 2>&1; then
    echo "   ⚠️  Frontend já está rodando"
else
    BROWSER=none nohup yarn start > frontend.log 2>&1 &
    echo "   ⏳ Aguardando compilação (pode levar ~30s)..."
    sleep 30
    echo "   ✅ Frontend iniciado na porta 3000"
fi

echo ""
echo "✨ Ambiente iniciado com sucesso!"
echo ""
echo "📍 URLs de Acesso:"
echo "   Frontend: http://localhost:3000"
echo "   Backend:  http://localhost:8000"
echo "   API Status: http://localhost:8000/api/status"
echo ""
echo "📋 Para verificar logs:"
echo "   Backend:  tail -f /home/ubuntu/HypeMiddTV_Manus/backend/backend.log"
echo "   Frontend: tail -f /home/ubuntu/HypeMiddTV_Manus/frontend/frontend.log"
echo ""
