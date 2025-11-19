import 'package:flutter/material.dart';
import 'package:footballshop_mobile/screens/productentry_form.dart';
import 'package:footballshop_mobile/screens/product_entry_list.dart';
import 'package:footballshop_mobile/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:footballshop_mobile/config.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFe0a3ff).withOpacity(0.3),
            const Color(0xFFff69b4).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFe0a3ff).withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Kamu telah menekan tombol ${item.name}"),
                ),
              );

            // Navigate ke route yang sesuai (tergantung jenis tombol)
            if (item.name == "Create Product") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductEntryFormPage(),
                ),
              );
            } else if (item.name == "All Products" ||
                item.name == "My Products") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductEntryListPage(
                    showOnlyMyProducts: item.name == "My Products",
                  ),
                ),
              );
            } else if (item.name == "Logout") {
              // TODO: Replace with your app URL and keep trailing slash
              final response = await request.logout(AppConfig.authLogout);
              String message = response["message"];
              if (context.mounted) {
                if (response['status']) {
                  String uname = response["username"] ?? '';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$message See you again, $uname.")),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                }
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, color: Colors.white, size: 30.0),
                  const Padding(padding: EdgeInsets.all(3)),
                  Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
