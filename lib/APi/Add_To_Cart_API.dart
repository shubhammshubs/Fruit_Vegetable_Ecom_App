//
// // api_services.dart
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
//
//
// // Corrected version of addToCart function
// Future<bool> addToCart(String productId, int selectedQuantity, double totalPrice) async {
//   final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=addtocart';
//   final mobileNumber = '1111111111';
//
//   final response = await http.post(
//     Uri.parse(apiUrl),
//     headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//     body: {
//       'mobile': mobileNumber,
//       'product_id': productId,
//       'quantity': selectedQuantity.toString(),
//       'price': totalPrice.toString(),
//     },
//   );
//
//   if (response.statusCode == 200) {
//     print('Response Body: ${response.body}');
//     print('Item added to cart successfully Done');
//     return true; // Indicate success
//   } else {
//     print('Failed to add item to cart. Error: ${response.body}');
//     return false; // Indicate failure
//   }
// }
//
// // How to use the addToCart function
// void yourFunction() async {
//   bool success = await addToCart(widget.product.id.toString(), selectedQuantity, totalPrice);
//
//   if (success) {
//     // Show a SnackBar to inform the user that the item has been added
//     final snackBar = SnackBar(
//       content: Text('Item has been added to the cart', textAlign: TextAlign.center),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   } else {
//     // Handle the case where adding to the cart was not successful
//   }
// }
