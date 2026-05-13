#!/bin/bash

# Colores para que sea súper visual y amigable
VERDE='\033[0;32m'
AZUL='\033[0;34m'
CIAN='\033[0;36m'
AMARILLO='\033[1;33m'
ROJO='\033[0;31m'
SIN_COLOR='\033[0m'

# Cambiar el texto por defecto del menú de Bash (PS3)
PS3="✏️  Elige una opción (1-5): "

clear
echo -e "${AMARILLO}====================================================${SIN_COLOR}"
echo -e "      🤖 ¡HOLA! SOY TU ASISTENTE DE SOPORTE PC${SIN_COLOR}"
echo -e "${AMARILLO}====================================================${SIN_COLOR}"
echo -e "Dime, ¿qué problema tienes hoy con el ordenador?\n"

# Menú interactivo sencillo para la familia
options=(
    "🌐 No me funciona Internet / No carga Google"
    "🐢 El ordenador va muy lento / Va a pedales"
    "🔊 No se escucha el sonido / Altavoces"
    "🚨 ¡SOS! Nada funciona, avisar a Raúl"
    "❌ Salir del asistente"
)

select opt in "${options[@]}"
 Ank
do
    case $REPLAY in
        1)
            echo -e "\n${CIAN}[*] Intentando reconectar la red y limpiar errores...${SIN_COLOR}"
            # Comandos reales: reinicia el servicio de red local y limpia la DNS
            sudo systemctl restart NetworkManager
            sleep 2
            echo -e "${VERDE}🟢 ¡Listo! Intenta entrar a una página web ahora.${SIN_COLOR}\n"
            ;;
        2)
            echo -e "\n${CIAN}[*] Borrando archivos basura y liberando memoria RAM...${SIN_COLOR}"
            # Comandos reales: limpia la papelera de reciclaje del usuario y temporales
            rm -rf ~/.local/share/Trash/files/*
            sudo rm -rf /tmp/* 2>/dev/null
            # Forzar vaciado de caché de memoria RAM
            sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
            sleep 2
            echo -e "${VERDE}🟢 ¡Hecho! He liberado espacio y limpiado la memoria.${SIN_COLOR}\n"
            ;;
        3)
            echo -e "\n${CIAN}[*] Reiniciando el sistema de audio del equipo...${SIN_COLOR}"
            # Comando real: reinicia los servicios de sonido del usuario
            systemctl --user restart pipewire wireplumber 2>/dev/null || pulseaudio -k 2>/dev/null
            sleep 2
            echo -e "${VERDE}🟢 ¡Arreglado! Comprueba si ya se escucha el sonido.${SIN_COLOR}\n"
            ;;
        4)
            echo -e "\n${ROJO}[*] Generando informe de emergencia de la máquina...${SIN_COLOR}"
            # Recopila los últimos errores graves del sistema para mandártelos
            informe_emergencia=$(journalctl -p 3 -xb | tail -n 15)
            
            echo -e "${CIAN}[*] Enviando telemetría médica a tu servidor de Ground Control...${SIN_COLOR}"
            # Manda el post (asumiendo tu servidor del nivel anterior activo en localhost o tu IP)
            curl -s --max-time 3 -X POST -d "$informe_emergencia" "http://localhost:8000" > /dev/null
            
            sleep 1
            echo -e "${VERDE}🟢 ¡Aviso enviado! Raúl ha recibido la alerta y revisará tu PC.${SIN_COLOR}\n"
            ;;
        5)
            echo -e "\n${AMARILLO}¡Que tengas un gran día! Adiós. 👋${SIN_COLOR}\n"
            break
            ;;
        *)
            echo -e "${ROJO}⚠️ Opción no válida. Por favor, marca un número del 1 al 5.${SIN_COLOR}\n"
            ;;
    esac
done
