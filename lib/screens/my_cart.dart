import 'dart:convert';
import 'package:ecom/HomePage1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../APi/Check_Out_APi.dart';
import '../APi/Product_class.dart';
import '../User_Credentials/login_Screen.dart';
import 'Check_Out_Screen/Card_Details.dart';
import 'Check_Out_Screen/Delivery_Address.dart';
import 'Check_Out_Screen/Payment_Options.dart';
import 'Check_Out_Screen/Product_Summery.dart';

class AddToCartPage extends StatefulWidget {
  final String mobileNumber;
  final Product? product; // Make the product parameter nullable
  AddToCartPage({
    required this.mobileNumber,
    this.product
  });
  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}



class _AddToCartPageState extends State<AddToCartPage> {
  List<Map<String, dynamic>> cartItems = [];

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var cartItem in cartItems) {
      // Convert 'price' and 'quantity' to double before multiplication
      double price = double.parse(cartItem['price']);
      double quantity = double.tryParse(cartItem['quantity']) ?? 0.0;

      totalPrice += price ;
    }
    return totalPrice;
  }

  @override
  void initState() {
    super.initState();
    // Fetch cart items when the widget is initialized
    fetchCartItems();
  }

  void fetchCartItems() async {
    // ... (your existing code)

    if (widget.mobileNumber == null || widget.mobileNumber.isEmpty) {
      // ... (your existing code for showing the login dialog)
      return;
    }

    // Continue with the API call
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readcart';

    final mobileNumber = widget.mobileNumber;

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'mobile': mobileNumber},
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final List<dynamic> data = json.decode(response.body);

      // Update the state with the cart items
      setState(() {
        cartItems = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // Handle the error
      print('Failed to fetch cart items. Error: ${response.body}');
    }
  }

  // Future<String?> showPaymentIdDialog(BuildContext context) async {
  //   TextEditingController paymentIdController = TextEditingController();
  //
  //   return showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Enter Payment ID'),
  //         content: TextField(
  //           controller: paymentIdController,
  //           decoration: InputDecoration(
  //             hintText: 'Enter payment ID',
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(paymentIdController.text);
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  // Future<void> handleCheckout() async {
  //   final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=addorder';
  //
  //   final transId = '${DateTime.now().millisecondsSinceEpoch}'; // Generate a custom transaction ID
  //
  //   // Show pop-up dialog to get payment ID
  //   final paymentId = await showPaymentIdDialog(context);
  //   if (paymentId == null || paymentId.isEmpty) {
  //     // User canceled or didn't enter payment ID
  //     print('Checkout canceled by the user.');
  //     return;
  //   }
  //
  //   for (var cartItem in cartItems) {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //       body: {
  //         'mobile': widget.mobileNumber,
  //         'product_id': cartItem['product_id'] ?? '',
  //         'quantity': cartItem['quantity'] ?? '0',
  //         'product_image': cartItem['product_image'] ?? '',
  //         'product_title': cartItem['product_title'] ?? '',
  //         'price': cartItem['price'] ?? '',
  //         'ord_price': calculateTotalPrice().toStringAsFixed(2),
  //         'trans_id': transId,
  //         'payment_id': paymentId,
  //       }..removeWhere((key, value) => value == null), // Remove null values from the body
  //     );
  //
  //     print('API Response: ${response.statusCode}');
  //     print('API Body: ${response.body}');
  //
  //     if (response.statusCode == 200 &&
  //         response.body == 'Successfully added to Cart.') {
  //       // Successfully added to Cart. Show a message.
  //       final snackBar = SnackBar(
  //         content: Text(
  //           'Item ${cartItem['product_title']} added to Cart.',
  //           textAlign: TextAlign.center,
  //         ),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     } else {
  //       print('Failed to upload item to the order. Error: ${response.body}');
  //     }
  //   }
  //
  //   // Navigate to the homepage
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomePage(mobileNumber: widget.mobileNumber)),
  //   );
  // }
  //



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'My Cart ${widget.mobileNumber}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body:(widget.mobileNumber == null || widget.mobileNumber.isEmpty)
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Looks like you are not signed in...'),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Sign In to continue'),
            ),
          ],
        ),
      )
          : cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Mobile number: ${widget.mobileNumber}'),
            Text('Your cart is empty.'),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 100.0,
                      child: Image.network(
                        'https://apip.trifrnd.com/fruits/${cartItem['product_image']}',
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Container(
                            color: Colors.white70,
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ),
                    title: Text('${cartItem['product_title']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${cartItem['price']}',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                    trailing: Text('Quantity: \n      ${cartItem['quantity']}'),
                  ),
                );
              },
            ),
          ),
          BottomAppBar(
            // ... (other BottomAppBar properties remain the same)
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Rs. ${calculateTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     APIService.handleCheckout(
                //       mobileNumber: widget.mobileNumber,
                //       cartItems: cartItems,
                //       context: context,
                //     );                  },
                //   child: Text('Checkout'),
                // ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        PaymentMethodsPage(
                          mobileNumber: widget.mobileNumber, cartItems: cartItems,

                        )));
                  },
                  child: Text('Test'),
                )
              ],
            ),
          ),
        ],
      ),

    );
  }
}
