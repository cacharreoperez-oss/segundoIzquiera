#!/bin/bash
# Shebang: indica que el script debe ejecutarse con el intérprete Bash

# Variables: inicialización de variables vacías para almacenar la información del sistema
ip=""              # Almacenará la dirección IP local
hostname_val=""    # Almacenará el nombre del equipo
espacio_disco=""   # Almacenará el espacio disponible en la raíz (/)
ram_libre=""       # Almacenará la memoria RAM disponible actualmente
ultimo_login=""    # Almacenará la información de la última sesión iniciada

# ─── Colores (Códigos de escape ANSI para dar formato visual en la terminal) ──
VERDE='\033[0;32m'    # Define el color verde
CIAN='\033[0;36m'     # Define el color cian
AMARILLO='\033[1;33m' # Define el color amarillo (en negrita/brillante)
BLANCO='\033[1;37m'   # Define el color blanco (en negrita/brillante)
RESET='\033[0m'       # Código para restaurar el color por defecto de la terminal, este lo necesitamos para que el texto vuelva a su color normal

# ─── Función: barra de progreso ───────────────────────────────────────────
# Esta función simula visualmente una carga para mejorar la experiencia de usuario
barra_progreso() {
    local mensaje="$1"   # Recibe el primer argumento (el texto a mostrar antes de la barra)
    local barra=""       # Inicializa la cadena de la barra de progreso vacía
    for i in $(seq 1 30); do # Bucle que se repite 30 veces para dibujar la barra
        barra="${barra}#"   # Añade un carácter '#' a la variable barra en cada iteración
        # \r vuelve al inicio de la línea. %-30s reserva un espacio de 30 caracteres alineado a la izquierda
        printf "\r  ${CIAN}${mensaje}${RESET} [${VERDE}%-30s${RESET}]" "$barra"
        sleep 0.03          # Pausa de 0.03 segundos para que la animación sea visible
    done
    echo "" # Salto de línea al terminar la barra
}

# ─── Banner (Presentación visual del script) ──────────────────────────────
clear # Limpia toda la pantalla de la terminal
echo -e "${AMARILLO}" # Cambia el color a amarillo para el dibujo ASCII
cat << 'EOF' # Imprime el bloque de texto hasta encontrar la palabra EOF (End Of File)
  __  __ _       _   ____
  |  \/  (_)_ __ (_) |  _ \ ___  ___ ___  _ __
  | |\/| | | '_ \| | | |_) / _ \/ __/ _ \| '_ \
  | |  | | | | | | | |  _ <  __/ (_| (_) | | | |
  |_|  |_|_|_| |_|_| |_| \_\___|\___\___/|_| |_|
EOF
echo -e "${RESET}" # Resetea el color al terminar el dibujo
echo -e "  ${BLANCO}======================================${RESET}" # Línea decorativa blanca
echo -e "  ${BLANCO}        MINI RECON SCRIPT v1.0        ${RESET}" # Nombre del script
echo -e "  ${BLANCO}======================================${RESET}" # Línea decorativa blanca
echo "" # Imprime una línea vacía para separar secciones

# ─── Recolección con barras de progreso (Ejecución de comandos del sistema) ──
barra_progreso "[*] Obteniendo IP...       "
# Obtiene la IP con 'hostname -I' y extrae la primera con 'awk'
ip=$(hostname -I | awk '{print $1}')

barra_progreso "[*] Obteniendo hostname... "
# Ejecuta el comando 'hostname' para obtener el nombre de la máquina
hostname_val=$(hostname)

barra_progreso "[*] Leyendo disco...       "
# 'df -h /' muestra info del disco raíz; 'awk' extrae la columna 4 (Available) de la fila 2
espacio_disco=$(df -h / | awk 'NR==2 {print $4}')

barra_progreso "[*] Leyendo RAM libre...   "
# 'free -h' muestra memoria; 'awk' busca la línea 'Mem:' y extrae la columna 7 (Available)
ram_libre=$(free -h | awk '/^Mem:/ {print $7}')

barra_progreso "[*] Leyendo último login..."
# 'who' muestra usuarios conectados; 'tail -1' se queda solo con la última línea
ultimo_login=$(who | tail -1)

# ─── Resultados (Muestra la información recolectada de forma ordenada) ──────
echo "" # Salto de línea previo
echo -e "  ${BLANCO}======================================${RESET}" # Línea divisoria
echo -e "  ${AMARILLO}            RESULTADOS               ${RESET}" # Encabezado de resultados
echo -e "  ${BLANCO}======================================${RESET}" # Línea divisoria
echo -e "  ${CIAN}IP:           ${RESET}${ip}"          # Muestra la variable IP
echo -e "  ${CIAN}HOSTNAME:     ${RESET}${hostname_val}" # Muestra la variable hostname
echo -e "  ${CIAN}DISCO LIBRE:  ${RESET}${espacio_disco}" # Muestra el espacio de disco
echo -e "  ${CIAN}RAM LIBRE:    ${RESET}${ram_libre}"    # Muestra la RAM disponible
echo -e "  ${CIAN}ÚLTIMO LOGIN: ${RESET}${ultimo_login}" # Muestra la info del último login
echo -e "  ${BLANCO}======================================${RESET}" # Línea divisoria final
echo "" # Salto de línea final