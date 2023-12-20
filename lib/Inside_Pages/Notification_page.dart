

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import '../APi/Notification_API.dart';
import '../HomePage1.dart';

class NotificationPage extends StatefulWidget {
  final String mobileNumber;

  const NotificationPage({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<Map<String, dynamic>>> _data;
  Set<String> readItemIds = {}; // Keep track of read items

  @override
  void initState() {
    super.initState();
    _data = NotificationApiHandler.fetchNotificationData(widget.mobileNumber);
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
            Navigator.pop(context, true);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomePage(mobileNumber: widget.mobileNumber)),
            // );
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
            data.sort((a, b) => DateTime.parse(b['dated']).compareTo(DateTime.parse(a['dated'])));




            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                // Parse the date
                DateTime orderDate = DateTime.parse(item['dated']);
                String formattedDate = DateFormat.yMMMd().format(orderDate);

                // Check if it's a new date, and display it only once
                if (index == 0 || formattedDate != DateFormat.yMMMd().format(DateTime.parse(data[index - 1]['dated']))) {
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
    bool isUnread = item['notification'] == 'unread';
    String transId = item['trans_id'];
    bool isUnreadid = !readItemIds.contains(transId); // Check if the item is unread

    if (status == 'Cancelled') {
      orderMessage = 'Your order for id ${item['trans_id']} has been Canceled.';
    } else if (status == 'Order Placed') {
      orderMessage = 'Your order for id ${item['trans_id']} has been Placed Successfully. It will soon be Dispatched.';
    } else if (status == 'Delivered') {
      orderMessage = 'Your order for id ${item['trans_id']} has been Delivered Successfully.';
    } else if (status == 'Delivery Failed') {
      orderMessage = 'Delivery Failed for order id ${item['trans_id']}.';
    }


    return InkWell(
      onTap: () {
        // Handle the tap event if needed
      },
      onLongPress: () {
        // Handle the long press event here
        // Fetch additional data or perform other actions
        fetchAdditionalNotificationData(item['trans_id']);
        // Update the set of read items and rebuild the widget
        setState(() {
          readItemIds.add(item['trans_id']);
        });
        // Show the notification details dialog
        showNotificationDetailsDialog(context, status, orderMessage);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Ink(
          decoration: BoxDecoration(
            color: isUnread ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(0), // Remove ListTile's default padding
            leading: CircleAvatar(
              backgroundColor: isUnread ? Colors.transparent : Colors.grey.shade100,
              radius: 40,
              child: Icon(
                Icons.notifications,
                color: Colors.green,
                size: 38,
              ),
            ),
            title: Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: (status == 'Cancelled' || status == 'Delivery Failed') ? Colors.red : Colors.green,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (orderMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      orderMessage,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
      }

// Method to show a dialog with additional details
  void showNotificationDetailsDialog(BuildContext context, String status, String orderMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Status: $status'),
              if (orderMessage.isNotEmpty) Text('Message: $orderMessage'),
            ],
          ),
        );
      },
    );
  }// ... (your existing code)

  Future<void> fetchAdditionalNotificationData(String transId) async {
    try {
      final response = await http.post(
        Uri.parse('https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=notify'),
        body: {
          'mobile': widget.mobileNumber,
          'trans_id': transId
        },
      );

      print('API Response: ${response.body}'); // Print the response for debugging

      if (response.statusCode == 200) {

        // setState(() {
        //   readItemIds.remove(transId);
        // });
        // Fluttertoast.showToast(
        //   msg: 'The Id $transId is Read',
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.green,
        //   textColor: Colors.white,
        // );
        // Check if the response is the expected "Done" string
        if (response.body == 'Done') {
          // Show a message or perform actions accordingly

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

