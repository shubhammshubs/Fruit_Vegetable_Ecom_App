import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../APi/Display_User_info_API.dart';
import '../APi/Notification_API.dart';
import '../Inside_Pages/Notification_page.dart';
import '../widgets/best_deals_slider.dart';
import '../widgets/category_slider.dart';
import '../widgets/image_slider.dart';
import '../widgets/popular_items_slider.dart';
import '../widgets/search_bar.dart';
import 'Category.dart';


class HomeScreen extends StatefulWidget {
  final String mobileNumber;

  HomeScreen({required this.mobileNumber});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? addressInfo;
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    // Fetch user information and notification count when the screen is initialized
    fetchUserInfo();
    fetchNotificationCount();
  }

  Future<void> fetchNotificationCount() async {
    try {
      final notificationApi = NotificationCountApi(mobileNumber: widget.mobileNumber);
      final count = await notificationApi.fetchNotificationCount();

      setState(() {
        notificationCount = count;
      });
      print('Notification Count: $notificationCount');
    } catch (e) {
      // Handle other errors
      print('Error fetching notification count: $e');
    }
  }

  Future<void> fetchUserInfo() async {
    try {
      final data = await ApiServiceaddress.fetchUserInfo(widget.mobileNumber);
      setState(() {
        addressInfo = data;
      });
    } catch (e) {
      // Handle the error, e.g., show an error message
      print('Error fetching user information: $e');
    }
  }

  // final String mobileNumber;
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear the stored data
    prefs.remove('isLoggedIn');
    prefs.remove('mobileNumber');

    // Navigate to the login screen
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => HomeScreen(mobileNumber: ''),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   // leading: const BackButton(
      //   //   color: Colors.black,),
      //
      //   title: const Text("Grocery App",
      //     style: TextStyle(color: Colors.black),),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // User's Location
         Padding(
        padding: EdgeInsets.all(16.0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26,),
                Text("mobile:  ${widget.mobileNumber}"),
                Text('Location',
                  style: TextStyle(color: Colors.black54,
                    fontFamily: "NexaRegular",
                  ),),
                SizedBox(height: 6,),
                Row(
                  children: [
                    Icon(Icons.location_on,color: Colors.green,),
           Text(
             addressInfo != null &&
                 addressInfo!.containsKey('address') &&
                 addressInfo!['address'] != null &&
                 addressInfo!['address'].isNotEmpty
                 ? '${addressInfo!['city']}, ${addressInfo!['state']}'
                 : '',
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 18.0,
             ),
           ),
                  ],
                ),

              ],
            ),
            IconButton(
              key: ValueKey(notificationCount),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(
                      mobileNumber: widget.mobileNumber,
                    ),
                  ),
                );
              },
              icon: Stack(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 30,
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      top: 1,  // Adjust the top value to move the count slightly up
                      right: 2,  // Adjust the right value to position it correctly
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$notificationCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),



            // IconButton(
            //   onPressed: () {
            //     // Your notification action
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => NotificationPage(
            //         mobileNumber: widget.mobileNumber,
            //       ))
            //     );
            //   },
            //   icon: Icon(
            //
            //     Icons.notifications,
            //     color: Colors.black,
            //   ),
            //   iconSize: 25,
            // ),

            // Icon(Icons.ice_skating),
          ],
        ),
      ),

            Container(
              // height: 200.0, // Set a suitable height
              child: SearchBartool(),
            ),

            SizedBox(height: 25,),
            // Text('Mobile: $mobileNumber'),

            // -----------------------------Image slider Code-------------------------------

            Container(
                child:
                PopularItems1Slider(productCategory: 'Vegetable', mobileNumber: widget.mobileNumber,),
                // ImageSlider(),
            ),
            // -----------------------------Image slider Category Section Code-------------------------------
            SizedBox(height: 25,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Category',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontFamily: "NexaRegular",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(mobileNumber: widget.mobileNumber,), // Use your CategoryPage widget
                          ),
                        );
                      },
                      child:  Text(
                        'See All  ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green, // Customize the button text color
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6,),
                //==================Fetched this Category items from Category page===============================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 120.0,
                      child: CategoryItem(category:
                      categories[0], mobileNumber: widget.mobileNumber,), // Display the first category
                    ),
                    // SizedBox(width: 4,),
                    Container(
                      height: 120.0,
                      child: CategoryItem(category:
                      categories[1], mobileNumber: widget.mobileNumber,), // Display the first category
                    ),
                  ],
                ),


              ],
            )
,
            // -----------------------------Best Deal code-------------------------------

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('  Best Deal',
                  style: TextStyle(fontSize: 25,color: Colors.black,
                    fontFamily: "NexaRegular",
                  ),
                ),
                SizedBox(height: 6,),
                Container(
                  height: 250.0, // Set a suitable height
                  child:
                  // BestDealsSlider(productCategory: 'Vegetable',),
                  BestDealsSlider(mobileNumber: widget.mobileNumber,),
                ),
              ],
            ),
            // -----------------------------Popular Item code-------------------------------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  Popular Item',
                  style: TextStyle(fontSize: 25,color: Colors.black,
                    fontFamily: "NexaRegular",
                  ),
                ),
                SizedBox(height: 6,),
                Container(
                  height: 250.0, // Set a suitable height
                  child: PopularItemsSlider(mobileNumber: widget.mobileNumber,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
