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
