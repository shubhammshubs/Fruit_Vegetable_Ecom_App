import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the image slider widget here
    return Container(
      child: CarouselSlider(
        items: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12, // Set the border color
                width: 1.0,          // Set the border width
              ),
              borderRadius: BorderRadius.circular(20),
              // Adjust border radius as needed
            ),
            child: Image.asset('assets/images/1.png'), // Image 1
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12, // Set the border color
                width: 1.0,            // Set the border width
              ),
              borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
            ),
            child: Image.asset('assets/images/2.png'), // Image 2
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12, // Set the border color
                width: 1.0,            // Set the border width
              ),
              borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
            ),
            child: Image.asset('assets/images/3.png'), // Image 3
          ),
        ],
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
      ),
    );
  }
}
