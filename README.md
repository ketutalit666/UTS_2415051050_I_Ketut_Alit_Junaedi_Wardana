
# 🌴 BaliTrip — Bali Travel Planner

**BaliTrip** adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengguna menjelajahi destinasi wisata di Bali dan merencanakan perjalanan dengan lebih mudah.

Aplikasi ini menyediakan informasi destinasi wisata, informasi cuaca, fitur favorit, serta pengelolaan rencana perjalanan yang terhubung dengan database Supabase.

---

## 👨‍🎓 Identitas Mahasiswa

| Keterangan | Detail |
|---|---|
| Nama | I Ketut Alit Junaedi Wardana |
| NIM | 2415051050 |
| Mata Kuliah | Pemrograman Berbasis Mobile |
| Program | Aplikasi Mobile Flutter |
| Nama Aplikasi | BaliTrip |

---

## 📱 Fitur Aplikasi

1. **Home** — Menampilkan halaman utama, rekomendasi destinasi, dan informasi wisata.
2. **Explore** — Menjelajahi berbagai destinasi wisata Bali berdasarkan kategori dan pencarian.
3. **Destination Detail** — Menampilkan informasi detail destinasi, foto, dan informasi cuaca.
4. **Favorite** — Menyimpan destinasi favorit secara lokal menggunakan SharedPreferences.
5. **Add Itinerary** — Menambahkan rencana perjalanan baru.
6. **Edit Itinerary** — Mengubah informasi rencana perjalanan.
7. **My Trips** — Melihat dan mengelola daftar rencana perjalanan.
8. **Profile** — Menampilkan halaman profil pengguna.

---

## 🛠️ Teknologi yang Digunakan

| Teknologi | Kegunaan |
|---|---|
| Flutter | Framework pengembangan aplikasi |
| Dart | Bahasa pemrograman |
| Provider | State management |
| Supabase | Backend dan database |
| PostgreSQL | Penyimpanan data itinerary |
| REST API | Mengambil informasi cuaca |
| Open-Meteo API | Sumber data cuaca |
| SharedPreferences | Penyimpanan data favorit lokal |
| HTTP | Mengirim dan menerima permintaan API |

---

## 🏗️ Arsitektur Aplikasi

Aplikasi menggunakan pemisahan tanggung jawab berdasarkan beberapa bagian:

- **Models** — Menyimpan struktur data aplikasi.
- **Providers** — Mengelola state dan interaksi data menggunakan Provider.
- **Repositories** — Menangani akses dan pengambilan data.
- **Services** — Menangani komunikasi dengan layanan eksternal.
- **Screens** — Menyimpan halaman antarmuka aplikasi.
- **Data** — Menyimpan data destinasi wisata.

---

## 🌐 Integrasi REST API

BaliTrip menggunakan Open-Meteo API untuk mengambil informasi cuaca berdasarkan koordinat destinasi wisata.

Informasi yang ditampilkan meliputi:
- Suhu saat ini.
- Suhu yang dirasakan.
- Kelembapan udara.
- Kecepatan angin.
- Kondisi cuaca.

Sumber API:

https://open-meteo.com/

---

## 🗄️ Database

Aplikasi menggunakan Supabase dengan PostgreSQL sebagai backend untuk menyimpan data rencana perjalanan.

Tabel utama yang digunakan:

**trip_plans**

| Kolom | Keterangan |
|---|---|
| id | Identitas data |
| destination_name | Nama destinasi |
| visit_date | Tanggal kunjungan |
| notes | Catatan perjalanan |
| status | Status perjalanan |
| created_at | Waktu pembuatan data |

Operasi database yang diterapkan:
- Create: Menambahkan rencana perjalanan.
- Read: Menampilkan rencana perjalanan.
- Update: Mengubah rencana perjalanan.
- Delete: Menghapus rencana perjalanan.

---

## ❤️ Penyimpanan Favorit

Data destinasi favorit disimpan menggunakan SharedPreferences sehingga pilihan favorit tetap tersedia setelah aplikasi di-refresh atau dibuka kembali pada perangkat yang sama.

---

## 📂 Struktur Folder

```text
lib/
├── data/
├── models/
├── providers/
├── repositories/
├── screens/
├── services/
├── theme/
└── main.dart

test/
└── widget_test.dart

pubspec.yaml
README.md
```

---

## 🚀 Cara Menjalankan Aplikasi

### 1. Clone Repository

```bash
git clone https://github.com/ketutalit666/UTS_2415051050_I_Ketut_Alit_Junaedi_Wardana.git
```

### 2. Masuk ke Folder Project

```bash
cd UTS_2415051050_I_Ketut_Alit_Junaedi_Wardana
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Konfigurasi Supabase

Pastikan konfigurasi Supabase yang diperlukan sudah disiapkan di project sebelum menjalankan aplikasi.

Gunakan Supabase Project URL dan anon/publishable key. Jangan memasukkan service_role key atau kredensial rahasia ke repository publik.

### 5. Jalankan Aplikasi

```bash
flutter run
```

---

## 🧪 Pengujian

Pengujian aplikasi dilakukan menggunakan perintah:

```bash
flutter analyze
```

```bash
flutter test
```

---

## 📦 Build APK

Untuk menghasilkan aplikasi Android:

```bash
flutter build apk --release
```

File APK hasil build berada di:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Nama file untuk pengumpulan:

```text
UTS_2415051050_I_Ketut_Alit_Junaedi_Wardana.apk
```

---

## 👨‍💻 Pengembang

**I Ketut Alit Junaedi Wardana**

NIM: 2415051050

Project Ujian Tengah Semester — Pengembangan Aplikasi Mobile menggunakan Flutter.

---

© 2026 BaliTrip. All Rights Reserved.
