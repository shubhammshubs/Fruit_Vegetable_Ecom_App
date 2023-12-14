import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../User_Credentials/login_Screen.dart';

class ActiveOrdersPage extends StatefulWidget {
  final String mobileNumber;

  ActiveOrdersPage({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _ActiveOrdersPageState createState() => _ActiveOrdersPageState();
}

class _ActiveOrdersPageState extends State<ActiveOrdersPage> {
  late GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;

  @override
  void initState() {
    super.initState();
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  }

  Future<void> _refresh() async {
    // Trigger the refresh
    _refreshIndicatorKey.currentState?.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          // Implement the refresh logic here
          setState(() {});
        },
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchOrderData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return       Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Looks like you are not signed in...'),
                    SizedBox(height: 20),
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
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No orders found.');
            } else {
              List<Map<String, dynamic>> orderData = snapshot.data!;
              // Filter orders based on status
              List<Map<String, dynamic>> activeOrders = orderData
                  .where((order) =>
              order['status'] == 'Order Placed' ||
                  order['status'] == 'In Progress')
                  .toList();

              // Group orders by payment ID
              Map<String, List<Map<String, dynamic>>> groupedOrders = {};
              activeOrders.forEach((order) {
                String transId = order['trans_id'].toString();
                if (!groupedOrders.containsKey(transId)) {
                  groupedOrders[transId] = [];
                }
                groupedOrders[transId]!.add(order);
              });

              return OrdersList(
                groupedOrders: groupedOrders,
                mobileNumber: widget.mobileNumber,
                refreshCallback: _refresh,
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchOrderData() async {
    final apiUrl =
        'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readorder';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'mobile': widget.mobileNumber},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load order data');
    }
  }
}

class OrdersList extends StatelessWidget {
  final String mobileNumber;
  final Map<String, List<Map<String, dynamic>>> groupedOrders;
  final VoidCallback refreshCallback;

  OrdersList(
      {required this.groupedOrders,
        required this.mobileNumber,
        required this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groupedOrders.length,
      itemBuilder: (context, index) {
        String transId = groupedOrders.keys.elementAt(index);
        List<Map<String, dynamic>> orders = groupedOrders[transId]!;
        return ActiveOrderCard(
          id: transId,
          orderDate: "Vegetable\n/Fruits", // You may want to change this
          payment: orders[0]['ord_price'].toString(),
          status: orders[0]['status'].toString(),
          mobileNumber: mobileNumber,
          refreshCallback: refreshCallback,
        );
      },
    );
  }
}

Future<void> cancelOrder(
    String transactionId, String mobileNumber, VoidCallback refreshCallback) async {
  try {
    final apiUrl =
        'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=cancelord';

    // Print the parameters being passed
    print('Cancel Order Request - Mobile: $mobileNumber, Transaction ID: $transactionId');

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'mobile': mobileNumber,
        'trans_id': transactionId,
      },
    );

    if (response.statusCode == 200) {
      // Handle success response
      print('Order cancelled successfully');
      print('Response Message: ${response.body}');
      print('Cancel Order Request 2 - Mobile: $mobileNumber, Transaction ID: $transactionId');

      // Trigger refresh after canceling order
      refreshCallback();
    } else {
      // Handle error response
      print('Failed to cancel order. Status code: ${response.statusCode}');
      print('Error Message: ${response.body}');
    }
  } catch (e) {
    // Handle exception
    print('Exception while cancelling order: $e');
  }
}

class ActiveOrderCard extends StatelessWidget {
  final String mobileNumber;
  final String id;
  final String orderDate;
  final String payment;
  final String status;
  final VoidCallback refreshCallback;

  ActiveOrderCard({
    required this.id,
    required this.orderDate,
    required this.payment,
    required this.status,
    required this.mobileNumber,
    required this.refreshCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: status == 'In Progress'
                      ? Colors.amber.shade50
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: status == 'Order Placed'
                        ? Colors.green
                        : Colors.red.shade300,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Transaction ID',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      id,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      orderDate,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Total Payments',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " Rs.${payment}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cancelOrder(id, mobileNumber, refreshCallback);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[100],
                    ),
                  ),
                  child: Text('Cancel Order', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement track order action
                  },
                  child: Text('Track Order'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
