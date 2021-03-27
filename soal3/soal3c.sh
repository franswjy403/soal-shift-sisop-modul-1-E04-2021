#!/bin/bash
root=/home/frans0416/Documents/sisopE/soal3
loc=$(date +%d-%m-%Y)
curr=$(date "+%d")
let curr=$curr%2
if [ $curr -eq 0 ]
then
        loc="Kucing_"$(date +%d-%m-%Y)
else 
        loc="Kelinci_"$(date +%d-%m-%Y)
fi

mkdir "$root"/"$loc"

for ((i=1; i<=23; i=i+1))
    do
    if [ $curr -eq 0 ]
    then
            if [ $i -lt 10 ]
                    then wget -a "$root"/"$loc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$root"/"$loc"/Koleksi_0"$i".jpeg
            else wget -a "$root"/"$loc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$root"/"$loc"/Koleksi_"$i".jpeg
            fi

    elif [ $curr -eq 1 ]
    then
            if [ $i -lt 10 ]
                    then wget -a "$root"/"$loc"/Foto.log "https://loremflickr.com/320/240/bunny" -O "$root"/"$loc"/Koleksi_0"$i".jpeg
            else wget -a "$root"/"$loc"/Foto.log "https://loremflickr.com/320/240/bunny" -O "$root"/"$loc"/Koleksi_"$i".jpeg      
            fi
    fi
done

rdfind -deleteduplicates true "$root"/"$loc"
cd "$root"/"$loc"
i=1
for f in Koleksi_*.jpeg
    do
    if [ $i -lt 10 ]
        then 
            mv -- "$f" "Koleksi_0$i.jpeg"
    else 
        mv -- "$f" "Koleksi_$i.jpeg"
    fi
let i=$i+1
done