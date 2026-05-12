#!/bin/bash
ejercicioFinal(){


# Pedimos los datos al usuario y los almacenamos

read -p "Como te llamas: " nombre
read -p "En sistemas, cual es tu lenguaje o tema favorito: " tema

# Pasamos la presentación por cosola
figlet -f slant -c "$nombre" | lolcat
figlet "Profesional en:" | lolcat
figlet -f slant -c "$tema" | lolcat
figlet -f slant -c "Bienvenido a ARTEMIS" | lolcat

figlet ">---------<" | lolcat
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
