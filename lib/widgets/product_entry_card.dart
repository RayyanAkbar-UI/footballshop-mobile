import 'package:flutter/material.dart';
import 'package:footballshop_mobile/models/product_entry.dart';

class ProductEntryCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e).withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.0),
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
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: product.image != null && product.image!.isNotEmpty
                      ? Image.network(
                          product.image!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 150,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.broken_image),
                                ),
                              ),
                        )
                      : Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Category: ${product.category}'),
                const SizedBox(height: 6),
                Text(
                  product.description.length > 100
                      ? '${product.description.substring(0, 100)}...'
                      : product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  product.formattedPrice,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFe0a3ff),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
