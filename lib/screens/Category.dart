import 'package:ecom/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Inside_Pages/ProductListPage.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Category",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            // padding: const EdgeInsets.all(5.0),
            child: SearchBartool(),
          ),
          SizedBox(height: 30,),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 categories in each row
                crossAxisSpacing: 1.0, // Adjust as needed
                mainAxisSpacing: 16.0, // Adjust as needed
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryItem(
                  category: categories[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Define a Category class to store category data
class Category {
  final String name;
  final IconData icon;

  Category({
    required this.name,
    required this.icon,
  });
}

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to ProductListPage and pass the selected category
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListPage(category: category.name),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.green[400],
            child: Icon(
              category.icon,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Define your list of categories with Font Awesome icons
final List<Category> categories = [
  Category(name: "Vegetables", icon: FontAwesomeIcons.basketShopping),
  Category(name: "Fruits", icon: FontAwesomeIcons.appleWhole),
  Category(name: "Milk", icon: FontAwesomeIcons.glassWaterDroplet),
  Category(name: "Drinks", icon: FontAwesomeIcons.mugHot),
  Category(name: "Cake", icon: FontAwesomeIcons.cakeCandles),
  Category(name: 'Ice-Cream', icon: FontAwesomeIcons.iceCream),
  Category(name: 'Bakery', icon: FontAwesomeIcons.breadSlice),
  Category(name: 'Snacks', icon: FontAwesomeIcons.cookie),
  Category(name: 'Grain', icon: FontAwesomeIcons.breadSlice),
  Category(name: 'Cheese', icon: FontAwesomeIcons.cheese),
  Category(name: 'Household', icon: FontAwesomeIcons.houseChimney),
  Category(name: 'Pet Food', icon: FontAwesomeIcons.paw),
  Category(name: 'Dry Fruits', icon: FontAwesomeIcons.seedling),
  Category(name: 'Sugar', icon: FontAwesomeIcons.cubesStacked),
  Category(name: 'Gardening', icon: FontAwesomeIcons.pagelines),
];
