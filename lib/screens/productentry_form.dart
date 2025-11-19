import 'package:flutter/material.dart';
import 'package:footballshop_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:footballshop_mobile/config.dart';

class ProductEntryFormPage extends StatefulWidget {
  const ProductEntryFormPage({super.key});

  @override
  State<ProductEntryFormPage> createState() => _ProductEntryFormPageState();
}

class _ProductEntryFormPageState extends State<ProductEntryFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "Sepatu";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'Sepatu',
    'Jersey',
    'Bola',
    'Pelindung',
    'Aksesoris',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Product Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color(0xFF0a0a14).withOpacity(0.6),
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFff007f),
              Color(0xFF7f00ff),
              Color(0xFF0077ff),
              Color(0xFF00c6ff),
            ],
            stops: [0.0, 0.33, 0.66, 1.0],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a2e).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFe0a3ff).withOpacity(0.2),
                      blurRadius: 32,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // === Name ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Nama Produk",
                          labelText: "Nama Produk",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _name = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Nama tidak boleh kosong!";
                          }
                          if (value.length < 3) {
                            return "Nama produk minimal 3 karakter!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Price ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Harga Produk",
                          labelText: "Harga Produk",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          setState(() {
                            _price = int.tryParse(value!) ?? 0;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Harga tidak boleh kosong!";
                          }
                          if (int.tryParse(value) == null) {
                            return "Harga harus berupa angka!";
                          }
                          if (int.parse(value) <= 0) {
                            return "Harga harus lebih dari 0!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Description ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Deskripsi Produk",
                          labelText: "Deskripsi Produk",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _description = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Deskripsi tidak boleh kosong!";
                          }
                          if (value.length < 10) {
                            return "Deskripsi minimal 10 karakter!";
                          }
                          return null;
                        },
                      ),
                    ),

                    // === Category ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Kategori",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        initialValue: _category,
                        items: _categories
                            .map(
                              (cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _category = newValue!;
                          });
                        },
                      ),
                    ),

                    // === Thumbnail URL ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "URL Thumbnail (opsional)",
                          labelText: "URL Thumbnail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _thumbnail = value ?? '';
                          });
                        },
                      ),
                    ),

                    // === Is Featured ===
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SwitchListTile(
                        title: const Text("Tandai sebagai Produk Unggulan"),
                        value: _isFeatured,
                        onChanged: (bool value) {
                          setState(() {
                            _isFeatured = value;
                          });
                        },
                      ),
                    ),

                    // === Tombol Simpan ===
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            final request = context.read<CookieRequest>();
                            try {
                              final resp = await request.post(
                                AppConfig.addProductAjax,
                                {
                                  'name': _name,
                                  'price': _price.toString(),
                                  'description': _description,
                                  'quantity': '1',
                                  'category': _category,
                                  // Backend currently ignores image, but include for future
                                  'image': _thumbnail,
                                },
                              );
                              if (resp['status'] == true) {
                                if (!context.mounted) return;
                                // Show confirmation popup (restored)
                                showDialog(
                                  context: context,
                                  builder: (dialogCtx) => AlertDialog(
                                    title: const Text(
                                      'Produk berhasil tersimpan',
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Nama: $_name'),
                                          Text('Harga: Rp $_price'),
                                          Text('Deskripsi: $_description'),
                                          Text('Kategori: $_category'),
                                          Text(
                                            'Thumbnail: ${_thumbnail.isEmpty ? '-' : _thumbnail}',
                                          ),
                                          Text(
                                            'Unggulan: ${_isFeatured ? 'Ya' : 'Tidak'}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(dialogCtx);
                                          _formKey.currentState!.reset();
                                          setState(() {
                                            _name = '';
                                            _price = 0;
                                            _description = '';
                                            _category = 'Sepatu';
                                            _thumbnail = '';
                                            _isFeatured = false;
                                          });
                                          // Return to previous page and signal refresh
                                          if (Navigator.canPop(context)) {
                                            Navigator.pop(context, true);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        resp['message']?.toString() ??
                                            'Failed to create product.',
                                      ),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: ${e.toString()}'),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
