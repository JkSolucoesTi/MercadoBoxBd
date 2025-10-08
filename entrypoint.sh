#!/bin/bash
set -euo pipefail

# Verifica variável de senha (fornecida em runtime como MSSQL_SA_PASSWORD)
if [ -z "${MSSQL_SA_PASSWORD:-}" ]; then
  echo "ERROR: MSSQL_SA_PASSWORD is not set. Please set it as an environment variable."
  exit 1
fi

echo "🚀 Starting sqlservr in background..."
/opt/mssql/bin/sqlservr &

# Espera e testa a disponibilidade (até ~180s)
echo "⏳ Waiting for SQL Server to come online (max ~3 minutes)..."
for i in $(seq 1 60); do
  if /usr/local/bin/sqlcmd -S localhost -U SA -P "$MSSQL_SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; then
    echo "✅ SQL Server is ready (after $((i*3))s)"
    break
  fi
  echo "...still waiting ($i/60)"
  sleep 3
done

# Se não subiu, aborta (Render mostrará erro nos logs)
if ! /usr/local/bin/sqlcmd -S localhost -U SA -P "$MSSQL_SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; then
  echo "❌ SQL Server did not start in time. See container logs for details."
  exit 1
fi

# Executa init.sql (se falhar, sai com erro)
echo "📁 Executing /usr/src/app/init.sql ..."
/usr/local/bin/sqlcmd -S localhost -U SA -P "$MSSQL_SA_PASSWORD" -i /usr/src/app/init.sql || {
  echo "❌ init.sql execution failed."
  exit 1
}

echo "🏁 Initialization completed — keeping container running."
tail -f /dev/null