#!/bin/bash
# Shebang: Indica que el script se ejecutará con el intérprete Bash

# ─── Nivel 4: Tu propio Ground Control ──────────────────────────────
# Comentario descriptivo sobre el propósito del script (Cliente Artemis)

# ─── Configuración ──────────────────────────────────────────────────
# Definimos la dirección IP del servidor central (Equipo de Manu)
SERVER_IP="192.168.56.20" 
# Definimos el puerto de red donde escucha el servidor (estándar 8000)
SERVER_PORT="8000"

# ─── Colores para la interfaz (Códigos ANSI) ───────────────────────
VERDE='\033[0;32m'    # Color verde para mensajes de éxito
CIAN='\033[0;36m'     # Color cian para información y procesos
AMARILLO='\033[1;33m' # Color amarillo para títulos y avisos
RESET='\033[0m'       # Reset para volver al color normal de la terminal

# ─── Inicio del Script ──────────────────────────────────────────────
clear                 # Limpiamos la pantalla para una interfaz limpia
echo -e "${AMARILLO}=== CLIENTE ARTEMIS: GROUND CONTROL ===${RESET}" # Título
echo ""                # Línea en blanco para separar

# 1. Pedir nombre al usuario
# 'read -p' muestra el mensaje y espera la entrada del usuario
read -p "Introduce tu nombre de agente: " agente

# 2. Recopilación de información (Reconocimiento básico)
echo -e "${CIAN}[*] Extrayendo datos del sistema...${RESET}"
# 'hostname -I' obtiene la IP; 'awk' extrae solo la primera dirección
ip_local=$(hostname -I | awk '{print $1}') 
# 'hostname' devuelve el nombre asignado al equipo
hostname_sys=$(hostname)                   
# 'uptime -p' devuelve cuánto tiempo lleva el sistema encendido de forma legible
uptime_sys=$(uptime -p)                    

# 3. Creación del reporte temporal
# Definimos una ruta para el archivo temporal de datos
temp_report="/tmp/reporte_artemis.txt"
# '>' crea el archivo (o lo vacía) y escribe la primera línea
echo "---------------------------------------" > "$temp_report"
# '>>' añade texto al final del archivo sin borrar lo anterior
echo "REPORTE DE AGENTE: $agente"               >> "$temp_report"
# '$(date)' ejecuta el comando date e inserta el resultado (fecha y hora)
echo "FECHA: $(date)"                          >> "$temp_report"
echo "---------------------------------------" >> "$temp_report"
echo "HOSTNAME: $hostname_sys"                 >> "$temp_report"
echo "IP LOCAL: $ip_local"                     >> "$temp_report"
echo "UPTIME:   $uptime_sys"                   >> "$temp_report"
echo "---------------------------------------" >> "$temp_report"

# 4. Envío de datos mediante curl
# Explicación de los parámetros de curl:
# -X POST: Especifica que el método de envío HTTP es POST
# --data-binary: Envía el contenido exacto de un archivo
echo -e "${CIAN}[*] Conectando con Ground Control ($SERVER_IP)...${RESET}"

# Intentamos enviar el archivo al servidor y capturamos el código de estado HTTP
# -o /dev/null: Ignora el cuerpo de la respuesta (el HTML del error)
# -w "%{http_code}": Nos devuelve solo el código (200, 501, 404, etc.)
http_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST --data-binary @"$temp_report" "http://$SERVER_IP:$SERVER_PORT")

# Verificamos si el código HTTP es 200 (OK)
if [ "$http_code" -eq 200 ]; then
    echo -e "\n${VERDE}[+] Reporte enviado con éxito (HTTP 200).${RESET}"
else
    echo -e "\n\033[0;31m[!] Error: El servidor respondió con código $http_code\033[0m"
    
    # Explicación específica para el error 501
    if [ "$http_code" -eq 501 ]; then
        echo ">>> Manu está usando 'python -m http.server' (solo GET)."
        echo ">>> Necesita ejecutar el script 'servidor.py' para aceptar POST."
    fi
fi

# 5. Limpieza (Borramos el archivo temporal por seguridad)
# 'rm' elimina el archivo para no dejar rastro de los datos en /tmp
rm "$temp_report"

# Mensaje de despedida
echo -e "\n${AMARILLO}Saliendo del sistema...${RESET}"
echo "" # Salto de línea final
