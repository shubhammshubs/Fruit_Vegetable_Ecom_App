import 'package:flutter/material.dart';

import '../widgets/best_deals_slider.dart';

class ProductListPage extends StatelessWidget {
  final String category;



  // Constructor to receive the selected category
  ProductListPage({
    required this.category,

    });


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

        title: Text(
          '${category}',
          style: TextStyle(color: Colors.black,),

        ),

      ),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(products[index].name),
                subtitle: Text('Price: \Rs${products[index].price.toStringAsFixed(2)}'),
                // Add more product details as needed
              ),
              Container(
                height: 1.0,            // Height of the line
                color: Colors.black,    // Color of the line
                margin: const EdgeInsets.symmetric(vertical: 10.0),
              ),

            ],

          );
        },

      ),
    );
  }
}

// Define a Product class to represent individual products
class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}


// Sample list of products
final List<Product> products = [
  Product(name: "Product 1", price: 100),
  Product(name: "Product 2", price: 15),
  Product(name: "Product 3", price: 80),
  Product(name: "Product 4", price: 100),
  Product(name: "Product 5", price: 150),
  Product(name: "Product 6", price: 80),
  Product(name: "Product 7", price: 1200),
  Product(name: "Product 8", price: 112),
  Product(name: "Product 9", price: 199),
  Product(name: "Product 10", price: 149),
  Product(name: "Product 11", price: 15),
  Product(name: "Product 12", price: 79),
  Product(name: "Product 13", price: 112),
  Product(name: "Product 14", price: 99),
  Product(name: "Product 15", price: 80),
  Product(name: "Product 16", price: 100),
  Product(name: "Product 17", price: 150),
  Product(name: "Product 18", price: 80),
];
