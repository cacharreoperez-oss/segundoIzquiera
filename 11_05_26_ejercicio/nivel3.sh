#!/bin/bash
# Indicamos que este script debe ejecutarse usando el intérprete Bash

# ─── Colores (Definición de variables para formato visual) ──────────────────
VERDE='\033[0;32m'    # Código ANSI para color verde
CIAN='\033[0;36m'     # Código ANSI para color cian
AMARILLO='\033[1;33m' # Código ANSI para color amarillo brillante
ROJO='\033[0;31m'     # Código ANSI para color rojo
BLANCO='\033[1;37m'   # Código ANSI para color blanco brillante
RESET='\033[0m'       # Código ANSI para resetear el color al defecto

# ─── Variables de control ──────────────────────────────────────────────────
puntuacion=0          # Inicializamos el contador de respuestas correctas a 0
total_preguntas=10    # Definimos el número total de preguntas del test

# ─── Preguntas (Array indexado con los enunciados) ─────────────────────────
preguntas=(
    "¿Qué comando se usa para listar archivos y directorios?"
    "¿Cómo se llama el intérprete de comandos que estamos usando?"
    "¿Qué comando permite cambiar a otro directorio?"
    "¿Qué comando se usa para ver el contenido de un archivo por pantalla?"
    "¿Qué comando permite crear una carpeta o directorio?"
    "¿Cómo se llama el usuario con máximos privilegios en Linux?"
    "¿Qué comando se usa para ver la configuración de red o IP?"
    "¿Qué comando se usa para buscar patrones de texto dentro de archivos?"
    "¿Cuál es el comando clásico para ver los procesos en tiempo real?"
    "¿Qué comando se usa para eliminar o borrar un archivo?"
)

# ─── Respuestas (Array con sinónimos permitidos separados por '|') ──────────
respuestas=(
    "ls|list"             # Acepta 'ls' o 'list'
    "bash|sh|shell"      # Acepta varios nombres del intérprete
    "cd"                  # Comando único
    "cat|less|more"      # Diferentes formas de visualizar
    "mkdir"               # Comando para directorios
    "root|superusuario"   # Nombres del administrador
    "ip|ifconfig"         # Comandos de red (nuevo y antiguo)
    "grep"                # Herramienta de búsqueda
    "top|htop"            # Monitores de procesos
    "rm|remove"           # Comandos de borrado
)

# ─── Banner de Inicio (Limpieza de pantalla y dibujo ASCII) ────────────────
clear                 # Limpia la terminal antes de empezar
echo -e "${AMARILLO}" # Cambia el color a amarillo para el dibujo
cat << 'EOF'          # Muestra el texto ASCII de "Script Quiz"
   _____           _       _     _____  _   _ ___ ________
  / ____|         (_)     | |   |  __ \| | | |_ _/__   __/
 | (___   ___ _ __ _ _ __ | |_  | |  | | | | || |   | |   
  \___ \ / __| '__| | '_ \| __| | |  | | | | || |   | |   
  ____) | (__| |  | | |_) | |_  | |__| | |_| || |   | |   
 |_____/ \___|_|  |_| .__/ \__| |_____/ \___/|___|  |_|   
                    | |                                   
                    |_|                                   
EOF
echo -e "${RESET}"    # Resetea el color después del dibujo
echo -e "  ${BLANCO}======================================${RESET}" # Línea divisoria
echo -e "  ${CIAN}     EL DESAFÍO DEL ADMINISTRADOR     ${RESET}" # Título del juego
echo -e "  ${BLANCO}======================================${RESET}" # Línea divisoria
echo ""                # Salto de línea

# ─── Bucle Principal (Recorre todas las preguntas) ─────────────────────────
for i in "${!preguntas[@]}"; do    # Itera sobre los índices del array 'preguntas', poner el ${!preguntas[@]} hace que itere sobre los indices y no sobre los valores
    n=$((i + 1))                   # Calcula el número de pregunta actual (empezando en 1)
    echo -e "${CIAN}Pregunta $n/$total_preguntas:${RESET}" # Muestra el progreso pregunta y el total de preguntas
    echo -e "${BLANCO}${preguntas[$i]}${RESET}"          # Muestra el enunciado, ponemos $preguntas[$i] para que muestre el valor del array en la posición i
    read -p ">> " respuesta_usuario                      # Captura la entrada del usuario y lo guarda en la variable respuesta_usuario

    # Normalización de la respuesta
    # 'tr' convierte a minúsculas, 'xargs' elimina espacios en blanco extras
    respuesta_usuario=$(echo "$respuesta_usuario" | tr '[:upper:]' '[:lower:]' | xargs)
    
    # Procesamiento de sinónimos
    # IFS='|' le dice a 'read' que use la barra vertical como separador de palabras
    IFS='|' read -ra opciones <<< "${respuestas[$i]}"
    acierto=false                  # Bandera para saber si acertó, false significa que no acertó
    
    # Bucle interno para comparar la respuesta con cada sinónimo permitido, compara la respuesta del usuario con cada sinónimo permitido
    for opcion in "${opciones[@]}"; do
        if [[ "$respuesta_usuario" == "$opcion" ]]; then # Si coincide con algún sinónimo
            acierto=true                                 # Marcamos como acierto
            break                                        # Salimos del bucle de sinónimos
        fi
    done
    
    # Feedback inmediato al usuario
    if [ "$acierto" = true ]; then                       # Si acertó...
        echo -e "${VERDE}¡Correcto! +1 punto.${RESET}"     # Mensaje en verde
        puntuacion=$((puntuacion + 1))                   # Sumamos un punto
    else                                                 # Si falló...
        # 'cut' extrae la primera opción de la lista como respuesta oficial
        primera_opcion=$(echo "${respuestas[$i]}" | cut -d'|' -f1)
        echo -e "${ROJO}Incorrecto. La respuesta era: $primera_opcion${RESET}" # Mensaje en rojo
    fi
    echo "" # Salto de línea entre preguntas
done

# ─── Cálculo y Visualización de Resultados ─────────────────────────────────
echo -e "  ${BLANCO}======================================${RESET}" # Línea final
echo -e "  ${AMARILLO}          PUNTUACIÓN FINAL: $puntuacion/$total_preguntas${RESET}"
echo -e "  ${BLANCO}======================================${RESET}"

# Lógica de Rangos (Star Wars Style)
if [ $puntuacion -le 4 ]; then           # Si la nota es de 0 a 4
    rango="Padawan"                      # Rango inicial
    color=$ROJO                          # Color rojo (peligro)
    msg="Aún tienes mucho que aprender, joven aprendiz."
elif [ $puntuacion -le 8 ]; then         # Si la nota es de 5 a 8
    rango="Jedi"                         # Rango intermedio
    color=$CIAN                          # Color cian (fuerza)
    msg="La fuerza es intensa en ti, pero tu formación no ha concluido."
else                                     # Si la nota es 9 o 10
    rango="Maestro"                      # Rango máximo
    color=$VERDE                         # Color verde (éxito)
    msg="Has demostrado un dominio total. ¡El sistema es tuyo!"
fi

# Muestra el rango final y un mensaje personalizado
echo -e "  Tu rango es: ${color}${rango}${RESET}"
echo -e "  ${msg}"
echo ""
echo -e "  ${BLANCO}======================================${RESET}"
echo ""
