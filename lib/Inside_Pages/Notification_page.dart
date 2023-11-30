import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
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
        actions: [
          IconButton(onPressed: () {

          },
      icon: const Icon(Icons.add, color: Colors.black),
          )// You can use the desired icon
        ],

      ),
      body: NotificationList(),
    );
  }
}

class NotificationList extends StatelessWidget {
  final List<NotificationItem> notifications = [
  NotificationItem(
  title: 'Order Shipped',
  message: 'Your order #123 has been shipped and will arrive at your doorstep soon. Track your order status for more details.',
  date: DateTime(2023, 11, 6),
  ),
  NotificationItem(
  title: 'Offer Alert',
  message: 'Exciting news! We have new offers available just for you. Enjoy discounts of up to 50% off on your favorite products.',
  date: DateTime(2023, 11, 1),
  ),
  NotificationItem(
  title: 'Product Review Request',
  message: 'Great news! Your order #124 has been delivered successfully. We value your feedback, please take a moment to add a review and share your experience with us.',
  date: DateTime(2023, 10, 31),
  ),
  NotificationItem(
  title: 'New Wallet Added',
  message: "We're pleased to inform you that a Paytm wallet has been added to your account. You can now make quick and secure payments using Paytm.",
  date: DateTime(2020, 10, 31),
  ),
    NotificationItem(
      title: 'Order Shipped',
      message: 'Your order #123 has been shipped and will arrive at your doorstep soon. Track your order status for more details.',
      date: DateTime(2023, 11, 01),
    ),
    NotificationItem(
      title: 'Offer Alert',
      message: 'Exciting news! We have new offers available just for you. Enjoy discounts of up to 50% off on your favorite products.',
      date: DateTime(2023, 09, 1),
    ),
    NotificationItem(
      title: 'Product Review Request',
      message: 'Great news! Your order #124 has been delivered successfully. We value your feedback, please take a moment to add a review and share your experience with us.',
      date: DateTime(2023, 10, 10),
    ),
    NotificationItem(
      title: 'New Wallet Added',
      message: "We're pleased to inform you that a Paytm wallet has been added to your account. You can now make quick and secure payments using Paytm.",
      date: DateTime(2023, 9, 13),
    ),
// ...
  ];


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: buildNotificationSections(),
    );
  }

  List<Widget> buildNotificationSections() {
    List<Widget> sections = [];

    final groupedNotifications = groupNotificationsByDate(notifications);

    final sortedGroups = groupedNotifications.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    for (var group in sortedGroups) {
      sections.add(buildDateHeader(group.key));
      sections.addAll(buildNotificationItems(group.value));
    }

    return sections;
  }

  Widget buildDateHeader(DateTime date) {
    final String formattedDate = DateFormat.yMMMd().format(date);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        formattedDate,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  List<Widget> buildNotificationItems(List<NotificationItem> items) {
    return items.map((item) {
      return ListTile(
        leading:
        // Icon(
        //   Icons.notifications, // You can use the desired notification icon
        //   color: Colors.black54, // Customize the icon color
        // ),
        CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          radius: 40,
          child: Icon(
            Icons.notifications, // Replace with the appropriate Google icon
            color: Colors.green, // Change the color to match the Google icon
            size: 38,
          ),
        ),
        title: Column( // Wrap title and subtitle in a Column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              item.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8), // Add spacing between title and subtitle
            Text(item.message),
            SizedBox(height: 10), // Add spacing between title and subtitle

          ],
        ),
      );
    }).toList();
  }

  Map<DateTime, List<NotificationItem>> groupNotificationsByDate(
      List<NotificationItem> notifications) {
    final Map<DateTime, List<NotificationItem>> grouped = {};

    for (var item in notifications) {
      final date = DateTime(item.date.year, item.date.month, item.date.day);

      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }

      grouped[date]!.add(item);
    }

    return grouped;
  }
}

class NotificationItem {
  final String title;
  final String message;
  final DateTime date;

  NotificationItem({
    required this.title,
    required this.message,
    required this.date,
  });
}

