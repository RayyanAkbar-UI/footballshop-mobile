import 'package:flutter/material.dart';
import 'package:footballshop_mobile/models/product_entry.dart';
import 'package:footballshop_mobile/widgets/left_drawer.dart';
import 'package:footballshop_mobile/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:footballshop_mobile/config.dart';
import 'package:footballshop_mobile/screens/product_detail.dart';
import 'package:footballshop_mobile/screens/productentry_form.dart';

class ProductEntryListPage extends StatefulWidget {
  final bool showOnlyMyProducts;

  const ProductEntryListPage({super.key, this.showOnlyMyProducts = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  late bool _myItemsOnly;
  String _searchText = '';
  String _selectedCategory = 'All';
  String _sortBy = 'Newest';
  bool _sortAsc = false;

  @override
  void initState() {
    super.initState();
    _myItemsOnly = widget.showOnlyMyProducts;
  }

  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    try {
      final url = AppConfig.jsonProducts(myItems: _myItemsOnly);
      // ignore: avoid_print
      print('[FETCH] Requesting: $url');
      // ignore: avoid_print
      print('[FETCH] Logged in: ${request.loggedIn}');

      final response = await request.get(url);

      // ignore: avoid_print
      print('[FETCH] Response type: ${response.runtimeType}');
      // ignore: avoid_print
      print(
        '[FETCH] Response length: ${response is List ? response.length : 'not a list'}',
      );

      if (response is! List) {
        // ignore: avoid_print
        print('[FETCH] ERROR: Response is not a list: $response');
        throw Exception(
          'Invalid response format: expected list, got ${response.runtimeType}',
        );
      }

      List<ProductEntry> list = [];
      for (var d in response) {
        if (d != null) {
          try {
            list.add(ProductEntry.fromJson(d));
          } catch (e) {
            // ignore: avoid_print
            print('[FETCH] ERROR parsing product: $e');
            // ignore: avoid_print
            print('[FETCH] Problem data: $d');
          }
        }
      }

      // ignore: avoid_print
      print('[FETCH] Successfully parsed ${list.length} products');
      return list;
    } catch (e, stackTrace) {
      // ignore: avoid_print
      print('[FETCH] EXCEPTION: $e');
      // ignore: avoid_print
      print('[FETCH] Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_myItemsOnly ? 'My Products' : 'All Products'),
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
        child: FutureBuilder(
          future: fetchProducts(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Failed to load products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.error.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => setState(() {}),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Server: ${AppConfig.base}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(
                child: Text(
                  'There are no products yet.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            // Build filter options
            final List<ProductEntry> all = List<ProductEntry>.from(
              snapshot.data,
            );
            final categories = <String>{
              'All',
              ...all.map((e) => e.category),
            }.toList();
            // Apply client-side filters
            List<ProductEntry> filtered = all.where((p) {
              final matchesSearch =
                  _searchText.isEmpty ||
                  p.name.toLowerCase().contains(_searchText.toLowerCase()) ||
                  p.description.toLowerCase().contains(
                    _searchText.toLowerCase(),
                  );
              final matchesCategory =
                  _selectedCategory == 'All' || p.category == _selectedCategory;
              return matchesSearch && matchesCategory;
            }).toList();

            // Apply sorting
            int cmp<T extends Comparable>(T a, T b) => a.compareTo(b);
            int dir = _sortAsc ? 1 : -1;
            filtered.sort((a, b) {
              switch (_sortBy) {
                case 'Price':
                  return dir * cmp(a.price, b.price);
                case 'Name':
                  return dir * cmp(a.name.toLowerCase(), b.name.toLowerCase());
                case 'Views':
                  return dir * cmp(a.viewCount, b.viewCount);
                case 'Quantity':
                  return dir * cmp(a.quantity, b.quantity);
                case 'Newest':
                default:
                  final da =
                      DateTime.tryParse(a.createdAt) ??
                      DateTime.fromMillisecondsSinceEpoch(0);
                  final db =
                      DateTime.tryParse(b.createdAt) ??
                      DateTime.fromMillisecondsSinceEpoch(0);
                  return dir * cmp(da, db);
              }
            });

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search products...',
                    ),
                    onChanged: (v) => setState(() => _searchText = v),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Text('Sort by:'),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _sortBy,
                        items: const [
                          DropdownMenuItem(
                            value: 'Newest',
                            child: Text('Newest'),
                          ),
                          DropdownMenuItem(
                            value: 'Price',
                            child: Text('Price'),
                          ),
                          DropdownMenuItem(value: 'Name', child: Text('Name')),
                          DropdownMenuItem(
                            value: 'Views',
                            child: Text('Views'),
                          ),
                          DropdownMenuItem(
                            value: 'Quantity',
                            child: Text('Quantity'),
                          ),
                        ],
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() {
                            _sortBy = v;
                            _sortAsc = v == 'Newest' ? false : true;
                          });
                        },
                      ),
                      IconButton(
                        tooltip: _sortAsc ? 'Ascending' : 'Descending',
                        icon: Icon(
                          _sortAsc ? Icons.arrow_upward : Icons.arrow_downward,
                        ),
                        onPressed: () => setState(() => _sortAsc = !_sortAsc),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _searchText = '';
                            _selectedCategory = 'All';
                            _myItemsOnly = false;
                            _sortBy = 'Newest';
                            _sortAsc = false;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: categories
                        .map(
                          (cat) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(cat),
                              selected: _selectedCategory == cat,
                              onSelected: (_) =>
                                  setState(() => _selectedCategory = cat),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => setState(() {}),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) => ProductEntryCard(
                        product: filtered[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: filtered[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductEntryFormPage(),
            ),
          );
          if (created == true) setState(() {});
        },
        backgroundColor: const Color(0xFFe0a3ff),
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
