import 'dart:convert';
import 'package:ecom/APi/Product_class.dart';
import 'package:http/http.dart' as http;

class ImageHelper1 {
  static const String baseUrl = 'https://apip.trifrnd.com/fruits/';

  static String getProductImageUrl(String imagePath) {
    return '$baseUrl$imagePath';
  }
}


Future<List<Product>> PopularItemFromApi({String? productCategory}) async {
  try {
    final response = await http.post(
      Uri.parse('https://apip.trifrnd.com/fruits/vegfrt.php?apicall=popular'),
      body: {'popular_item': '1'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      if (data is List) {
        List<Product> products = data
            .map((item) => Product.fromJson(item))
            .toList();
        return products;
      } else {
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
