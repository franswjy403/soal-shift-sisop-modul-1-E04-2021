#!/bin/bash
> /home/frans0416/Documents/sisopE/soal3/Foto.log
first_ind=0;
for ((i=1; i<=23; i=i+1))
    do
    if [ $i -lt 10 ]
        then wget -a /home/frans0416/Documents/sisopE/soal3/Foto.log "https://loremflickr.com/320/240/kitten" -O /home/frans0416/Documents/sisopE/soal3/Koleksi_0"$i".jpeg
    else wget -a /home/frans0416/Documents/sisopE/soal3/Foto.log "https://loremflickr.com/320/240/kitten" -O /home/frans0416/Documents/sisopE/soal3/Koleksi_"$i".jpeg
    fi
done
rdfind -deleteduplicates true /home/frans0416/Documents/sisopE/soal3

