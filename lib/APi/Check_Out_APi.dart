import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../HomePage1.dart';

class APIService {
  static Future<void> handleCheckout({
    required String mobileNumber,
    required List<Map<String, dynamic>> cartItems,
    required BuildContext context,
    required String paymentOption, // Add this parameter

  }) async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=addorder';

    final transId = '${DateTime.now().millisecondsSinceEpoch}';

    // final paymentId = await showPaymentIdDialog(context);
    // if (paymentId == null || paymentId.isEmpty) {
    //   print('Checkout canceled by the user.');
    //   return;
    // }

    for (var cartItem in cartItems) {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'mobile': mobileNumber,
          'product_id': cartItem['product_id'] ?? '',
          'quantity': cartItem['quantity'] ?? '0',
          'product_image': cartItem['product_image'] ?? '',
          'product_title': cartItem['product_title'] ?? '',
          'price': cartItem['price'] ?? '',
          'ord_price': calculateTotalPrice(cartItems).toStringAsFixed(2),
          'trans_id': transId,
          'payment_id': paymentOption, // Pass the selected payment option here

          // 'payment_id': paymentId,
        }..removeWhere((key, value) => value == null),
      );

      print('API Response: ${response.statusCode}');
      print('API Body: ${response.body}');

      if (response.statusCode == 200 &&
          response.body == "Order placed Successfully.") {
        final snackBar = SnackBar(
          content: Text(
            'Item ${cartItem['product_title']} added to Cart.',
            textAlign: TextAlign.center,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      } else {
        print('Failed to upload item to the order. Error: ${response.body}');

        final snackBar = SnackBar(
          content: Text(
            'Your Oder has been Placed for ${cartItem['quantity']} ${cartItem['product_title']}',
            textAlign: TextAlign.center,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: "Basic_channel",
            title: "Congratulation...",
            body: "Your Order has been Placed. Use this transaction id $transId for future reference.",
          ),

        );
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(mobileNumber: mobileNumber)),
    );



    }

  static double calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
    double totalPrice = 0.0;
    for (var cartItem in cartItems) {
      double price = double.parse(cartItem['price']);
      double quantity = double.tryParse(cartItem['quantity']) ?? 0.0;

      totalPrice += price ;
    }
    return totalPrice;
  }

  static Future<String?> showPaymentIdDialog(BuildContext context) async {
    // Implement your showPaymentIdDialog logic here
    TextEditingController paymentIdController = TextEditingController();
    // Use a TextEditingController for user input and return the entered value
    // This is just a placeholder, replace it with your actual implementation
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Payment ID'),
          content: TextField(
            controller: paymentIdController,
            decoration: InputDecoration(
              hintText: 'Enter payment ID',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(paymentIdController.text);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}