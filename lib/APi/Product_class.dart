import 'dart:convert';

class Product {
  final String title;
  final String type;
  final String image;
  final double price;
  final String description;
  final String keywords;
  final String id;

  Product({
    required this.title,
    required this.type,
    required this.image,
    required this.price,
    required this.description,
    required this.keywords,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'] ?? '',
      title: json['product_title'] ?? '',
      type: json['product_type'] ?? '',
      image: json['product_image'] ?? '',
      price: json['product_price'] != null ? double.parse(json['product_price']) : 0.0,
      description: json['product_desc'] ?? '',
      keywords: json['product_keywords'] ?? '',
    );
  }
}
