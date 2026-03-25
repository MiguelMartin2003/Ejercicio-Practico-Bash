#!/bin/bash

# variables que van a servur para identificar mas adelante
BASE_DIR="$HOME/EPNro1"
NOMBRE_ARCHIVO="${FILENAME:-alumnos}"
ARCHIVO="$BASE_DIR/salida/${NOMBRE_ARCHIVO}.txt"

opcion_1() {
   # creamos el directorio para ejecutar el entorno
    echo "Creando entorno...."
    mkdir -p "$BASE_DIR/entrada" "$BASE_DIR/salida" "$BASE_DIR/procesado"
    echo "Entorno EPNro1 creado con exito."
}

opcion_2() {
    # debemos verificar que esxista el script consolidar antes de querer ejecutarlo
    if [ ! -f "$BASE_DIR/consolidar.sh" ]; then
        echo "Error: No se encuentra consolidar.sh en $BASE_DIR"
        return
    fi
}
# si alguno sabe como continuar esta parte completela. falta terminar la opcion2. si la hcieron de otra forma y les funciona ponganla

opcion_3() {
    # si existe el archivo en la carpeta slida muestra el listado de alumnos por orden de padron
    if [ -f "$ARCHIVO" ]; then
        echo "--- Lista de alumnos (Ordenado por Padron) ---"
        # -t',' indica que el separador es la coma, -k1,1n ordena por la primera columna numéricamente
        sort -t',' -k1,1n "$ARCHIVO"
    else
        echo "El archivo de salida ${NOMBRE_ARCHIVO}.txt no existe."
    fi
}

opcion_4() {
    # si existe el archivo muestra las 10 notas mas altas
    if [ -f "$ARCHIVO" ]; then
        echo "--- Las 10 notas mass altas ---"
        # -k4,4nr ordena por la cuarta columna de forma numérica reversa (mayor a menor)
        sort -t',' -k4,4nr "$ARCHIVO" | head -n 10
    else
        echo "El archivo de salida ${NOMBRE_ARCHIVO}.txt no existe."
    fi
}

opcion_5() {
    # pide los dtos del padron y muestra  datos en pantalla
    if [ -f "$ARCHIVO" ]; then
        read -p "Ingrese el numero de padron: " PADRON
        echo "Resultado:"
        # Busca el padron exacto
        grep "^$PADRON," "$ARCHIVO" || echo "No se encontró ningún padron: $PADRON"
    else
        echo "El archivo de salida no existe."
    fi
}

# menu
while true; do
    echo -e "\n----------------------------------------"
    echo "       MENU DE GESTION DE ALUMNOS"
    echo "       Archivo actual: ${NOMBRE_ARCHIVO}.txt"
    echo "----------------------------------------"
    echo "1) Crear entorno (EPNro1)"
    echo "2) Correr proceso"
    echo "3) Listar alumnos por padrOn"
    echo "4) Mostrar 10 notas mas altas"
    echo "5) Buscar alumno por padron"
    echo "6) Salir"
    echo "----------------------------------------"
    read -p "Seleccione una opción [1-6]: " OPC
    
    case $OPC in
        1) opcion_1 ;;
        2) opcion_2 ;;
        3) opcion_3 ;;
        4) opcion_4 ;;
        5) opcion_5 ;;
        6) echo "Cerrando sistema..."; exit 0 ;;
        *) echo "Opción no valida, reintentar." ;;
    esac
done
