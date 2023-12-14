import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../HomePage1.dart';
import 'OrderScreen_Navigators/Active_Orders.dart';
import 'OrderScreen_Navigators/Cancle_Orders.dart';
import 'OrderScreen_Navigators/Completed_Orders.dart';

class OrdersScreen extends StatefulWidget {
  final String mobileNumber;
  const OrdersScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'Active',
        style: TextStyle(
          color: Colors.black45, // Set the tab name color to black
        ),
      ),
    ),
    Tab(
      child: Text(
        'Completed',
        style: TextStyle(
          color: Colors.black45, // Set the tab name color to black
        ),
      ),
    ),
    Tab(
      child: Text(
        'Cancelled',
        style: TextStyle(
          color: Colors.black45, // Set the tab name color to black
        ),
      ),
    ),
  ];

  void fetchCartItems() async {
    // ... (your existing code)

    if (widget.mobileNumber == null || widget.mobileNumber.isEmpty) {
      // ... (your existing code for showing the login dialog)
      return;
    }

    // Continue with the API call
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readorder';

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
      // setState(() {
      //   cartItems = List<Map<String, dynamic>>.from(data);
      // });
    } else {
      // Handle the error
      print('Failed to fetch cart items. Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Orders',
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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
            bottom: TabBar(
              tabs: myTabs,
              indicatorColor: Colors.green, // Change the indicator color as needed
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Change the selected tab text color to green
              ),
              unselectedLabelColor: Colors.black, // Change the unselected tab text color
            ),

        ),
        body: TabBarView(
          children: [
            // Add your content for "Active" tab here
            ActiveOrdersPage(mobileNumber: widget.mobileNumber,), // Create an instance of ActiveOrdersPage

            // Add your content for "Completed" tab here
            CompletedOrdersPage(
              mobileNumber: widget.mobileNumber,
            ),

            // Add your content for "Cancelled" tab here
            CancleOrdersPage(
              mobileNumber: widget.mobileNumber,
            ),
          ],
        ),
      ),
    );
  }
}
