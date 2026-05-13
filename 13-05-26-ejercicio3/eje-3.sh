#!/bin/bash

# Configuración del archivo de preguntas
archivo="eje-3-preguntas.txt"

if [[ ! -f "$archivo" ]]; then
    echo "Crea el archivo eje-3-preguntas.txt primero."
    exit 1
fi

# Colores para la interfaz visual
VERDE="\e[1;32m"
ROJO="\e[1;31m"
AZUL="\e[1;34m"
AMARILLO="\e[1;33m"
CYAN="\e[1;36m"
RESET="\e[0m"

# Variables de control
aciertos=0
total_maximo=10
contador=0

# 1. Leer todas las líneas del archivo y guardarlas en un array
lineas=()
while IFS= read -r linea || [[ -n "$linea" ]]; do
    [[ -z "$linea" ]] && continue
    lineas+=("$linea")
done < "$archivo"

# 2. Generar un orden de índices aleatorio
indices=($(seq 0 $((${#lineas[@]} - 1)) | shuf))

# 3. Recorrer el archivo de forma aleatoria
for idx in "${indices[@]}"; do
    # Detener el juego al llegar a 10 preguntas
    if [[ $contador -eq $total_maximo ]]; then
        break
    fi
    
    ((contador++))
    linea_aleatoria="${lineas[$idx]}"

    # Separar componentes por punto y coma (;)
    IFS=";" read -r pregunta opA opB opC correcta <<< "$linea_aleatoria"
    correcta=$(echo "$correcta" | tr -d '\r\n ' )

    # Interfaz visual de la pregunta actual
    echo -e "\n${AZUL}==================================================${RESET}"
    echo -e " ${CYAN}PREGUNTA $contador de $total_maximo${RESET}"
    echo -e "${AZUL}==================================================${RESET}"
    echo -e "${AMARILLO}$pregunta${RESET}\n"
    echo "  a) $opA"
    echo "  b) $opB"
    echo "  c) $opC" 
    echo -e "${AZUL}--------------------------------------------------${RESET}"

    read -p " Tu respuesta (a/b/c): " usuario < /dev/tty

    usuario_minuscula=$(echo "${usuario,,}" | tr -d ' ')
    correcta_minuscula="${correcta,,}"

    if [[ "$usuario_minuscula" == "$correcta_minuscula" ]]; then
        echo -e "\n ${VERDE}¡Correcto! ✔${RESET}"
        ((aciertos++))
    else
        echo -e "\n ${ROJO}Incorrecto. La respuesta era la '$correcta'. ✘${RESET}"
    fi
done

# =================================================================
# CÁLCULO DE CALIFICACIÓN Y DISEÑO DE PANEL FINAL
# =================================================================
echo -e "\n\n${AZUL}==================================================${RESET}"
echo -e "               ${CYAN}RESULTADOS FINALES${RESET}               "
echo -e "${AZUL}==================================================${RESET}"
echo -e " Respuestas acertadas: ${VERDE}$aciertos${RESET} de ${AMARILLO}$total_maximo${RESET}"

# Definición de niveles según los aciertos
if [[ $aciertos -le 4 ]]; then
    nivel="${ROJO}PRINCIPIANTE 🥉${RESET}"
    mensaje="¡Sigue practicando para mejorar tus conocimientos!"
elif [[ $aciertos -le 7 ]]; then
    nivel="${AMARILLO}INTERMEDIO 🥈${RESET}"
    mensaje="¡Buen trabajo! Tienes bases sólidas."
else
    nivel="${VERDE}EXPERTO 🥇${RESET}"
    mensaje="¡Excelente! Dominas el tema a la perfección."
fi

echo -e " Tu nivel actual es:   $nivel"
echo -e "${AZUL}--------------------------------------------------${RESET}"
echo -e " $mensaje"
echo -e "${AZUL}==================================================${RESET}\n"



