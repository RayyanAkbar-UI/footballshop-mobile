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

## Jawaban Pertanyaan Tugas 8

### 1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

**Navigator.push()** menambahkan route baru di atas route yang sedang aktif pada stack navigasi. Route lama tetap ada di bawahnya, sehingga pengguna dapat kembali ke halaman sebelumnya dengan tombol back.

**Navigator.pushReplacement()** mengganti route yang sedang aktif dengan route baru. Route lama dihapus dari stack, sehingga pengguna tidak dapat kembali ke halaman sebelumnya dengan tombol back.

**Penggunaan pada Football Shop:**
- **Navigator.push()**: Digunakan saat tombol "Create Product" di halaman utama ditekan. Ini memungkinkan pengguna untuk kembali ke halaman utama setelah mengisi form, atau membatalkan pengisian form dengan tombol back.
- **Navigator.pushReplacement()**: Digunakan pada drawer menu saat berpindah antar halaman utama. Hal ini mencegah penumpukan halaman yang sama di stack navigasi, sehingga user experience lebih baik dan menghindari pengguna terjebak dalam loop navigasi.

### 2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Saya menggunakan struktur widget hierarki sebagai berikut:

```
Scaffold
├── AppBar (konsisten di semua halaman)
│   ├── Title dengan style yang sama
│   └── Background color dari theme
├── Drawer (LeftDrawer widget yang sama di semua halaman)
│   ├── DrawerHeader dengan branding
│   └── ListTile untuk navigasi
└── Body (konten spesifik halaman)
```

**Konsistensi yang diterapkan:**
- Setiap halaman menggunakan `Scaffold` sebagai struktur dasar
- `AppBar` dengan background color dari `Theme.of(context).colorScheme.primary` dan teks putih bold
- `LeftDrawer` yang sama digunakan di semua halaman (menu.dart dan productentry_form.dart)
- Drawer memiliki header dengan branding "Football Shop" dan list menu navigasi yang konsisten

Dengan struktur ini, pengguna mendapatkan pengalaman yang konsisten di semua halaman aplikasi.

### 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

**Kelebihan layout widget:**

1. **Padding**: Memberikan jarak/ruang di sekitar widget untuk meningkatkan keterbacaan dan estetika.
   ```dart
   Padding(
     padding: const EdgeInsets.all(8.0),
     child: TextFormField(
       decoration: InputDecoration(
         labelText: "Nama Produk",
       ),
     ),
   )
   ```
   Setiap input field diberi padding 8.0 agar tidak menempel dengan elemen lain.

2. **SingleChildScrollView**: Membuat konten dapat di-scroll ketika melebihi ukuran layar, penting untuk form yang panjang.
   ```dart
   body: Form(
     child: SingleChildScrollView(
       child: Column(
         children: [
           // Semua input field
         ],
       ),
     ),
   )
   ```
   Pada form produk, ada 6 input field (name, price, description, category, thumbnail, isFeatured). Dengan SingleChildScrollView, form tetap dapat diakses meskipun layar kecil.

3. **ListView**: Efisien untuk menampilkan daftar item yang banyak dengan lazy loading.
   ```dart
   Drawer(
     child: ListView(
       children: [
         DrawerHeader(...),
         ListTile(...),
         ListTile(...),
       ],
     ),
   )
   ```
   Digunakan pada drawer untuk menampilkan menu navigasi secara vertikal.

### 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Saya menyesuaikan warna tema pada aplikasi melalui beberapa cara:

1. **Theme Configuration di main.dart**:
   ```dart
   theme: ThemeData(
     colorScheme: ColorScheme.fromSwatch(
       primarySwatch: Colors.blue,
     ).copyWith(secondary: Colors.blueAccent[400]),
   )
   ```
   Menggunakan biru sebagai warna utama yang identik dengan warna bola (sepakbola) dan memberikan kesan profesional dan sporty.

2. **AppBar dengan warna primary konsisten**:
   ```dart
   AppBar(
     backgroundColor: Theme.of(context).colorScheme.primary,
     foregroundColor: Colors.white,
   )
   ```
   Semua halaman menggunakan warna primary dari theme untuk AppBar.

3. **Drawer Header dengan warna biru**:
   ```dart
   DrawerHeader(
     decoration: BoxDecoration(
       color: Colors.blue,
     ),
   )
   ```

4. **Button dengan warna theme**:
   ```dart
   ElevatedButton(
     style: ButtonStyle(
       backgroundColor: WidgetStateProperty.all(
         Theme.of(context).colorScheme.primary
       ),
     ),
   )
   ```

5. **Kartu produk dengan warna berbeda**:
   ```dart
   ItemHomepage("All Products", Icons.list, Colors.red),
   ItemHomepage("My Products", Icons.shopping_cart, Colors.blue),
   ItemHomepage("Create Product", Icons.add, Colors.green),
   ```
   Setiap kartu diberi warna berbeda untuk membedakan fungsinya, namun tetap dalam palet warna yang harmonis.

Dengan pendekatan ini, aplikasi Football Shop memiliki identitas visual yang konsisten dan mencerminkan brand toko olahraga yang dinamis dan profesional.