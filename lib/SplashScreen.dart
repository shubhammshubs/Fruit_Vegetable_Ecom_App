import 'package:ecom/HomePage1.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds, then navigate to the HomePage
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,// Change to your desired background color
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/image/splashscreen.png'), // Replace with your image asset
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // Image.asset('assets/image/img.png', width: 100.0), // Replace with your logo image
            SizedBox(height: 20.0),
            Icon(Icons.local_grocery_store_outlined,
              color: Colors.white,
              size: 200,),
            Text(
              'Welcome to Grocery App',

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white, // Change to your desired text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//
// import 'package:ecom/HomePage1.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'User_Credentials/login_Screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     checkUserLogin();
//   }
//
//   Future<void> checkUserLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? mobileNumber = prefs.getString('mobileNumber');
//
//     // Add a delay for 2 seconds
//     await Future.delayed(Duration(seconds: 2));
//
//     if (mobileNumber != null && mobileNumber.isNotEmpty) {
//       // User is logged in, navigate to main page
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     } else {
//       // User is not logged in, navigate to login page or any other page
//       // Replace '/loginPage' with your actual login page route or widget
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.green, // Change to your desired background color
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               Icons.local_grocery_store_outlined,
//               color: Colors.white,
//               size: 200,
//             ),
//             Text(
//               'Welcome to Grocery App',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20.0,
//                 color: Colors.white, // Change to your desired text color
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
