Tracker Pribadi - Aplikasi Pelacak Produktivitas Personal
Tracker Pribadi adalah aplikasi cross-platform (Android, iOS, Windows) yang dibangun dengan Flutter dan Go. Aplikasi ini dirancang untuk membantu Anda melacak berbagai aspek penting dalam kehidupan profesional dan personal Anda, semuanya dalam satu tempat yang terorganisir.

🚀 Tentang Proyek
Aplikasi ini lahir dari kebutuhan untuk memiliki sebuah dasbor terpusat untuk memantau:

Pengeluaran Pribadi: Mencatat dan menganalisis ke mana uang Anda pergi.

Proyek & Tugas: Mengelola proyek sampingan atau tugas-tugas pekerjaan dengan status dan urgensi yang jelas.

Lamaran Kerja: Melacak setiap lamaran kerja yang Anda kirim, mulai dari status "Applied" hingga "Offer".

Dengan antarmuka yang bersih dan modern, Tracker Pribadi bertujuan untuk memberikan gambaran yang jelas tentang kemajuan Anda dan membantu Anda membuat keputusan yang lebih baik.

✨ Fitur Utama
Autentikasi Pengguna: Sistem login dan registrasi yang aman.

Dasbor Ringkasan: Tampilan utama yang memberikan ringkasan cepat dari semua metrik penting.

Pelacak Pengeluaran: Tambah, lihat, dan analisis pengeluaran berdasarkan kategori.

Manajemen Proyek: Lacak status, urgensi, dan deadline untuk setiap proyek atau tugas.

Pelacak Lamaran Kerja: Pantau setiap tahap dari proses rekrutmen untuk setiap lamaran.

Tema Terang & Gelap: Dukungan tema yang indah dan konsisten yang beradaptasi dengan preferensi sistem Anda.

Cross-Platform: Berjalan mulus di Android, iOS, dan Windows dari satu basis kode.

🛠️ Teknologi yang Digunakan
Proyek ini dibagi menjadi dua bagian utama:

Frontend (Aplikasi Mobile & Desktop):

Flutter: Framework UI dari Google untuk membangun aplikasi yang indah dan dikompilasi secara native.

Riverpod: Solusi state management yang modern dan kuat.

google_fonts: Untuk menggunakan font yang bersih dan profesional (Inter).

fl_chart: Untuk membuat grafik yang indah dan interaktif.

intl: Untuk memformat angka (mata uang) dan tanggal.

Backend (Server API):

Go (Golang): Bahasa pemrograman yang cepat dan efisien dari Google.

Gin: Framework web berperforma tinggi untuk membangun API.

⚙️ Panduan Instalasi & Menjalankan
Untuk menjalankan proyek ini secara lokal, Anda perlu menjalankan backend dan frontend secara terpisah.

1. Menjalankan Backend (Server Go)
Pastikan Anda sudah menginstal Go di sistem Anda.

# 1. Masuk ke direktori backend
cd backend

# 2. Inisialisasi Go module (hanya perlu dilakukan sekali)
go mod init tracker/backend

# 3. Unduh semua dependensi yang dibutuhkan (seperti Gin)
go mod tidy

# 4. Jalankan server!
go run main.go

Server Anda sekarang akan berjalan di http://localhost:8088. Biarkan jendela terminal ini tetap terbuka.

2. Menjalankan Frontend (Aplikasi Flutter)
Pastikan Anda sudah menginstal Flutter SDK.

# 1. Masuk ke direktori root proyek (trackerpribadi)
# (Satu level di atas folder backend dan tracker)

# 2. Unduh semua package Flutter yang dibutuhkan
flutter pub get

# 3. Jalankan aplikasi di perangkat pilihan Anda (Emulator atau Desktop)
flutter run

Aplikasi akan secara otomatis terhubung ke server backend yang sedang berjalan.

Catatan Penting:

Koneksi Lokal: Kode frontend sudah dikonfigurasi untuk secara otomatis menggunakan http://10.0.2.2:8088 saat berjalan di Emulator Android dan http://localhost:8088 di platform lain.

Firewall: Jika Anda mengalami masalah koneksi di Windows, pastikan Anda telah mengizinkan koneksi masuk untuk port 8088 di Windows Defender Firewall.

📂 Struktur Folder
trackerpribadi/
├── backend/
│   ├── go.mod
│   ├── go.sum
│   └── main.go         # Logika server Go
│
└── tracker/            # Root aplikasi Flutter
    ├── lib/
    │   ├── core/
    │   │   ├── routing/
    │   │   │   └── fade_page_route.dart
    │   │   └── theme.dart  # Tema aplikasi (warna, font)
    │   │
    │   ├── features/       # Fitur-fitur utama aplikasi
    │   │   ├── auth/
    │   │   ├── dashboard/
    │   │   ├── expenses/
    │   │   ├── jobs/
    │   │   └── projects/
    │   │
    │   ├── models/         # Model data (Project, Expense, dll)
    │   ├── main_screen.dart
    │   └── main.dart       # Titik masuk utama aplikasi Flutter
    │
    ├── assets/
    │
