#!/bin/bash
loc=/home/frans0416/Documents/sisopE/soal3
> "$loc"/Foto.log
for ((i=1; i<=23; i=i+1))
    do
    if [ $i -lt 10 ]
        then wget -a "$loc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$loc"/Koleksi_0"$i".jpeg
    else wget -a "$loc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$loc"/Koleksi_"$i".jpeg
    fi
done
rdfind -deleteduplicates true "$loc"
i=1
cd "$loc"
for f in *.jpeg
    do
    if [ $i -lt 10 ]
        then 
            mv -- "$f" "Koleksi_0$i.jpeg"
    else 
        mv -- "$f" "Koleksi_$i.jpeg"
    fi
let i=$i+1
done
