# Football Shop Mobile

## Jawaban Pertanyaan Tugas 7

### 1. Apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget?
Widget tree adalah struktur hierarki dari widget yang membentuk tampilan aplikasi Flutter. Setiap widget dapat memiliki satu atau lebih widget anak (child), dan widget anak dapat memiliki widget anak lagi, membentuk sebuah pohon. Parent mengatur tata letak dan perilaku anak, sedangkan anak mewarisi properti dari parent.

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
- MaterialApp: Root aplikasi, mengatur tema dan navigasi.
- Scaffold: Struktur dasar halaman (app bar, body).
- AppBar: Header aplikasi.
- Padding: Memberi jarak di sekitar widget.
- Column: Menyusun widget secara vertikal.
- Row: Menyusun widget secara horizontal.
- Card: Membuat tampilan kotak dengan bayangan.
- Text: Menampilkan teks.
- Icon: Menampilkan ikon.
- GridView.count: Menyusun widget dalam grid.
- Center: Memusatkan widget.
- InkWell: Widget yang dapat ditekan.
- Material: Membuat efek material pada widget.
- SizedBox: Memberi jarak antar widget.

### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
MaterialApp adalah widget utama yang mengatur tema, routing, dan konfigurasi aplikasi berbasis Material Design. Sering digunakan sebagai root karena menyediakan struktur dan fitur dasar yang dibutuhkan aplikasi Flutter.

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
StatelessWidget adalah widget yang tidak memiliki state yang berubah, cocok untuk tampilan statis. StatefulWidget memiliki state yang dapat berubah selama aplikasi berjalan, digunakan untuk tampilan dinamis atau interaktif.

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext adalah objek yang merepresentasikan lokasi widget dalam widget tree. Penting untuk mengakses data, tema, dan fungsi navigasi. Digunakan sebagai parameter pada metode build untuk membangun UI berdasarkan context.

### 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Hot reload memperbarui kode aplikasi tanpa mengulang seluruh aplikasi, sehingga perubahan UI langsung terlihat tanpa kehilangan state. Hot restart memulai ulang aplikasi dari awal, sehingga seluruh state aplikasi direset.

---

## Checklist Implementasi
- [x] Membuat program Flutter baru bertema Football Shop
- [x] Tiga tombol: All Products, My Products, Create Product
- [x] Warna biru, hijau, merah untuk tombol
- [x] Snackbar sesuai tombol
- [x] Jawaban pertanyaan di README.md
# footballshop_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
