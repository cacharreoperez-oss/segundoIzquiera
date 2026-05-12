#!/bin/bash
# Shebang: le dice al sistema que use el intérprete de Bash para ejecutar este archivo

# Declaración de variables: las inicializamos como cadenas vacías
nombre=""    # Variable para guardar el nombre del usuario
lenguaje=""  # Variable para guardar el lenguaje de programación favorito

# Comando 'cat' con un bloque 'Here Document' (EOF):
# Imprime todo el texto que hay hasta que encuentra la palabra 'EOF'
cat << 'EOF'
  ____  _                        _       _       _
 | __ )(_) ___ _ ____   _____ _ __ (_) __| | ___| |
 |  _ \| |/ _ \ '_ \ \ / / _ \ '_ \| |/ _` |/ _ \ |
 | |_) | |  __/ | | \ V /  __/ | | | | (_| |  __/ |
 |____/|_|\___|_| |_|\_/ \___|_| |_|_|\__,_|\___|_|
EOF

# Comando 'echo': se usa para imprimir texto o líneas vacías en la terminal
echo "" # Imprime una línea en blanco para dar espacio
echo "===========================================" # Línea decorativa superior
echo "   ¡Bienvenido al script de presentación!  " # Mensaje de bienvenida
echo "===========================================" # Línea decorativa inferior
echo "" # Otra línea en blanco

# Comando 'read': se usa para capturar lo que el usuario escribe por teclado
# El parámetro -p permite mostrar un mensaje (prompt) antes de la captura
read -p "Introduce tu nombre: " nombre              # Guarda la entrada en la variable 'nombre'
read -p "Introduce tu lenguaje favorito: " lenguaje  # Guarda la entrada en la variable 'lenguaje'

echo "" # Salto de línea decorativo
echo "-------------------------------------------" # Línea divisoria
# Mostramos los resultados usando las variables (se usa el símbolo $ para acceder a su valor)
echo "  ¡Hola, $nombre! 👋"                         # Saludo personalizado con el nombre
echo "  Tu lenguaje favorito es: $lenguaje 💻"       # Muestra el lenguaje introducido
echo "-------------------------------------------" # Línea divisoria
echo "" # Salto de línea final