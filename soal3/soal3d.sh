#!/bin/bash
SUB="Kelinci"
SUB2="Kucing"
password=$(date +%m%d%Y)
for f in *; do
    if [ -d "$f" ]; then
        if [[ "$f" == *"$SUB"* ]] 
        then
            zip -r -P "$password" Koleksi.zip "$f"
        elif [[ "$f" == *"$SUB2"* ]] 
        then   
            zip -r -P "$password" Koleksi.zip "$f"
        fi
    fi
done