import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(
  json.decode(str).map((x) => ProductEntry.fromJson(x)),
);

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  final int id;
  final String name;
  final int price;
  final String formattedPrice;
  final String description;
  final int quantity;
  final String category;
  final String? image; // thumbnail equivalent
  final String createdAt;
  final int viewCount;
  final int userId;
  final String username;

  ProductEntry({
    required this.id,
    required this.name,
    required this.price,
    required this.formattedPrice,
    required this.description,
    required this.quantity,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.viewCount,
    required this.userId,
    required this.username,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    formattedPrice: json["formatted_price"],
    description: json["description"],
    quantity: json["quantity"],
    category: json["category"],
    image: json["image"],
    createdAt: json["created_at"],
    viewCount: json["view_count"],
    userId: json["user_id"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "formatted_price": formattedPrice,
    "description": description,
    "quantity": quantity,
    "category": category,
    "image": image,
    "created_at": createdAt,
    "view_count": viewCount,
    "user_id": userId,
    "username": username,
  };
}
