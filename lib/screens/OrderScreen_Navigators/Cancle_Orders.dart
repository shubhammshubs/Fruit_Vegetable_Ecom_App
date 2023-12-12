//
// import 'package:flutter/material.dart';
//
// class CancleOrdersPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 600) {
//             // For larger screens, display two entries in a row
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // 2 entries in a row
//                 childAspectRatio: 1.7, // Adjust the aspect ratio as needed
//               ),
//               itemCount: _orderData.length,
//               itemBuilder: (context, index) {
//                 return
//
//
//                   CancleOrderCard(
//                     id: _orderData[index]['id']!,
//                     orderDate: _orderData[index]['orderDate']!,
//                     payment: _orderData[index]['payment']!,
//                     orderStatus: _orderData[index]['orderStatus']!,
//                   );
//
//               },
//             );
//           }
//           else {
//             // For smaller screens, use a single-column layout
//             return ListView(
//               padding: EdgeInsets.all(16),
//               children: _orderData
//                   .map(
//                     (data) => CancleOrderCard(
//                   id: data['id']!,
//                   orderDate: data['orderDate']!,
//                   payment: data['payment']!,
//                   orderStatus: data['orderStatus']!,
//                 ),
//               )
//                   .toList(),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   final _orderData = [
//     {
//       'id': 'Order #12345',
//       'orderDate': '20, Nov',
//       'payment': '499.00',
//       'orderStatus': 'Canclelled',
//     },
//     {
//       'id': 'Order #54321',
//       'orderDate': '06, Nov',
//       'payment': '1299.00',
//       'orderStatus': 'Canclelled',
//     },
//     {
//       'id': 'Order #12341',
//       'orderDate': '16, Oct',
//       'payment': '1499.00',
//       'orderStatus': 'Delivered',
//     },
//     {
//       'id': 'Order #75841',
//       'orderDate': '25, Oct',
//       'payment': '799.00',
//       'orderStatus': 'Canclelled',
//     },
//   ];
// }
//
// class CancleOrderCard extends StatelessWidget {
//   final String id;
//   final String orderDate;
//   final String payment;
//   final String orderStatus;
//
//   CancleOrderCard({
//     required this.id,
//     required this.orderDate,
//     required this.payment,
//     required this.orderStatus,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.all(8),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: orderStatus == 'Delivered'
//                       ? Colors.green.shade50
//                       : Colors.red.shade50,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Text(
//                   orderStatus,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: orderStatus == 'Delivered'
//                         ? Colors.red
//                         : Colors.red.shade300
//
//
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       'Transaction ID',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black45,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       id,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       'Order Details',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black45,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       orderDate,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       'Total Payments',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black45,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       " Rs.${payment}",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black12,
//                     width: 1), // Border decoration
//                 borderRadius: BorderRadius.circular(1), // Adjust the border radius as needed
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // SizedBox(height: 16),
//             // Divider(
//             //   color: Colors.black12,
//             //   thickness: 1,
//             // ),
//             // SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implement cancel order action
//                   },
//                   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[100])),
//                   child: Text('Leave Review',style: TextStyle(color: Colors.green),),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implement track order action
//                   },
//                   child: Text('Order Again'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'active_order_card.dart';

class CancleOrdersPage extends StatelessWidget {
  final String mobileNumber;

  CancleOrdersPage({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchOrderData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No orders found.');
        } else {
          List<Map<String, dynamic>> orderData = snapshot.data!;
          // Filter orders based on status
          List<Map<String, dynamic>> activeOrders = orderData
              .where((order) =>
          order['status'] == 'Cancelled'||
              order['status'] == 'Delivery Failed')
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

          return Scaffold(
            // appBar: AppBar(
            //   title: Text('Active Orders ${mobileNumber}'),
            // ),
            body: OrdersList(groupedOrders: groupedOrders),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchOrderData() async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readorder';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'mobile': mobileNumber},
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
  final Map<String, List<Map<String, dynamic>>> groupedOrders;

  OrdersList({required this.groupedOrders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groupedOrders.length,
      itemBuilder: (context, index) {
        String transId = groupedOrders.keys.elementAt(index);
        List<Map<String, dynamic>> orders = groupedOrders[transId]!;
        return CancleOrderCard(
          id: transId,
          orderDate: "Vegetable\n/Fruits", // You may want to change this
          payment: orders[0]['ord_price'].toString(),
          status: orders[0]['status'].toString(),
        );
      },
    );
  }
}





class CancleOrderCard extends StatelessWidget {
  final String id;
  final String orderDate;
  final String payment;
  final String status;

  CancleOrderCard({
    required this.id,
    required this.orderDate,
    required this.payment,
    required this.status,
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
                  color: status == 'Delivery Failed'
                       ? Colors.green.shade50
                      : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: status == 'Delivered'
                        ? Colors.red
                        : Colors.red.shade300
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
                    // Implement cancel order action
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[100])),
                  child: Text('Leave Review',style: TextStyle(color: Colors.green),),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement track order action
                  },
                  child: Text('Order Again'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}