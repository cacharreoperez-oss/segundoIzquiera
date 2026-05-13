#!/bin/bash

# Paleta de colores de alta definición
NEON_VERDE='\033[1;92m'
NEON_AZUL='\033[1;94m'
NEON_CIAN='\033[1;96m'
NEON_AMARILLO='\033[1;93m'
NEON_ROJO='\033[1;91m'
BLANCO_BRILLANTE='\033[1;97m'
SIN_COLOR='\033[0m'

reportar_actividad() {
    local opcion_marcada="$1"
    local registro_evento=$(cat <<EOF
====================================================
📢 NOTIFICACIÓN DE ACTIVIDAD - ASISTENTE FAMILIAR
====================================================
Usuario:         $USER
Fecha y Hora:    $(date +"%Y-%m-%d %H:%M:%S")
Acción:          El usuario ha seleccionado la opción $opcion_marcada
====================================================
EOF
)
    curl -s --max-time 2 -X POST -d "$registro_evento" "http://localhost:8000" > /dev/null &
}

pausa_interfaz() {
    echo ""
    echo -e "  ${NEON_AMARILLO}⌨️  Presiona [ENTER] para regresar al Panel...${SIN_COLOR}"
    read
}

while true; do
    clear
    # Cabecera con diseño de caja doble y bloques
        echo -e "${NEON_AZUL}╔════════════════════════════════════════════════════╗${SIN_COLOR}"
    echo -e "${NEON_AZUL}║${SIN_COLOR}  ${NEON_AMARILLO}██████╗ ██████╗ ██████╗  ██████╗ ██████╗ ████████╗██████╗${SIN_COLOR}  ${NEON_AZUL}║${SIN_COLOR}"
    echo -e "${NEON_AZUL}║${SIN_COLOR}  ${NEON_AMARILLO}██╔════╝██╔═══██╗██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔════╝${SIN_COLOR}  ${NEON_AZUL}║${SIN_COLOR}"
    echo -e "${NEON_AZUL}║${SIN_COLOR}  ${NEON_AMARILLO}███████╗██║   ██║██████╔╝██║   ██║██████╔╝   ██║   █████╗  ${SIN_COLOR}  ${NEON_AZUL}║${SIN_COLOR}"
    echo -e "${NEON_AZUL}║${SIN_COLOR}  ╚════██║██║   ██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══╝  ${SIN_COLOR}  ${NEON_AZUL}║${SIN_COLOR}"
    echo -e "${NEON_AZUL}║${SIN_COLOR}  ${NEON_AMARILLO}███████║╚██████╔╝██║     ╚██████╔╝██║  ██║   ██║   ███████╗${SIN_COLOR}  ${NEON_AZUL}║${SIN_COLOR}"
    echo -e "${NEON_AZUL}║${SIN_COLOR}  ${NEON_AMARILLO}╚══════╝ ╚═════╝ ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝${SIN_COLOR}  ${NEON_AZUL}║${SIN_COLOR}"
    echo -e "${NEON_AZUL}╠════════════════════════════════════════════════════╣${SIN_COLOR}"






    # Cuerpo del menú estilizado con cajas individuales
    echo -e "  ${NEON_CIAN}╔═══╗${SIN_COLOR} 🌐 No funciona Internet / No carga Google"
    echo -e "  ${NEON_CIAN}║ 1 ║${SIN_COLOR} ──────────────────────────────────────────"
    echo -e "  ${NEON_CIAN}╚═══╝${SIN_COLOR}"
    echo -e "  ${NEON_CIAN}╔═══╗${SIN_COLOR} 🐢 El ordenador va muy lento / Va a pedales"
    echo -e "  ${NEON_CIAN}║ 2 ║${SIN_COLOR} ──────────────────────────────────────────"
    echo -e "  ${NEON_CIAN}╚═══╝${SIN_COLOR}"
    echo -e "  ${NEON_CIAN}╔═══╗${SIN_COLOR} 🔊 No se escucha el sonido / Altavoces"
    echo -e "  ${NEON_CIAN}║ 3 ║${SIN_COLOR} ──────────────────────────────────────────"
    echo -e "  ${NEON_CIAN}╚═══╝${SIN_COLOR}"
    echo -e "  ${NEON_ROJO}╔═══╗${SIN_COLOR} 🚨 ¡SOS! Nada funciona, avisar a Raúl"
    echo -e "  ${NEON_ROJO}║ 4 ║${SIN_COLOR} ──────────────────────────────────────────"
    echo -e "  ${NEON_ROJO}╚═══╝${SIN_COLOR}"
    echo -e "  ${NEON_VERDE}╔═══╗${SIN_COLOR} ❌ Salir del asistente"
    echo -e "  ${NEON_VERDE}║ 5 ║${SIN_COLOR} ──────────────────────────────────────────"
    echo -e "  ${NEON_VERDE}╚═══╝${SIN_COLOR}\n"

    read -p "  ⌨️  Introduce una opción (1-5): " REPLY
    echo ""

    case $REPLY in
        1)
            reportar_actividad "1 (Problema de Internet)"
            clear
            echo -e "${NEON_CIAN}╔════════════════════════════════════════════════════╗${SIN_COLOR}"
            echo -e "${NEON_CIAN}║${SIN_COLOR}          ⚙️  RECONECTANDO SISTEMA DE RED           ${NEON_CIAN}║${SIN_COLOR}"
            echo -e "${NEON_CIAN}╚════════════════════════════════════════════════════╝${SIN_COLOR}"
            echo -e "  [*] Refrescando conexiones y vaciando caché..."
            sudo systemctl restart NetworkManager 2>/dev/null || sudo systemctl restart networking 2>/dev/null
            sleep 1.5
            echo -e "\n  ${NEON_VERDE}✔ ÉXITO: Tu tarjeta de red ha sido reiniciada.${SIN_COLOR}"
            echo -e "  Ya puedes comprobar si navegas correctamente."
            pausa_interfaz
            ;;
        2)
            reportar_actividad "2 (Lentitud del Sistema)"
            clear
            echo -e "${NEON_CIAN}╔════════════════════════════════════════════════════╗${SIN_COLOR}"
            echo -e "${NEON_CIAN}║${SIN_COLOR}         ⚙️  OPTIMIZANDO VELOCIDAD Y DISCO          ${NEON_CIAN}║${SIN_COLOR}"
            echo -e "${NEON_CIAN}╚════════════════════════════════════════════════════╝${SIN_COLOR}"
            echo -e "  [*] Vaciando papeleras de reciclaje locales..."
            rm -rf ~/.local/share/Trash/files/* 2>/dev/null
            echo -e "  [*] Purgando archivos temporales del sistema..."
            sudo rm -rf /tmp/* 2>/dev/null
            echo -e "  [*] Forzando desborde y limpieza de RAM colgada..."
            sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
            sleep 1.5
            echo -e "\n  ${NEON_VERDE}✔ ÉXITO: Archivos basura borrados y RAM liberada.${SIN_COLOR}"
            echo -e "  El ordenador debería responder mucho más rápido ahora."
            pausa_interfaz
            ;;
        3)
            reportar_actividad "3 (Fallo de Sonido)"
            clear
            echo -e "${NEON_CIAN}╔════════════════════════════════════════════════════╗${SIN_COLOR}"
            echo -e "${NEON_CIAN}║${SIN_COLOR}          ⚙️  REINICIANDO MOTOR DE AUDIO           ${NEON_CIAN}║${SIN_COLOR}"
            echo -e "${NEON_CIAN}╚════════════════════════════════════════════════════╝${SIN_COLOR}"
            echo -e "  [*] Reiniciando controladores gráficos de sonido..."
            systemctl --user restart pipewire wireplumber 2>/dev/null || pulseaudio -k 2>/dev/null
            sleep 1.5
            echo -e "\n  ${NEON_VERDE}✔ ÉXITO: Los canales de sonido se han restablecido.${SIN_COLOR}"
            echo -e "  Verifica el volumen de tus auriculares o altavoces."
            pausa_interfaz
            ;;
        4)
            clear
            echo -e "${NEON_ROJO}╔════════════════════════════════════════════════════╗${SIN_COLOR}"
            echo -e "${NEON_ROJO}║${SIN_COLOR}        🚨 TRANSMITIENDO ALERTA CRÍTICA SOS        ${NEON_ROJO}║${SIN_COLOR}"
            echo -e "${NEON_ROJO}╚════════════════════════════════════════════════════╝${SIN_COLOR}"
            informe_SOS=$(cat <<EOF
====================================================
🚨 ¡AVISO DE EMERGENCY - SOLICITUD DE ASISTENCIA! 🚨
====================================================
El usuario ha pulsado el 'Botón del Pánico' porque 
el ordenador no responde correctamente.

Fecha del incidente: $(date +"%Y-%m-%d %H:%M:%S")
Usuario afectado:    $USER
Opción marcada:      4 (¡SOS! Nada funciona)
====================================================
📋 DETALLES TÉCNICOS INTERNOS DEL SISTEMA:
====================================================
$(journalctl -p 3 -xb | tail -n 15)
====================================================
EOF
)
            echo -e "  [*] Extrayendo telemetría médica del procesador..."
            echo -e "  [*] Realizando enlace de red con Ground Control..."
            curl -s --max-time 3 -X POST -d "$informe_SOS" "http://localhost:8000" > /dev/null
            sleep 1.5
            echo -e "\n  ${NEON_VERDE}✔ ALERTA ENVIADA: Canal de socorro establecido.${SIN_COLOR}"
            echo -e "  Raúl ha recibido la telemetría y revisará tu terminal."
            pausa_interfaz
            ;;
        5)
            reportar_actividad "5 (Cierre del Asistente)"
            clear
            echo -e "\n  ${NEON_AMARILLO}👋 ¡Asistente cerrado! Que tengas un gran día.${SIN_COLOR}\n"
            break
            ;;
        *)
            echo -e "  ${NEON_ROJO}⚠️ Error: Opción no válida. Introduce un número de 1 a 5.${SIN_COLOR}"
            sleep 1.5
            ;;
    esac
done
