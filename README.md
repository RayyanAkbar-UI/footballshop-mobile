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