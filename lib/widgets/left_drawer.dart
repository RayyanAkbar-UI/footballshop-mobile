import 'package:flutter/material.dart';
import 'package:footballshop_mobile/screens/menu.dart';
import 'package:footballshop_mobile/screens/productentry_form.dart';
import 'package:footballshop_mobile/screens/product_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0a0a14),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFe0a3ff), Color(0xFFff69b4)],
              ),
            ),
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Colors.white70],
                  ).createShader(bounds),
                  child: const Text(
                    'Football Shop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                const Text(
                  'Toko sepakbola terlengkap!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Color(0xFFe0a3ff)),
            title: const Text(
              'Halaman Utama',
              style: TextStyle(color: Colors.white),
            ),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Color(0xFFe0a3ff)),
            title: const Text(
              'Tambah Produk',
              style: TextStyle(color: Colors.white),
            ),
            // Bagian redirection ke ProductEntryFormPage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductEntryFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list, color: Color(0xFFe0a3ff)),
            title: const Text(
              'Semua Produk',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductEntryListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
