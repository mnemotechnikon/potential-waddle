#!/bin/bash

# echo "Podaj nazwe pliku:"
# read PLIK
# PLIK="adreses.txt"
PLIK=$1
SKRYPT="niechciane.sh"

# Utworzenie tablicy
declare -a ADRESY
while IFS= read -r line; do
    ADRESY+=("$line")
done < "$PLIK"
[[ -n $line ]] && ADRESY+=("$line")

# Czyszczenie pliku wyjsciowego
> $SKRYPT

# WGenerowanie skryptu
for i in "${ADRESY[@]}"; do
    # Dodanie hosta
    echo "config object host new name=\"incydent_$i\" ip=\"$i\" resolve=static mac=\"\" comment=\"\" update=1" >> $SKRYPT
    # Dodanie do grupy
    echo "config object group addto group="niechciane_adresy" node=\"incydent_$i\" update=1" >> $SKRYPT
done

# Aktualizacja obiektow
echo "config object activate" >> $SKRYPT