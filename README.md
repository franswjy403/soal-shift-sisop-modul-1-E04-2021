# Soal Shift Sisop 2021 Modul 1

### Anggota:
1. Frans Wijaya		(05111940000098)
2. Jagad Wijaya P.	(05111940000132)
3. Fidhia Ainun K.	(05111940000203)

### List soal:
1. Soal 1
2. Soal 2
3. Soal 3

## Soal 1
Pada soal ini Ryujin diminta membuat **laporan daftar peringkat pesan error terbanyak** dan **laporan penggunaan user** pada aplikasi _ticky_

### Soal 1a
(a) Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

#### Jawab:
```
allLogInfo=`grep -o "ticky.*" syslog.log | cut -f 2-`
```
Untuk mengumpulkan semua informasi log , digunakan command `grep` dengan kata kunci "ticky.*" pada file syslog.log. 
Dengan option `-o` maka yang diprint/dihasilkan hanyalah bagian yang sesuai dengan kata kunci. Hasilnya kurang lebih seperti berikut.
<pre>
ticky: INFO Created ticket [#4217] (mdouglas)
ticky: INFO Closed ticket [#1754] (noel)
ticky: ERROR The ticket was modified while updating (breee)
ticky: ERROR Permission denied while closing ticket (ac)
ticky: INFO Commented on ticket [#4709] (blossom)
ticky: INFO Commented on ticket [#6518] (rr.robinson)
ticky: ERROR Tried to add information to closed ticket (mcintosh)
....
</pre>
Hasil ini dimasukkan ke variabel bernama `$allLogInfo`

### Soal 1b
(b) Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

#### Jawab:
```
errorList=`echo "$allLogInfo" | grep -o "ERROR.*" | cut -d " " -f 2- | cut -d "(" -f 1 | sort -V | uniq -c | sort -nr`
```
Untuk mengumpulkan semua tipe error beserta jumlahnya, hasil output dari `echo $allLogInfo`  dijadikan input ke command berikutnya dengan operator `|` pipe. Selanjutnya, log error dicari dengan `grep` dengan kata kunci "ERROR.*", kemudian diambil deskripsi errornya saja menggunakan `cut` dengan delimiter dan option yang dibutuhkan. Setelah itu, daftar error dirapikan/diurutkan berdasarkan jenisnya menggunakan `sort -V`. Kemudian, tiap jenis error (baris-baris yang berulang) dihitung dengan command `uniq -c` dan diurutkan berdasarkan jenis error terbanyak dengan `sort -nr`
Hasilnya kurang lebih seperti berikut.
<pre>
15 Timeout while retrieving information 
13 Connection to DB failed 
12 Tried to add information to closed ticket 
10 Permission denied while closing ticket 
9 The ticket was modified while updating 
7 Ticket doesn&apos;t exist 
</pre>

### Soal 1c
(c) Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.

#### Jawab:
```
userList=`echo "$allLogInfo" | cut -d "(" -f2 | cut -d ")" -f 1 | sort | uniq`
```
Untuk mengumpulkan nama user, hasil dari `$allLogInfo` dijadikan input ke command `cut`. Setelah mendapat daftar user, hasilnya di urutkan dengan command `sort`, lalu hasil yang sudah urut secara ascending di tampilkan secara unique dengan command `uniq`. Hasilnya seperti berikut.
<pre>
ac
ahmed.miller
blossom
bpacheco
breee
britanni
enim.non
...,
</pre>

### Soal 1d
(d) Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh 
daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

#### Jawab:
```
echo "Error,Count" > error_message.csv
echo "$errorList" | while read cekerror
do
	namaerror=`echo $cekerror | cut -d' ' -f2-`
	jumlaherror=`echo $cekerror | cut -d' ' -f1`
	echo "$namaerror,$jumlaherror" 
done >> error_message.csv
```
Pertama header dikirim ke file error_message.csv dengan redirection `>`. Kemudian, tiap baris  di `$errorList` dijadikan input while loop dengan dimasukkan ke variabel `$cekerror`. Lalu, deskripsi error dan jumlah error dipisah dengan cut dan dimasukkan ke variabel `namaerror` dan `jumlah error`. Setelah itu, dua isi variabel tersebut ditambahkan ke file csv dengan redirection `>>`

### Soal 1e
(e) Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.

#### Jawab:
```
echo "Username,Info,Error" > user_statistic.csv
echo "$userList" | 
while read user
    do
        thisInfoSum=$(grep -E "INFO.*($user))" syslog.log | wc -l)
        thisErrorSum=$(grep -E "ERROR.*($user))" syslog.log | wc -l)
        echo "$user,$thisInfoSum,$thisErrorSum"
    done >> user_statistic.csv;
```
Pertama header dikirim ke file user_statistic.csv dengan redirection `>`. Kemudian, tiap baris  di `$userList` yang berisi nama-nama user dijadikan input while loop dengan dimasukkan ke variabel `$user`. Lalu, log info/error seorang user dicari dengan `grep` dan jumlah barisnya dihitung dengan command `wc -l`.Setelah itu, dua isi variabel tersebut ditambahkan ke file csv dengan redirection `>>`


## Soal 2
Secara keseluruhan, soal nomor 2 meminta beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.
1. (a) Mencari **Row ID** dan **profit percentage terbesar** (jika hasil profit percentage terbesar lebih dari 1, maka diambil Row ID yang paling besar). Profit percentage sendiri didapatkan dari (Profit / Cost Price) * 100. Sedangkan untuk Cost Price, didapatkan dari (sales - profit).
2. (b) Membuat **daftar nama customer pada transaksi tahun 2017 di Albuquerque**.
3. (c) Mencari **segmen customer** dan **jumlah transaksinya yang paling sedikit**
4. (d) Mencari **mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit** dan **total keuntungan wilayah tersebut**.

## Jawaban Soal 2a
Pertama, kami menggunakan command BEGIN dari awk untuk mendeklarasikan field separator (FS) dan beberapa variabel yang dibutuhkan untuk soal 2a, yaitu max (menyimpan profit percentage terbesar), row (menyimpan row id terbesar), profitP (untuk menyimpan nilai profit percentage tiap baris data).
```sh
awk 'BEGIN { FS="\t"; max=0; row=0; costPrice=0 profitP=0 }
```
Selanjutnya, kami deklarasikan sebuah action untuk menghitung profit percentage tiap baris dan kemudian dilakukan pengecekan apakah profit percentage sebuah baris melebihi profit percentage terbesar yang pernah tercatat.
```sh
{
'if ( NR!=1 ){
    profitP=($21/($18-$21))*100
    if (profitP>=max) { max=profitP; row=$1 }
    }
}'
```
Syntax `if ( NR!=1 )` berfungsi untuk mencegah awk membaca row pertama (yang mana row pertama hanya berisi nama-nama kolom). 

Kemudian pada `if (profitP>=max) { max=profitP; row=$1 }`, penambahan kondisional `>=` berfungsi untuk mengupdate profit percentage terbesar sekaligus row ID nya.

Langkah selanjutnya, kami deklarasikan command END untuk melakukan tepat satu kali mencetak profit percentage terbesar beserta row ID-nya. Setelah itu,hasil cetakan action ini di sebuah file baru benama hasil.text.
```sh
'
END { print "Transaksi terakhir dengan profit percentage terbesar yaitu", row, "dengan persentase", max,"%\n"}' Laporan-TokoShiSop.tsv > hasil.txt `
```
Hasilnya adalah sebagai berikut:
```
Transaksi terakhir dengan profit percentage terbesar yaitu 9952 dengan persentase 100 %
```
## Jawaban Soal 2b
Untuk mengawali awk, kami gunakan command BEGIN untuk mendeklarasikan field separator dan mencetak tulisan awalan sesuai permintaan.
```sh
awk 'BEGIN { FS="\t"; 
print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"
}
```
Selanjutnya, kami buat sebuah action yang fungsinya untuk mengecek apakah sebuah baris data, city nya adalah Albuquerque `$10=="Albuquerque"`, bukan row pertama, `NR!=1`, dan tahun ordernya 2017 (diambil hanya 17 nya) `y=="17"`.
```sh
'{
    y = substr($3, 7, 2)
    if ($10=="Albuquerque" && NR!=1 && y=="17"){
        a[$7]++
    }
}
```
Syntax `y = substr($3, 7, 2)` berfungsi untuk mengambil substring dari data pada kolom ketiga sebuah baris, dimulai dari karakter ke 7 dengan panjang 2 (untuk mengekstrak tahun).

Lalu syntax `a[$7]++` berfungsi untuk membuat array yang menampung nama-nama customer yang memenuhi syarat di atas serta melakukan increment.

Selanjutnya, kami deklarasikan END command untuk mencetak nama-nama yang tersimpan dalam array a dan kemudian meng-*append* hasil cetakannya ke dalam file hasil.txt.
```sh
'END{
    for (b in a) print b
}
' Laporan-TokoShiSop.tsv >> hasil.txt
```
Hasilnya adalah sebagai berikut:
```
Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
Benjamin Farhat
Michelle Lonsdale
Susan Vittorini
David Wiener
```
## Jawaban Soal 2c
Langkah pertama, kami deklrasikan command BEGIN untuk mendeklarasikan field separator.
```sh
awk 'BEGIN { FS="\t" }
```
Kemudian, untuk tiap baris datan, segmennya yang tercatat disimpan ke dalam array a dan dilakukan increment `a[$8]++`.

```sh
'{
    if (NR!=1) a[$8]++
}
```
Langkah selanjutnya, kami deklarasikan END command untuk melakukan tepat satu kali di akhir action, mencari segmen dengan jumlah paling sedikit di dalam array a. Kemudian hasilnya dicetak dan di-*append* ke hasi.txt.
```sh
'END{
    min=(2^52)+1;
    minSeg="";
    for (b in a) {
        if (a[b]<min) {
            minSeg=b
            min=a[b]
        }
    }
    print "\nTipe segmen customer yang penjualannya paling sedikit adalah",minSeg,"dengan",min "transaksi\n" }' Laporan-TokoShiSop.tsv >> hasil.txt
```
Syntax `a[b]<min` berfungsi untuk mengecek tiap segmen di dalam array, apakah jumlahnya lebih sedikit dari jumlah paling sedikit yang tercatat. Syntax `minSeg=b` dan `min=a[b]` berfungsi untuk mengupdate segmen yang jumlahnya paling sedikit.

Hasilnya adalah sebagai berikut:
```
Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan 1783 transaksi
```
## Jawaban soal 2d
Untuk sub soal terakhir, pertama kami deklarasikan field separator.
```sh
awk 'BEGIN { FS="\t" }
```
Selanjutnya, kami deklarasikan sebuah action yang berfungsi untuk menyimpan total profit sebuah region dalam array a.
```sh
'{
    if (NR!=1) a[$13] += $21
}
```
Syntax `a[$13] += $21` berfungsi untuk menambahkan profit ($21) sebuah baris ke array dengan region ($13) yang bersesuaian.

Langkah terakhir adalah mencari region dengan total profit paling sedikit lalu mencetak dan meng-*append* hasilnya ke hasi.txt. Cara kerjanya sendiri mirip seperti syntax pencarian segmen paling sedikit pada soal 2c.
```sh
'END{
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
```
Hasilnya adalah sebagai berikut:
```
Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah Central dengan total keuntungan 39706.4 
```

Berikut keseluruhan isi hasi.txt :
```txt
Transaksi terakhir dengan profit percentage terbesar yaitu 9952 dengan persentase 100 %

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
Benjamin Farhat
Michelle Lonsdale
Susan Vittorini
David Wiener

Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan 1783 transaksi

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah Central dengan total keuntungan 39706.4 
```
