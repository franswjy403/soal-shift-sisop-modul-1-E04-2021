#!/bin/bash
echo "Soal 2a:"
awk 'BEGIN { FS="\t"; max=0; row=0; costPrice=0; profitP=0 }
{
if ( NR!=1 ){
    profitP=($21/($18-$21))*100
    if (profitP>=max) { max=profitP; row=$1 }
    }
}
END { print "Transaksi terakhir dengan profit percentage terbesar yaitu", row, "dengan persentase", max,"%\n"}' Laporan-TokoShiSop.tsv > hasil.txt

echo "Soal 2b:"
awk 'BEGIN { FS="\t"; 
print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"
}
{
    y = substr($3, 7, 2)
    if ($10=="Albuquerque" && NR!=1 && y=="17"){
        a[$7]++
    }
}
END{
    for (b in a) print b
}
' Laporan-TokoShiSop.tsv >> hasil.txt

echo "Soal 2c:"
awk 'BEGIN { FS="\t" }
{
    if (NR!=1) a[$8]++
}
END{
    min=(2^52)+1;
    minSeg="";
    for (b in a) {
        if (a[b]<min) {
            minSeg=b
            min=a[b]
        }
    }
    print "\nTipe segmen customer yang penjualannya paling sedikit adalah",minSeg,"dengan",min,"transaksi\n"
}
' Laporan-TokoShiSop.tsv >> hasil.txt

echo "Soal 2d:"
awk 'BEGIN { FS="\t" }
{
    if (NR!=1) a[$13] += $21
}
END{
    min=(2^52)+1;
    minReg="";
    for (b in a) {
        if (a[b]<min) {
            minReg=b
            min=a[b]
        }
    }
    print "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah",minReg,"dengan total keuntungan",min,"\n"
}
' Laporan-TokoShiSop.tsv >> hasil.txt
