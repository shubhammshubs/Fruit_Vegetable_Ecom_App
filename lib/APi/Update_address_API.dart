import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceUpdateAddress {
  static Future<bool> updateAddress( {
    required String mobile,
    required String state,
    required String district,
    required String city,
    required String address,
  }) async {
    final apiUrl =
        'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=addres';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'mobile': mobile,
          'state': state,
          'district': district,
          'city': city,
          'address': address,
        },
      );

      if (response.statusCode == 200) {
        // Successfully updated the address
        return true;
      } else {
        // Failed to update the address
        print('Failed to update address. Error: ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle any exceptions during the HTTP request
      print('Error updating address: $e');
      return false;
    }
  }
}
