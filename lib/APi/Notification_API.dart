import 'package:http/http.dart' as http;
import 'dart:convert';
// This code is for the Display the list of notification from the api to the notification Page.
class NotificationApiHandler {
  static Future<List<Map<String, dynamic>>> fetchNotificationData(String mobile) async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readorder';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'mobile': mobile},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:awesome_notifications/awesome_notifications.dart';
//
// class NotificationApiHandler {
//   static Future<List<Map<String, dynamic>>> fetchNotificationData(String mobile) async {
//     final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readnote';
//
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'mobile': mobile},
//     );
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       List<Map<String, dynamic>> notificationData = List<Map<String, dynamic>>.from(data);
//
//       // Notify for each new entry
//       notifyNewEntries(notificationData);
//
//       return notificationData;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   static void notifyNewEntries(List<Map<String, dynamic>> entries) {
//     for (var entry in entries) {
//       // Customize notification content based on your API response structure
//       String status = entry['status'];
//       String orderMessage = '';
//
//       if (status == 'Cancelled') {
//         orderMessage = 'Your order for id ${entry['trans_id']} has been Canceled.';
//       } else if (status == 'Order Placed') {
//         orderMessage = 'Your order for id ${entry['trans_id']} has been Placed Successfully.';
//       } else if (status == 'Delivered') {
//         orderMessage = 'Your order for id ${entry['trans_id']} has been Delivered Successfully.';
//       } else if (status == 'Delivery Failed') {
//         orderMessage = 'Delivery Failed for order id ${entry['trans_id']}.';
//       }
//
//       // Create notification
//       // AwesomeNotifications().createNotification(
//       //   content: NotificationContent(
//       //     id: DateTime.now().millisecondsSinceEpoch,
//       //     channelKey: 'basic_channel',
//       //     title: status,
//       //     body: orderMessage,
//       //   ),
//       // );
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 1,
//           channelKey: "Basic_channel",
//           title: status,
//           body: orderMessage,
//         ),
//
//       );
//     }
//   }
// }



// This is for the Dispaly the count on the Home Screen
class NotificationCountApi {
  final String mobileNumber;

  NotificationCountApi({required this.mobileNumber});

  Future<int> fetchNotificationCount() async {
    try {
      final response = await http.post(
        Uri.parse('https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readorder'),
        body: {'mobile': mobileNumber}, // Add mobile number to the request body
      );

      // print('API Response: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the response JSON
        final List<dynamic> notifications = json.decode(response.body);
        // print('Notifications: $notifications');

        // Count the number of "unread" notifications
        final int unreadCount = notifications
            .where((notification) =>
        notification is Map<String, dynamic> &&
            notification['notification'] == 'unread')
            .length;

        return unreadCount;
      } else {
        // Handle the error
        // print('Error fetching notification count: ${response.statusCode}');
        return 0; // Return 0 in case of an error
      }
    } catch (e) {
      // Handle other errors
      print('Error fetching notification count: $e');
      return 0; // Return 0 in case of an error
    }
  }
}
