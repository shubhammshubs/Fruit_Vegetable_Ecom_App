import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OrderScreen_Navigators/Active_Orders.dart';
import 'OrderScreen_Navigators/Cancle_Orders.dart';
import 'OrderScreen_Navigators/Completed_Orders.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

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
              Navigator.pop(context);
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
            ActiveOrdersPage(), // Create an instance of ActiveOrdersPage

            // Add your content for "Completed" tab here
            CompletedOrdersPage(),

            // Add your content for "Cancelled" tab here
            CancleOrdersPage(),
          ],
        ),
      ),
    );
  }
}
