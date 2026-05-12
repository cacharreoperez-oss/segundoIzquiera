# Ejercicio 1
#!/bin/bash


read -p "cual es tu nombre " nombre
read -p"cual es tu lenguaje favorito " lenguaje

echo "hola $nombre que bien que tu lenguaje favorito sea $lenguaje, el mio tambien"
# Ejercicio 2
#/bin/bash
progress_bar() {
    local duration=$1
    local width=20
    echo -n "[ "
    for ((i=0; i<width; i++)); do
        sleep $(echo "$duration / $width" | bc -l)
        echo -n "■"
    done
    echo " ] Done!"
}
echo "la ip es  `hostname -I | awk '{print $2}'`"
echo "el hostname es `hostname`"
echo -n "Escaneando memoria RAM...     "
progress_bar 0.8
echo "la memoria es `df -h / --output=avail | tail -1 | tr -d ' '`"
echo -n "Calculando espacio en disco... "
progress_bar 1
echo "el disco es `free -h | awk '/Mem:/ {print $4}'`"
echo "la ultima sesion iniciada fue `last -n 1 | head -n 1 | awk '{print $4, $5, $6}'`"
## Ejercicio 3
#!/bin/bash

# Función para manejar las opciones y validar la respuesta
# Recibe el número de pregunta como parámetro ($1)
evaluar_respuesta() {
    local pregunta_id=$1
    local respuesta_usuario=""

    case $pregunta_id in
        0)
            echo "A. Cálculos | B. Coordinar flujo | C. Almacenar | D. Energía"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        1)
            echo "A. Lenta | B. Cara | C. Se borra sin luz | D. Solo lectura"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "C" ]] && return 0 || return 1
            ;;
        2)
            echo "A. DHCP | B. DNS | C. HTTP | D. FTP"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        3)
            echo "A. Hilo dentro de proceso | B. Son iguales | C. Más rápido | D. Sin memoria"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "A" ]] && return 0 || return 1
            ;;
        4)
            echo "A. POP3 | B. IMAP | C. SMTP | D. SNMP"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "C" ]] && return 0 || return 1
            ;;
        5)
            echo "A. Física | B. Enlace de datos | C. Red | D. Transporte"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        6)
            echo "A. Paginación | B. Fragmentación | C. Virtualización | D. Multitarea"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "C" ]] && return 0 || return 1
            ;;
        7)
            echo "A. Velocidad | B. Evitar corrupción | C. Compresión | D. Antivirus"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        8)
            echo "A. System Query | B. Structured Query | C. Simple Queue | D. Secure Log"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        9)
            echo "A. Cifrar | B. ID único | C. Acceso admin | D. Ordenar"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        10)
            echo "A. SO | B. BIOS/UEFI | C. RAM | D. Disco Duro"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        11)
            echo "A. Bloquear webs | B. Asignar IPs | C. Cifrar tráfico | D. Dar velocidad"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        12)
            echo "A. Robo de claves | B. Saturar servidor | C. Ransomware | D. Espionaje"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        13)
            echo "A. Cable de red | B. Matriz de discos | C. Protocolo web | D. Chipset"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        14)
            echo "A. Disco lleno | B. Error crítico | C. Virus | D. Ahorro energía"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        15)
            echo "A. Descargar | B. Ver conectividad | C. Borrar caché | D. Formatear"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        16)
            echo "A. RAM en nube | B. Disco como RAM | C. Memoria de video | D. RAM física"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        17)
            echo "A. FTP | B. HTTPS | C. RDP | D. Email"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        18)
            echo "A. Hardware | B. Software de gestión | C. Persona | D. Protocolo"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
        19)
            echo "A. USB/Audio | B. RAM/Video | C. Teclado | D. Ventilación"
            read -p "Tu respuesta: " respuesta_usuario
            [[ "${respuesta_usuario^^}" == "B" ]] && return 0 || return 1
            ;;
    esac
}

# Arreglo de preguntas
preguntas=(
    "¿Cuál es la función principal de la Unidad de Control de la CPU?"
    "¿Qué significa que la memoria RAM sea volátil?"
    "¿Qué componente traduce nombres de dominio a direcciones IP (DNS)?"
    "¿Cuál es la diferencia entre un proceso y un hilo (thread)?"
    "¿Qué protocolo se usa para enviar correos electrónicos (SMTP)?"
    "¿En qué capa del modelo OSI opera un Switch de Capa 2?"
    "¿Qué técnica permite ejecutar varios SO en un mismo hardware (Virtualización)?"
    "¿Cuál es el propósito del sistema de archivos Journaling?"
    "¿Qué significa el acrónimo SQL?"
    "¿Cuál es la función de una Llave Primaria en una tabla?"
    "¿Qué componente de hardware realiza el POST al encender la PC?"
    "¿Cuál es el propósito del protocolo DHCP en una red?"
    "¿Qué es un ataque de Denegación de Servicio Distribuido (DDoS)?"
    "¿Qué tecnología RAID permite la redundancia de datos?"
    "En Linux, ¿qué es un Kernel Panic?"
    "¿Qué hace el comando 'ping' en la consola?"
    "¿Qué es la Memoria Virtual y qué usa para funcionar?"
    "¿Para qué sirve el puerto 443 en un servidor web?"
    "¿Qué es un Sistema de Gestión de Base de Datos (DBMS)?"
    "¿Qué gestionaba el Northbridge en las placas antiguas?"
)

nota=0

# Generar 10 números aleatorios únicos entre 0 y 19 usando shuf
indices=$(shuf -i 0-19 -n 10)

echo "=== EXAMEN DE SISTEMAS EN BASH ==="

contador=1
for i in $indices; do
    echo -e "\nPregunta $contador: ${preguntas[$i]}"
    
    if evaluar_respuesta $i; then
        echo "¡Correcto!"
        ((nota++))
    else
        echo "Incorrecto."
    fi
    ((contador++))
done

echo -e "\n==========================================="
echo "La cantidad de respuestas correctas es: $nota"
echo "==========================================="