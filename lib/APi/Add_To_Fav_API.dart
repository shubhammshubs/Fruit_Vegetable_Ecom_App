
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// api_service.dart
import 'package:http/http.dart' as http;

class ApiServiceforFavItem {
  static Future<void> addToFav({
    required String mobileNumber,
    required String productId,
    // required int selectedQuantity,
    required double totalPrice,
    required String title,
    required String image,
  }) async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=addtofav';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'mobile': mobileNumber,
          'product_id': productId.toString(),
          // 'quantity': selectedQuantity.toString(),
          'price': totalPrice.toString(),
          'product_title': title,
          'product_image': image,
        },
      );

      if (mobileNumber.isNotEmpty && response.statusCode == 200) {
        print('Response Body: ${response.body}');
        print('Item added to cart successfully Done');
        // Handle success, you might want to return something or handle navigation
      } else {
        // Handle error
        print('Failed to add item to cart. Error: ${response.body}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
    }
  }
}
