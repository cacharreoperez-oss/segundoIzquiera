#!/bin/bash

# Colores ANSI para la interfaz
VERDE='\033[0;32m'
AZUL='\033[0;34m'
CIAN='\033[0;36m'
AMARILLO='\033[1;33m'
ROJO='\033[0;31m'
SIN_COLOR='\033[0m'

# Inicialización de variables
puntuacion=0
total_preguntas=10

# 1. DEFINICIÓN DE LOS ARRAYS DE PREGUNTAS
preguntas=(
    "¿Qué comando muestra el espacio libre en el disco duro?"
    "¿Qué comando muestra el estado y uso de la memoria RAM?"
    "¿Qué comando muestra la dirección IP local de la máquina?"
    "¿Qué comando se usa para ver los últimos inicios de sesión?"
    "¿Qué secuencia de escape se usa para volver al inicio de la línea sin saltar?"
    "¿Qué comando se usa para filtrar texto por patrones línea a línea?"
    "¿Qué comando se usa para extraer columnas específicas de un texto estructurado?"
    "¿Qué comando otorga permisos de ejecución a un script de Bash?"
    "¿Qué editor de texto por terminal viene por defecto en la mayoría de distros?"
    "¿Qué comando te permite ver la fecha y la hora actual del sistema?"
)

# 2. BIENVENIDA
clear
echo -e "${VERDE}=========================================================${SIN_COLOR}"
echo -e "      ${AMARILLO}🏆 BIENVENIDO AL QUIZ INTERACTIVO DE LINUX${SIN_COLOR}"
echo -e "${VERDE}=========================================================${SIN_COLOR}"
echo -e "Responde las 10 preguntas para evaluar tu rango en Bash.\n"

# 3. BUCLE PRINCIPAL DE EVALUACIÓN
incorrectas=0

for ((i=0; i<total_preguntas; i++)); do
    num_pregunta=$((i + 1))
    
    # Marcador en tiempo real
    echo -e "${AMARILLO}[📊 Marcador -> Correctas: $puntuacion | Incorrectas: $incorrectas]${SIN_COLOR}"
    echo -e "${AZUL}Pregunta $num_pregunta/$total_preguntas:${SIN_COLOR} ${preguntas[$i]}"
    read -p "Tu respuesta: " respuesta_usuario
    
    # Convertir la respuesta a minúsculas
    respuesta_usuario="${respuesta_usuario,,}"
    
    # Validación flexible usando patrones por pregunta
    case $num_pregunta in
        1)  case "$respuesta_usuario" in "df"|"df -h"|"df -lh") valido=1 ;; *) valido=0 ;; esac ;;
        2)  case "$respuesta_usuario" in "free"|"free -h"|"free -m") valido=1 ;; *) valido=0 ;; esac ;;
        3)  case "$respuesta_usuario" in "hostname -i"|"hostname -I"|"ip a"|"ip addr"|"ip address") valido=1 ;; *) valido=0 ;; esac ;;
        4)  case "$respuesta_usuario" in "last"|"who") valido=1 ;; *) valido=0 ;; esac ;;
        5)  case "$respuesta_usuario" in "\\r"|"r"|"escape r") valido=1 ;; *) valido=0 ;; esac ;;
        6)  case "$respuesta_usuario" in "grep"|"egrep") valido=1 ;; *) valido=0 ;; esac ;;
        7)  case "$respuesta_usuario" in "awk"|"cut") valido=1 ;; *) valido=0 ;; esac ;;
        8)  case "$respuesta_usuario" in "chmod +x"|"chmod 755") valido=1 ;; *) valido=0 ;; esac ;;
        9)  case "$respuesta_usuario" in "nano"|"vi"|"vim") valido=1 ;; *) valido=0 ;; esac ;;
        10) case "$respuesta_usuario" in "date"|"timedatectl") valido=1 ;; *) valido=0 ;; esac ;;
    esac

    # Procesar resultado de la validación y actualizar contadores
    if [ $valido -eq 1 ]; then
        echo -e "${VERDE}🟢 ¡Correcto! Punto añadido.${SIN_COLOR}"
        puntuacion=$((puntuacion + 1))
    else
        echo -e "${ROJO}🔴 Incorrecto.${SIN_COLOR}"
        incorrectas=$((incorrectas + 1))
    fi
    echo -e "---------------------------------------------------------"
done
# 4. RESULTADO Y CALIFICACIÓN DE RANGOS
clear
echo -e "${VERDE}====================================================${SIN_COLOR}"
echo -e "               📊 RESULTADO FINAL${SIN_COLOR}"
echo -e "${VERDE}====================================================${SIN_COLOR}"
echo -e "Tu puntuación final es: ${AMARILLO}$puntuacion/$total_preguntas${SIN_COLOR}\n"

case $puntuacion in
    9|10)
        echo -e "RANGO FINAL: 🥇 ${AMARILLO}MAESTRO JEDI${SIN_COLOR}. ¡Eres el dueño absoluto de la terminal!"
        ;;
    6|7|8)
        echo -e "RANGO FINAL: 🥈 ${CIAN}JEDI${SIN_COLOR}. Buen nivel técnico, dominas el entorno."
        ;;
    *)
        echo -e "RANGO FINAL: 🥉 ${AZUL}PADAWAN${SIN_COLOR}. Tienes las bases, sigue practicando para mejorar."
        ;;
esac
echo -e "${VERDE}====================================================${SIN_COLOR}"
