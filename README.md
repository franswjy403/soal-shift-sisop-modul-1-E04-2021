# soal-shift-sisop-modul-1-E04-2021

**No.1**
Pada soal ini Ryujin diminta membuat **laporan daftar peringkat pesan error terbanyak** dan **laporan penggunaan user** pada aplikasi _ticky_

**1a**
**Soal:**
(a) Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

**Jawab:**
```
allLogInfo=`grep -o "ticky.*" syslog.log | cut -f 2-`
```
Untuk mengumpulkan semua informasi log , digunakan command ```grep``` dengan kata kunci "ticky.* " pada file syslog.log. 
Dengan option ```-o``` maka yang diprint/dihasilkan hanyalah bagian yang sesuai dengan kata kunci. Hasilnya kurang lebih seperti berikut.
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
Hasil ini dimasukkan ke variabel bernama ```allLogInfo```

**1b**
**Soal:**
(b) Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

**Jawab:**
```
errorList=`echo "$allLogInfo" | grep -o "ERROR.*" | cut -d " " -f 2- | cut -d "(" -f 1 | sort -V | uniq -c | sort -nr`
```
Untuk mengumpulkan semua tipe error beserta jumlahnya. Hasil output dari ```echo $allLogInfo```  dijadikan input ke command berikutnya 
dengan operator ```|``` pipe. Kita cari log error dengan ```grep``` dengan kata kunci  "ERROR.* ". Kemudian diambil deskripsi errornya saja 
menggunakan ```cut``` dengan demiliter dan option yang dibutuhkan. Setelah itu daftar error dirapikan/diurutkan berdasarkan jenisnya menggunakan ```sort```.
Kemudian tiap jenis error (baris-baris yang berulang) dihitung dengan command `uniq -c` dan diurutkan berdasarkan jenis error terbanyak dengan ```sort -nr```
Hasilnya kurang lebih seperti berikut.
<pre>
15 Timeout while retrieving information 
13 Connection to DB failed 
12 Tried to add information to closed ticket 
10 Permission denied while closing ticket 
9 The ticket was modified while updating 
7 Ticket doesn&apos;t exist 
</pre>

**1c**
**Soal:**
(c) Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.

**Jawab:**

**1d**
**Soal:**
(d) Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh 
daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

**Jawab:**

**1d**
**Soal:**
(e) Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.

**Jawab:**




