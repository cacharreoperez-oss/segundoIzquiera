#!/bin/bash

# 1. Solicitar datos de forma interactiva
read -p "Por favor, introduce tu nombre: " nombre
read -p "¿Cuál es tu lenguaje de programación favorito?: " lenguaje

# 2. Control de excepción: Validar si los campos están vacíos
if [[ -z "$nombre" || -z "$lenguaje" ]]; then
    echo "❌ Error: No puedes dejar los campos vacíos."
    exit 1
fi

# 3. Mostrar el mensaje de bienvenida con ASCII art usando cat << 'EOF'
echo ""
cat << EOF
=====================================================
       ¡BIENVENIDO AL ENTORNO DE DESARROLLO!
=====================================================

  /\_/\   
 ( o.o )   Hola, $nombre!
  > ^ <    Veo que tu lenguaje favorito es $lenguaje.

=====================================================
  ¡Buena suerte con tu camino de automatización!
=====================================================
EOF
