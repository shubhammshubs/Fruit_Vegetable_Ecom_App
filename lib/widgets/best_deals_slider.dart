import 'package:flutter/material.dart';
import '../Inside_Pages/Product.dart';
import '../Inside_Pages/product_details_pg_1.dart';
import '../Inside_Pages/product_list.dart';

class BestDealsSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace these image file names with your actual image file names
    final List<Map<String, dynamic>> bestDealImages = [
      {
        'id': 1,
        'imagePath': 'assets/images/1.png', // Image for Product 1
      },
      {
        'id': 2,
        'imagePath': 'assets/images/2.png', // Image for Product 2
      },
      {
        'id': 6,
        'imagePath': 'assets/images/6.png', // Image for Product 2
      },
      {
        'id': 7,
        'imagePath': 'assets/images/7.png', // Image for Product 2
      },
      // Add more image entries with unique ids
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bestDealImages.length,
      itemBuilder: (context, index) {
        final Map<String, dynamic> imageData = bestDealImages[index];
        final int productId = imageData['id'];

        final Product product =
        ItemsList.firstWhere((item) => item.id == productId);

        return GestureDetector(
          onTap: () {
            // Navigate to the ProductDetailsPage and pass the selected Product object
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  product: product,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 150,
                  height: 200,
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],

                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.black26,
                      width: 2.0,
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Container(
                      width: 130.0,
                      // height: 150.0,
                      decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12, // Set the border color
                        width: 1.0,          // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(10),
                  // Adjust border radius as needed
                   ),
                      child: Image.asset(
                        imageData['imagePath'], // Load the correct image path
                        width: 100.0,
                        height: 100.0,
                      ),
                  ),
                      SizedBox(height: 8.0),
                      Text(product.price,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        product.name, // Display the product name from the Product object
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),




                    ],
                  ),
                ),
                // Image.asset(
                //   imageData['imagePath'], // Load the correct image path
                //   width: 100.0,
                //   height: 100.0,
                // ),
                // SizedBox(height: 8.0),
                // Text(
                //   product.name, // Display the product name from the Product object
                //   style: TextStyle(
                //     fontSize: 16.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
