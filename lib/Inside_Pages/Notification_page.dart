// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class NotificationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Notification',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//         actions: [
//           IconButton(onPressed: () {
//
//           },
//       icon: const Icon(Icons.add, color: Colors.black),
//           )// You can use the desired icon
//         ],
//
//       ),
//       body: NotificationList(),
//     );
//   }
// }
//
// class NotificationList extends StatelessWidget {
//   final List<NotificationItem> notifications = [
//   NotificationItem(
//   title: 'Order Shipped',
//   message: 'Your order #123 has been shipped and will arrive at your doorstep soon. Track your order status for more details.',
//   date: DateTime(2023, 11, 6),
//   ),
//   NotificationItem(
//   title: 'Offer Alert',
//   message: 'Exciting news! We have new offers available just for you. Enjoy discounts of up to 50% off on your favorite products.',
//   date: DateTime(2023, 11, 1),
//   ),
//   NotificationItem(
//   title: 'Product Review Request',
//   message: 'Great news! Your order #124 has been delivered successfully. We value your feedback, please take a moment to add a review and share your experience with us.',
//   date: DateTime(2023, 10, 31),
//   ),
//   NotificationItem(
//   title: 'New Wallet Added',
//   message: "We're pleased to inform you that a Paytm wallet has been added to your account. You can now make quick and secure payments using Paytm.",
//   date: DateTime(2020, 10, 31),
//   ),
//     NotificationItem(
//       title: 'Order Shipped',
//       message: 'Your order #123 has been shipped and will arrive at your doorstep soon. Track your order status for more details.',
//       date: DateTime(2023, 11, 01),
//     ),
//     NotificationItem(
//       title: 'Offer Alert',
//       message: 'Exciting news! We have new offers available just for you. Enjoy discounts of up to 50% off on your favorite products.',
//       date: DateTime(2023, 09, 1),
//     ),
//     NotificationItem(
//       title: 'Product Review Request',
//       message: 'Great news! Your order #124 has been delivered successfully. We value your feedback, please take a moment to add a review and share your experience with us.',
//       date: DateTime(2023, 10, 10),
//     ),
//     NotificationItem(
//       title: 'New Wallet Added',
//       message: "We're pleased to inform you that a Paytm wallet has been added to your account. You can now make quick and secure payments using Paytm.",
//       date: DateTime(2023, 9, 13),
//     ),
// // ...
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: buildNotificationSections(),
//     );
//   }
//
//   List<Widget> buildNotificationSections() {
//     List<Widget> sections = [];
//
//     final groupedNotifications = groupNotificationsByDate(notifications);
//
//     final sortedGroups = groupedNotifications.entries.toList()
//       ..sort((a, b) => b.key.compareTo(a.key));
//
//     for (var group in sortedGroups) {
//       sections.add(buildDateHeader(group.key));
//       sections.addAll(buildNotificationItems(group.value));
//     }
//
//     return sections;
//   }
//
//   Widget buildDateHeader(DateTime date) {
//     final String formattedDate = DateFormat.yMMMd().format(date);
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         formattedDate,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }
//
//   List<Widget> buildNotificationItems(List<NotificationItem> items) {
//     return items.map((item) {
//       return ListTile(
//         leading:
//         // Icon(
//         //   Icons.notifications, // You can use the desired notification icon
//         //   color: Colors.black54, // Customize the icon color
//         // ),
//         CircleAvatar(
//           backgroundColor: Colors.grey.shade100,
//           radius: 40,
//           child: Icon(
//             Icons.notifications, // Replace with the appropriate Google icon
//             color: Colors.green, // Change the color to match the Google icon
//             size: 38,
//           ),
//         ),
//         title: Column( // Wrap title and subtitle in a Column
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Text(
//               item.title,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8), // Add spacing between title and subtitle
//             Text(item.message),
//             SizedBox(height: 10), // Add spacing between title and subtitle
//
//           ],
//         ),
//       );
//     }).toList();
//   }
//
//   Map<DateTime, List<NotificationItem>> groupNotificationsByDate(
//       List<NotificationItem> notifications) {
//     final Map<DateTime, List<NotificationItem>> grouped = {};
//
//     for (var item in notifications) {
//       final date = DateTime(item.date.year, item.date.month, item.date.day);
//
//       if (!grouped.containsKey(date)) {
//         grouped[date] = [];
//       }
//
//       grouped[date]!.add(item);
//     }
//
//     return grouped;
//   }
// }
//
// class NotificationItem {
//   final String title;
//   final String message;
//   final DateTime date;
//
//   NotificationItem({
//     required this.title,
//     required this.message,
//     required this.date,
//   });
// }
//


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import '../APi/Notification_API.dart';

class NotificationPage extends StatefulWidget {
  final String mobileNumber;

  const NotificationPage({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<Map<String, dynamic>>> _data;

  @override
  void initState() {
    super.initState();
    // _data = fetchNotificationData(widget.mobileNumber);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: NotificationApiHandler.fetchNotificationData(widget.mobileNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('You Have No New Notification.'));
          } else {
            // final List<Map<String, dynamic>> data = snapshot.data!;
            List<Map<String, dynamic>> data = snapshot.data!;
            data.sort((a, b) => DateTime.parse(b['ord_date']).compareTo(DateTime.parse(a['ord_date'])));




            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                // Parse the date
                DateTime orderDate = DateTime.parse(item['ord_date']);
                String formattedDate = DateFormat.yMMMd().format(orderDate);

                // Check if it's a new date, and display it only once
                if (index == 0 || formattedDate != DateFormat.yMMMd().format(DateTime.parse(data[index - 1]['ord_date']))) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildNotificationItem(item),
                    ],
                  );
                } else {
                  return buildNotificationItem(item);
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget buildNotificationItem(Map<String, dynamic> item) {
    String status = item['status'];
    String orderMessage = '';

    if (status == 'Cancelled') {
      orderMessage = 'Your order for id ${item['trans_id']} has been Canceled.';
    } else if (status == 'Order Placed') {
      orderMessage = 'Your order for id ${item['trans_id']} has been Placed Successfully. It will soon be Dispatched.';
    } else if (status == 'Delivered') {
      orderMessage =
      'Your order for id ${item['trans_id']} has been Delivered Successfully.';
    } else if (status == 'Delivery Failed') {
      orderMessage =
      'Delivery Failed for order id ${item['trans_id']}.';
    }

    return GestureDetector(
      onTap: () {
        // Handle the tap event here, for example, navigate to a new screen
        fetchAdditionalNotificationData(item['trans_id']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0), // Remove ListTile's default padding
              leading: Icon(
                Icons.notifications,
                color: Colors.green,
                size: 30,
              ),
              title: Text(
                status,
                style: TextStyle(fontWeight: FontWeight.bold,
                  color: (status == 'Cancelled' || status == 'Delivery Failed') ? Colors.red : Colors.green,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Order ID: ${item['trans_id']}',
                  //   style: TextStyle(color: Colors.grey),
                  // ),
                  if (orderMessage.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        orderMessage,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: status == 'Cancelled' ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchAdditionalNotificationData(String transId) async {
    try {
      final response = await http.post(
        Uri.parse('https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=notify'),
        body: {'mobile': widget.mobileNumber, 'trans_id': transId},
      );

      print('API Response: ${response.body}'); // Print the response for debugging

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'The Id $transId is Read',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Check if the response is the expected "Done" string
        if (response.body == 'Done') {
          // Show a message or perform actions accordingly

          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return AlertDialog(
          //       title: Text('Additional Notification Data'),
          //       content: Text('The API response is "Done".'),
          //       actions: [
          //         TextButton(
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //           child: Text('Close'),
          //         ),
          //       ],
          //     );
          //   },
          // );
        } else {
          // Handle the case where the response is not as expected
          print('Unexpected response: ${response.body}');
        }
      } else {
        // Handle the error
        print('Error fetching additional notification data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error fetching additional notification data: $e');
    }
  }
}

