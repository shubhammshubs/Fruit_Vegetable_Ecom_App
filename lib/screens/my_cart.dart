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

class _AddToCartPageState extends State<AddToCartPage>

    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> favoriteItems = [];
  late AnimationController _animationController;
  late Animation<Offset> _exitAnimation;
  List<Map<String, dynamic>> cartItems = [];

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _exitAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    // Add a listener to detect when the animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });

    // Delay the animation start by 1 second
    Future.delayed(Duration(seconds: 2), () {
      _animationController.forward();
    });
  }

  void fetchCartItems() async {

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
      final dynamic data = json.decode(response.body);

      // Check if the data is a List<dynamic>
      if (data is List<dynamic>) {
        // Update the state with the cart items
        setState(() {
          cartItems = List<Map<String, dynamic>>.from(data);
        });
      } else {
        print('No Data in Cart: $data');
        // Handle the error appropriately, e.g., show a message to the user
      }
    } else {
      // Handle the error
      print('Failed to fetch cart items. Error: ${response.body}');
    }
  }

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(mobileNumber: widget.mobileNumber),
              ),
            );
            // Navigator.pop(context);
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
          ?
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Mobile number: ${widget.mobileNumber}'),
            Text('Your cart is empty.'),
          ],
        ),
      )
          :
      Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return Stack(
                  children:[
                  Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.bottomLeft, // Center the content vertically
                    padding: EdgeInsets.only(left: 14.0, bottom: 45), // Adjusted for alignment left
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),

                for (int i = 0; i < 2; i++)
                SlideTransition(
                position: Tween<Offset>(
                begin: i == 0 ? const Offset(0, 0) : const Offset(0.15, 0),  // Start from the zero position or half left
                end: i == 0 ? const Offset(0.15, 0) : const Offset(0, 0),   // Move to half right or end at the zero position
                ).animate(_animationController),
                child: i == 0
                ? Dismissible(
                    key: Key(cartItem['product_id'].toString()),
                    onDismissed: (direction) {
                      removeFromCart(cartItem);

                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Card(
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
                        trailing:
                        Text('Quantity: ${cartItem['quantity']}'),

                      ),
                    ),
                 )  : Container(),
                ),
                ]
                );
              },
            ),
          ),
          BottomAppBar(
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        PaymentMethodsPage(
                          mobileNumber: widget.mobileNumber, cartItems: cartItems,
                        )));
                  },
                  child: Text('Checkout'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  void removeFromCart(Map<String, dynamic> cartItem) async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=remcart';

    final mobileNumber = widget.mobileNumber;

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'mobile': mobileNumber,
        'product_id': cartItem['product_id'] ?? '',
        'product_title': cartItem['product_title'] ?? '',
        'product_image': cartItem['product_image'] ?? '',
        'quantity': cartItem['quantity'] ?? '',
        'price': cartItem['price'] ?? '',
      },
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final dynamic data = json.decode(response.body);
      fetchCartItems();
      setState(() {
        cartItems.remove(cartItem);
      });
      print('$data');

    } else {
      // Handle the error
      print('Failed to remove item from cart. Error: ${response.body}');
    }
  }
}

