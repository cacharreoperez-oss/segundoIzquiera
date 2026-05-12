#!/bin/bash
ejercicioFinal(){


# Pedimos los datos al usuario y los almacenamos

read -p "Como te llamas: " nombre
read -p "En sistemas, cual es tu lenguaje o tema favorito: " tema

# Pasamos la presentación por cosola
figlet -f slant -c "$nombre" | lolcat
figlet "Profesional en :" | lolcat
figlet -f slant -c "$tema" | lolcat
sleep 2
figlet -f slant -c "Bienvenido a ARTEMIS" | lolcat

figlet ">-----------<" | lolcat
}

progreso_bar(){
 local duracion=$1
    local mensaje=$2
    echo -n "$mensaje: ["
    for i in {1..20}; do
        sleep $(echo "$duracion / 20" | bc -l)
        echo -ne "#"
    done
    echo -e "] ¡Listo!"
}

ejercicioFinal
#!/bin/bash

# Función para barra de progreso estética (animación)
sleep 2s
progress_bar() {
    local mensaje=$1
    echo -n "$mensaje: ["
    for i in {1..20}; do
        sleep 0.02
        echo -ne "#"
    done
    echo -e "] ¡Listo!"
}

# Función para medidor real (porcentaje)
gauge() {
    local porcentaje=$1
    local total_bloques=10
    local llenos=$((porcentaje / 10))
    local vacios=$((total_bloques - llenos))
    
    echo -n "["
    printf "%${llenos}s" | tr ' ' '#'
    printf "%${vacios}s" | tr ' ' '-'
    echo -n "] $porcentaje%"
}


echo "=== DIAGNÓSTICO REAL DE SISTEMA ==="
echo "-----------------------------------"

# 1. Hostname e IP
progress_bar "Escaneando red"
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')
echo -e "ID: $HOSTNAME | IP: $IP\n"

# 2. Espacio en disco (Cálculo real)
progress_bar "Verificando almacenamiento"
# Obtenemos el % de uso quitando el símbolo %
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
echo -n "Disco: "
gauge $DISK_USAGE
echo -e " (en uso)\n"

# 3. RAM (Cálculo real)
progress_bar "Analizando memoria"
# Calculamos el % de uso de RAM
RAM_USAGE=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
echo -n "RAM:   "
gauge $RAM_USAGE
echo -e " (en uso)\n"

# 4. Último login (Solución al error del argumento)
progress_bar "Revisando registros"
# Cambiamos 'last -1n' por 'last -n 1' que es más estándar
LAST=$(last -n 1 | head -n 1 | awk '{print $1, $4, $5, $6}')
echo -e "Último acceso: $LAST\n"
echo "-----------------------------------"
