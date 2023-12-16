import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
// import 'HomePage.dart';
import 'Inside_Pages/Notification_page.dart';
import 'SplashScreen.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,

  );

  await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: "basic_channel_group",
            channelKey: "Basic_channel",
            channelName: " Basic_notification",
            channelDescription: "Test_Notification_channel")
      ],
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: "basic_channel_group",
            channelGroupName: "basic group")
      ]
  );
  bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }



  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/notification-page', page: () => SplashScreen()),
    ],
    home: SplashScreen(),
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
    );
  }
}