import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CategorySlider extends StatelessWidget {
// Define your list of categories with Font Awesome icons
  final List<Category> categories = [
  Category(name: "Vegetables", icon: FontAwesomeIcons.basketShopping),
  Category(name: "Fruits", icon: FontAwesomeIcons.appleWhole),
  Category(name: "Milk", icon: FontAwesomeIcons.glassWaterDroplet),
  Category(name: "Drinks", icon: FontAwesomeIcons.mugHot),
  Category(name: "Cake", icon: FontAwesomeIcons.cakeCandles),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scroll
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30.0, // Customize the circle size
                  backgroundColor: Colors.green[400],
                  child: Icon(
                    categories[index].icon,
                    color: Colors.white, // Customize the icon color
                    size: 30.0, // Customize the icon size
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  categories[index].name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}
