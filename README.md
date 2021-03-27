# Soal Shift Sisop 2021 Modul 1

### Anggota:
1. [Frans Wijaya](https://github.com/franswjy403)		(05111940000098)
2. [Jagad Wijaya P.](https://github.com/Jagadwp)	(05111940000132)
3. [Fidhia Ainun K.](https://github.com/fidhiaaka)	(05111940000203)

### List soal:
1. Soal 1
2. Soal 2
3. Soal 3

## Soal 1
Pada soal ini Ryujin diminta membuat **laporan daftar peringkat pesan error terbanyak** dan **laporan penggunaan user** pada aplikasi _ticky_

#### Soal 1a
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

#### Soal 1b
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

#### Soal 1c
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

#### Soal 1d
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

#### Soal 1e
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
## Jawaban Soal 2d
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
```txtu
Transaksi terakhir dengan profit percentage terbesar yaitu 9952 dengan persentase 100 %

Daftar nama customer di Albuqerque pada tahun 2017 antara lain:
Benjamin Farhat
Michelle Lonsdale
Susan Vittorini
David Wiener

Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan 1783 transaksi

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah Central dengan total keuntungan 39706.4 
```
## Soal 3
Secara keseluruhan soal ini meminta script-script yang bisa mendownload gambar, kemudian diberi nama, lalu dijadikan satu folder, dan terakhir di-*zip* berpassword.
## Jawaban Soal 3a
Pertama, kami deklarasikan variabel loc untuk menyimpan path file agar lebih mudah penggunaannya ke depan. Kemudian kami buat sebuah file Foto.log untuk menyimpan log download.
```sh
#!/bin/bash
loc=/home/frans0416/Documents/sisopE/soal3
> "$loc"/Foto.log
```
Untuk mendownload 23 gambar, kami gunakan looping sederhana sebanyak 23 kali.
```sh
for ((i=1; i<=23; i=i+1))
    do
    if [ $i -lt 10 ]
        then wget -a "$loc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$loc"/Koleksi_0"$i".jpeg
    else wget -a "$loc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$loc"/Koleksi_"$i".jpeg
    fi
done
```
Sntax `if [ $i -lt 10 ]` untuk membedakan penamaan yang membutuhkan angka 0 di depannya (ex: 01, 02, etc). Lalu, syntax `wget -a path link` berfungsi untuk meng-*append* log file ke Foto.log. Sedangkan untuk `-O` secara kasar digunakan untuk memberi nama dan format untuk file yang terdownload.

Selanjutny, untuk menghapus file yang double, kami gunakan `rdfind`
```sh
rdfind -deleteduplicates true "$loc"
```
`rdfind` dapat digunakan untuk menghapus file duplikat pada suatu direktori.

Terakhir, dilakukan looping untuk setiap file .jpeg yang ada di direktori tersebut, diberi penamaan baru secara terurut (untuk mengatasi nama-nama file yang hilang akibat delete). Looping dilakukan dengan asumsi command bash ini dijalankan dari root.
```sh
i=1
cd "$loc"
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
```
Syntax `for f in Koleksi_*.jpeg` berguna untuk mencari file-file dengan nama Koleksi_ dan bertipe jpeg. Syntax `mv -- old_file new_fie` kami gunakan untuk memindah file yang ada ke tempat yang sama, tetapi dengan format nama berbeda.
## Jawaban Soal 3b
### soal3b.sh
Untuk soal 3b, tidak jauh berbeda dengan soal 3a. Hanya saja, file-file yang telah di download ini harus disimpan ke dalam sebuah folder dengan format nama DD-MM-YY. Berikut syntax pembuatan foldernya:
```sh
loc=$(date +%d-%m-%Y)
mkdir "$root"/"$loc"
```
Dengan adanya folder baru ini, hanya akan mempengaruhi lokasi penyimpanannya saja. Seperti contohnya:
```sh
wget -a "$root"/"$loc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$root"/"$loc"/Koleksi_0"$i".jpeg
```
### cron3b.tab
Pada soal, diminta menjalankan script soal3b.sh, setiap pukul 20:00 (`00 20`) setiap tujuh hari dimulai dari tanggal 1 (`1/7`) dan setiap 4 hari dimulai dari tanggal 2 (`2/4`).
```tab
00 20 1/7,2/4 * * bash /home/frans0416/Documents/sisopE/soal3/soal3b.sh
```
## Jawaban Soal 3c
Pada soal 3c, diminta pendownload an gambar berbeda tiap harinya. Oleh karena itu ditambahkan beberapa kondisional pada soal 3b. Kami memanfaatkan tanggal untuk pengondisiannya. Apabila tanggal hari tersebut merupakan tanggal genap, maka download foto-foto kucing. Sebaliknya, download foto-foto kelinci. Pengondisian tersebut juga bekerja untuk mengatur pemberian nama folder.
```sh
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
```
Selebihnya, untuk penghapusan file duplikat, penamaan file, dan penyimpanan file hampir sama seperti soal 3b, hanya berbeda path.
## Jawaban Soal 3d
Soal 3d meminta agar semua folder, baik folder kucing maupun kelinci, di zip ke dalam sebuah file bernama Koleksi.zip dan diberi password berupa tanggal dengan format MMDDYYYY.

Pertama, kami deklarasikan dulu beberapa variabel yang berguna untuk pencarian folder yang akan di zip dan penyiapan password.
```sh
#!/bin/bash
SUB="Kelinci"
SUB2="Kucing"
password=$(date +%m%d%Y)
```
Syntax di atas bertujuan agar nantinya, folder yang di zip hanyalah folder kelinci dan kucing.

Langkah selanjutnya adalah mentraverse semua file yang ada di direktori yang sama (`for f in *;`). Jika file merupakan folder (`if [ -d "$f" ]`), maka akan dicek, apakah substring dari nama folder tersebut merupakan salah satu di antara kucing atau kelinci.
```sh
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
```
Untuk membuat zip tersebut dalam keadaan terpassword, digunakan syntax :
```sh
zip -r -P "$password" Koleksi.zip "$f"
```
Lalu, agar folder yang telah di zip tadi terhapus (karena ketika melakukan zip, folder lama masih ada), maka memakai:
```sh
rm -rf "$f"
```
## Jawaban Soal 3e
Soal 3e meminta agar semua folder koleksi foto di zip ketika jam kuliah. Adapun jam kuliahnya adalah setiap hari senin-jumat dari jam 07:00 sampai 18:00. Oleh karena itu, perintah cron yang pertama adalah:
```tab
* 7-18 * * 1-5 bash /home/frans0416/Documents/sisopE/soal3/soal3d.sh
```
Kemudian, permintaan selanjutnya adalah, di luar jam itu, unzip semua file zip dan hapus file zip. Untuk itu, perintah cron yang perlu dilakukan adalah `unzip -P password file`. Password untuk mengunzip direktorinya adalah tanggal di hari itu sendiri. Karena, tiap harinya pasti akan ada proses unzip dan zip. Jadi, pastinya file koleksi foto akan terzip setiap paginya dengan password berupa tanggal di hari itu. Oleh karena itu, unzipnya pun cukup memakain tanggal di hari itu.
```
* 18-23 * * 1-5 unzip -P 'date "+\%m\%d\%Y"' /home/frans0416/Documents/sisopE/soal3/Koleksi.zip && rm /home/frans0416/Documents/sisopE/soal3/Koleksi.zip
```
Lalu, syntax `rm filepath` berguna untuk menghapus zip yang telah diunzip tadi.