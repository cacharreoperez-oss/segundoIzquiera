
## EJERCICIO A

// === VALIDADOR DE FORTALEZA DE CONTRASEÑA ===
// Lee una contraseña y la clasifica según su longitud y tipo de caracteres

// --- PASO 1: Leer la contraseña del usuario ---
LEER contraseña                        // Entrada del usuario

// --- PASO 2: Contar cuántos caracteres tiene ---
numero = CONTAR contraseña             // Longitud total de la contraseña

// --- CRITERIO 0: Contraseña vacía ---
// OJO: en el original este caso aparece al final y mal ubicado → debe ir primero
SI numero = 0 ENTONCES
    IMPRIME "CONTRASEÑA VACÍA"
    FIN                                // No tiene sentido seguir si no hay contraseña
FIN SI

// --- CRITERIO 1: Contraseña DÉBIL → existe pero tiene menos de 8 caracteres ---
SI numero > 0 Y numero < 8 ENTONCES
    IMPRIME "CONTRASEÑA DÉBIL"

// --- CRITERIO 2: Contraseña MEDIA → 8 o más caracteres pero solo letras O solo números ---

SINO SI contiene_solo_letras(contraseña) O contiene_solo_numeros(contraseña) ENTONCES
    IMPRIME "CONTRASEÑA MEDIA"

// --- CRITERIO 3: Contraseña FUERTE → combina letras, números Y símbolos ---

SINO SI contiene_letras(contraseña) Y contiene_numeros(contraseña) Y contiene_simbolos(contraseña) ENTONCES
    IMPRIME "CONTRASEÑA FUERTE"

// --- CRITERIO 4: Cualquier otro caso (ej: solo símbolos, mezcla parcial sin símbolo) ---
SINO
    IMPRIME "CONTRASEÑA MEDIA"         // Combinación parcial sin llegar a fuerte
FIN SI

## EJERCICIO B

// === ESCÁNER DE IPS POR PING ===
// Recibe una lista de IPs, hace ping a cada una y clasifica cuáles están activas o caídas

// --- DATOS DE ENTRADA ---
// Lista de IPs a escanear (algunas intencionadamente malformadas para pruebas)
ips = [
    "192.168.56.10",      
    "192.168.56.20", 
    "192.168.56.101",     
    ".192.168.56.102"     
]

array_activo = []         // Almacenará las IPs que responden al ping
array_caido  = []         // Almacenará las IPs que no responden al ping

// --- CRITERIO 1: La lista de IPs no puede estar vacía ---
numero_ips = CONTAR ips   

SI numero_ips = 0 ENTONCES         
    IMPRIME "NO HAY RANGOS DE IPS"
    FIN                             // Termina el programa si no hay IPs que escanear
FIN SI

// --- PASO 1: Recorrer cada IP y clasificarla según respuesta al ping ---
PARA ip DESDE ips                 

    HACER PING A ip                 // Enviamos un ping a la dirección IP actual

    SI RESPONDE ENTONCES
        AÑADIR ip A array_activo    // La IP está activa y accesible
    SINO
        AÑADIR ip A array_caido     // OJO: en el original pone "ARRA VACIO" → "array_caido"
    FIN SI

FIN PARA                            

// --- PASO 2: Mostrar el resumen de resultados ---
IMPRIMIR "ACTIVOS: " + CONTAR ELEMENTOS DE array_activo
IMPRIMIR "CAÍDOS: "  + CONTAR ELEMENTOS DE array_caido

## EJERCICIO C

// === VALIDADOR DE EMAIL ===
// Recibe un email como array de caracteres y valida su estructura básica

texto = ARRAY                          // Array de caracteres que forman el email
limite = NUMERO DE ELEMENTOS DEL ARRAY // Longitud total del array
posicion = 0                           // Índice auxiliar (declarado pero no usado explícitamente)
punto = 0                              // Contador auxiliar (se reutiliza más adelante)

// --- CRITERIO 1: El primer carácter NO puede ser '@' ---
SI TEXTO[0] = "@" ENTONCES
    IMPRIME "EMAIL NO VÁLIDO"          // El email no puede empezar con '@'
    TERMINA PROGRAMA
FIN SI

// --- CRITERIO 2: El último carácter NO puede ser '@' ---
SI TEXTO[limite - 1] = "@" ENTONCES   // OJO: usar limite-1 si el índice empieza en 0
    IMPRIME "EMAIL NO VÁLIDO"          // El email no puede terminar con '@'
    TERMINA PROGRAMA
FIN SI

// --- CRITERIO 3: Debe existir exactamente un '@' que divida el email en dos partes ---
// Se usa 'cadena' como bandera: 1 = estamos en la parte izquierda, 2 = parte derecha
cadena = 1
CADENA1 = ""                           // Parte local (ej: "usuario")
CADENA2 = ""                           // Parte de dominio (ej: "correo.com")

PARA palabra DESDE texto               // Recorre cada carácter del array
    SI palabra = "@" ENTONCES
        cadena = 2                     // Al encontrar '@', cambiamos al tramo derecho
    FIN SI

    SI palabra <> "@" Y cadena = 1 ENTONCES
        CADENA1 = CADENA1 + palabra    // Acumulamos caracteres en la parte izquierda
    FIN SI

    SI palabra <> "@" Y cadena = 2 ENTONCES
        CADENA2 = CADENA2 + palabra    // Acumulamos caracteres en la parte derecha
    FIN SI
FIN PARA

// Si al terminar el bucle cadena sigue en 1, nunca se encontró '@'
SI cadena = 1 ENTONCES
    IMPRIME "EMAIL NO VÁLIDO"          // No contiene '@' → email inválido
    TERMINA PROGRAMA
FIN SI

// --- CRITERIO 4: La parte del dominio (CADENA2) debe tener al menos un '.' ---
contar_puntos = 0                      // Inicializamos el contador de puntos

PARA punto DESDE CADENA2              // Recorremos carácter a carácter el dominio
    SI punto = "." ENTONCES
        contar_puntos = contar_puntos + 1  // Contamos cada '.' encontrado
    FIN SI
FIN PARA

SI contar_puntos = 0 ENTONCES
    IMPRIME "EMAIL NO VÁLIDO"          // El dominio no tiene ningún punto (ej: falta ".com")
    TERMINA PROGRAMA
FIN SI

// --- CRITERIO 5: El email no puede contener espacios en blanco ---
PARA espacio DESDE texto               // Recorremos de nuevo todo el email
    SI espacio = " " ENTONCES
        IMPRIME "EMAIL NO VÁLIDO"      // Cualquier espacio hace el email inválido
        TERMINA PROGRAMA
    FIN SI
FIN PARA

// --- Si pasa todos los criterios, el email es válido ---
IMPRIME "EMAIL CORRECTO"
    


## EJERCICIO D

// === CONTADOR DE PALABRAS DISTINTAS ===
// Recibe un texto y devuelve cuántas palabras únicas (distintas) contiene

// --- PASO 1: Declarar variables ---
variable texto                                  // Texto original de entrada
variable palabras_unicas = []                   // Array que almacenará las palabras sin repetir
contador_distintas = 0                          // Contador final de palabras distintas

// --- PASO 2: Convertir el texto en array de palabras ---
texto_convertido = CONVERTIR texto EN ARRAY     // "el gato y el perro y el gato"
                                                // → ["el","gato","y","el","perro","y","el","gato"]

// --- PASO 3: Contar elementos ---
numero_palabras = CONTAR ELEMENTOS DE texto_convertido

// --- CRITERIO 1: El texto no puede estar vacío ---
SI numero_palabras = 0 ENTONCES
    IMPRIME "TEXTO VACÍO"
    SALIR
FIN SI

// --- PASO 4: Recorrer palabras y guardar solo las distintas ---
PARA palabra DESDE texto_convertido             // Bucle externo: cada palabra del texto

    encontrada = FALSO                          // Asumimos que la palabra es nueva

    PARA palabra2 DESDE palabras                 _unicas         // Bucle interno: buscamos si ya fue registrada
        SI palabra2 = palabra ENTONCES
            encontrada = VERDADERO              // Ya existe, no la contamos de nuevo
        FIN SI
    FIN PARA

    SI encontrada = FALSO ENTONCES
        AÑADIR palabra A palabras_unicas        // Guardamos la palabra nueva
        contador_distintas = contador_distintas + 1   // Incrementamos el contador
    FIN SI

FIN PARA

// --- PASO 5: Mostrar resultado ---
IMPRIMIR "Número de palabras distintas: " + contador_distintas
IMPRIMIR "Palabras distintas: " + palabras_unicas         
   
            



