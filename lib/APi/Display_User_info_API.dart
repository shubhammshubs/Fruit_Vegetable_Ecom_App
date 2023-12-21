import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceaddress {
  static Future<Map<String, dynamic>?> fetchUserInfo(String mobileNumber) async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readinfo';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'mobile': mobileNumber},
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // Handle the error
      print('Failed to fetch user information. Error: ${response.body}');
      return null;
    }
  }
}




class UserImageApi {
  Future<Map<String, dynamic>> fetchUserData(String mobileNumber) async {
    final apiUrl = "https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=userimg";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {"mobile": mobileNumber},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        // Handle the case when the API call fails or returns an error
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      // Handle the case when an error occurs during the API call
      throw Exception('Error: $error');
    }
  }
}
