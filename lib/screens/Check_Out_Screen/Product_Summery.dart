import 'package:ecom/HomePage1.dart';
import 'package:flutter/material.dart';

import '../my_cart.dart';

class OrderReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Summary'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Text(
                '35% OFF',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // Add a container to provide space for the image
                    width: 80, // Adjust the width as needed
                    height: 80, // Adjust the height as needed
                    child: Image.asset(
                      'assets/images/1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16), // Add some space between the image and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fresh Strawberry', style: TextStyle(fontSize: 18)),
                      Text('1 kg'),
                    ],
                  ),
                ],
              ),
              Divider(thickness: 0.1,),
              // SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // Add a container to provide space for the image
                    width: 80, // Adjust the width as needed
                    height: 80, // Adjust the height as needed
                    child: Image.asset(
                      'assets/images/2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16), // Add some space between the image and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fresh Orange', style: TextStyle(fontSize: 18)),
                      Text('1 kg'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Date'),
                  Text('Sep 18, 2023 | 10:00 AM'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Promo code'),
                  Text('@insightlan'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expected Delivery Date'),
                  Text('Sep 19, 2023'),
                ],
              ),
              Divider(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total'),
                  Text('\$20.00'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount'),
                  Text('\$5.00'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax'),
                  Text('\$0.00'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Charge'),
                  Text('\$5.00'),
                ],
              ),
              SizedBox(height: 16),

              Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Paytm'),
                  ),
                  Text('Change ',style: TextStyle(color: Colors.green),),
                ],
              ),
              SizedBox(height: 16),


            ],
          ),

        ),

      ),
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            onPressed: () {
              // Button logic
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(mobileNumber: '',)));
              final snackBar = SnackBar(
                content: Text('  Order is Successful ', textAlign: TextAlign.center),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            child: Text(
              'Confirm Payment',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
    );
  }
}
