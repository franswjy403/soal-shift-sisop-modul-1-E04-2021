#!/bin/bash
SUB="Kelinci"
SUB2="Kucing"
password=$(date +%m%d%Y)
cd /home/frans0416/Documents/sisopE/soal3
for f in *; do
    if [ -d "$f" ]; then
        if [[ "$f" == "$SUB"_* ]] 
        then
            zip -r -P "$password" Koleksi.zip "$f"
            rm -rf "$f"
        elif [[ "$f" == "$SUB2"_* ]] 
        then   
            zip -r -P "$password" Koleksi.zip "$f"
            rm -rf "$f"
        fi
    fi
done