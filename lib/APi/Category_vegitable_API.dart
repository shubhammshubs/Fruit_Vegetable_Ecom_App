import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Inside_Pages/Product.dart';
import 'Product_class.dart';

Future<List<Product>> fetchDataFromApi(String productCategory) async {
  try {
    final response = await http.post(
      Uri.parse('https://apip.trifrnd.com/fruits/vegfrt.php?apicall=product'),
      body: {'product_cat': productCategory},
    );

    // print('API Request for $productCategory');
    // print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      if (data is List) {
        // Convert the dynamic list to a list of Product objects
        List<Product> products = data
            .map((item) => Product.fromJson(item))
            .toList();
        return products;
      } else {
        // If the response is not a list, return an empty list
        return [];
      }
    } else {
      throw Exception('Failed to load data from the API');
    }
  } catch (e) {
    print('Exception occurred: $e');
    throw Exception('Failed to load data from the API');
  }
}

class ImageHelper {
  static const String baseUrl = 'https://apip.trifrnd.com/fruits/';

  static String getProductImageUrl(String imagePath) {
    return '$baseUrl$imagePath';
  }
}



//
// class Product {
//   final String title;
//   final String type;
//   final String image;
//   final double price;
//   final String description;
//   final String keywords;
//
//   Product({
//     required this.title,
//     required this.type,
//     required this.image,
//     required this.price,
//     required this.description,
//     required this.keywords,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       title: json['product_title'] ?? '',
//       type: json['product_type'] ?? '',
//       image: json['product_image'] ?? '',
//       price: json['product_price'] != null ? double.parse(json['product_price']) : 0.0,
//       description: json['product_desc'] ?? '',
//       keywords: json['product_keywords'] ?? '',
//     );
//   }
// }