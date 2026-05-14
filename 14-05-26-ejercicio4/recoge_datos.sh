#!/bin/bash

# 1. Solicitar datos al usuario
echo "=== Registro de Auditoría de Usuario ==="
read -p "Introduce tu nombre completo: " NOMBRE

# 2. Recolectar datos del sistema automáticamente
IP_LOCAL=$(hostname -I | awk '{print $1}')
FECHA=$(date '+%Y-%m-%d %H:%M:%S')

# 3. Formatear la carga útil en formato JSON
PAYLOAD=$(cat <<EOF
{
  "nombre": "$NOMBRE",
  "ip": "$IP_LOCAL",
  "fecha": "$FECHA"
}
EOF
)

# 4. Enviar los datos al servidor de reportes (Puerto 5000)
echo "Enviando reporte al servidor central..."
curl -X POST \
     -H "Content-Type: application/json" \
     -d "$PAYLOAD" \
# Aquí se debe reemplazar por la IP de server
     http://IP_DEL_SERVIDOR:5000/reporte
