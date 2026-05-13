#!/bin/bash

# Colores para la interfaz
CIAN='\033[0;36m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
SIN_COLOR='\033[0m'
ROJO='\033[0;31M'

# Dirección del servidor Ground Control local
URL_SERVIDOR="http://localhost:8000"

clear
echo -e "${AMARILLO}=== ENVIANDO TELEMETRÍA A GROUND CONTROL ===${SIN_COLOR}\n"

# 1. Identificación del operador
read -p "Introduce tu nombre de operador: " nombre_operador

# 2. Recopilar datos reales del sistema
echo -e "\n${CIAN}[*] Extrayendo métricas del sistema...${SIN_COLOR}"
ip_local=$(hostname -I | awk '{print $1}')
hostname_sistema=$(hostname)
disco_libre=$(df -h / | awk 'NR==2 {print $4}')
ram_libre=$(free -h | awk 'NR==2 {print $7}')
cpu_uso=$(vmstat 1 2 | tail -n 1 | awk '{print 100 - $15"%"}')

# 3. Formatear el reporte de texto
reporte=$(cat <<EOF
======================================
REPORTE DE INFRAESTRUCTURA
======================================
Operador:        $nombre_operador
Hostname:        $hostname_sistema
IP Local:        $ip_local
Disco Libre:     $disco_libre en /
RAM Disponible:  $ram_libre
Uso CPU Actual:  $cpu_uso
Fecha de Envío:  $(date +"%Y-%m-%d %H:%M:%S")
======================================
EOF
)

# 4. Transmitir datos por POST midiendo el tiempo
echo -e "${CIAN}[*] Transmitiendo datos al servidor central...${SIN_COLOR}"

tiempo_inicio=$(date +%s)
respuesta=$(curl -s --max-time 3 -X POST -d "$reporte" "$URL_SERVIDOR")
codigo_salida=$?
tiempo_fin=$(date +%s)

segundos_totales=$((tiempo_fin - tiempo_inicio))

# 5. Comprobar resultado y mostrar tiempo
if [ $codigo_salida -eq 0 ]; then
    echo -e "\n${VERDE}[+] Respuesta de Ground Control:${SIN_COLOR}"
    echo "$respuesta"
    echo -e "${AMARILLO}[i] Operación completada con éxito en ${segundos_totales} segundos.${SIN_COLOR}"
else
    echo -e "\n${ROJO}[X] Error: No se ha podido conectar con Ground Control. Servidor desconectado.${SIN_COLOR}"
    echo -e "${AMARILLO}[i] Intento de conexión fallido tras ${segundos_totales} segundos.${SIN_COLOR}"
fi


