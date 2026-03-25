#!/bin/bash

salida="$HOME/EPNro1/salida/${FILENAME}.txt"

while true;do 
     for archivo in "$HOME/EPNro1/entrada"/*.txt; do
         if [ -f "$archivo" ]; then
            cat "$archivo" >> "$salida"
            mv "$archivo" "$Home/EPNro1/procesado/"
         fi
     done
done
