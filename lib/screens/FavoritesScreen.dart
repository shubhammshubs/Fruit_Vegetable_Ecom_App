//
//
//
// import 'package:flutter/material.dart';
// import '../APi/Product_class.dart';
// import '../Inside_Pages/Product.dart';
//
// class FavoritesScreen extends StatelessWidget {
//   final Product? product; // Make the product parameter nullable
//   final String mobileNumber;
//
//   FavoritesScreen({
//     this.product,
//     required this.mobileNumber});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Favorites',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//       ),
//       // body: ListView.builder(
//       //   itemCount: product.length,
//       //   itemBuilder: (context, index) {
//       //     // final Product product = favoriteItems[index];
//       //     return
//       //       Card(
//       //         margin: EdgeInsets.all(8.0),
//       //         child: ListTile(
//       //           leading: Image.asset(
//       //           "  product.image[0],",
//       //             width: 80,
//       //             height: 80,
//       //             fit: BoxFit.cover,
//       //           ),
//       //           title: Text("product.title"),
//       //           // subtitle: Text('Price: \Rs.${double.parse(product.price as String).toStringAsFixed(2)}'),
//       //           // trailing: Text('Quantity: ${item.quantity}'),
//       //         ),
//       //       );
//       //     //   ListTile(
//       //     //   leading: Image.asset(
//       //     //     product.image[0],
//       //     //     width: 80,
//       //     //     height: 80,
//       //     //   ),
//       //     //   title: Text(product.title),
//       //     //   subtitle: Text('Price: \$${product.price}'),
//       //     // );
//       //   },
//       // ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../APi/Category_vegitable_API.dart';
import '../APi/Product_class.dart';
import '../HomePage1.dart';
import '../Inside_Pages/Product_Details_Display_from_API.dart';
import '../User_Credentials/login_Screen.dart';

class FavoritesScreen extends StatefulWidget {
  final String mobileNumber;
  final Product? product; // Make the product parameter nullable


  FavoritesScreen({required this.mobileNumber, this.product});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favoriteItems = [];



  void navigateToProductDetails(Map<String, dynamic> productInfo) {
    final product = Product(
      id: productInfo['product_id'] ?? '',
      title: productInfo['product_title'] ?? '',
      type: productInfo['product_type'] ?? '',
      image: productInfo['product_image'] ?? '',
      price: double.tryParse('${productInfo['price'] ?? ''}') ?? 0.0,
      description: productInfo['product_desc'] ?? '',
      keywords: productInfo['product_keywords'] ?? '',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPageFromAPI(
          mobileNumber: widget.mobileNumber,
          product: product,
        ),
      ),
    );
  }
    @override
  void initState() {
    super.initState();
    // Fetch favorite items when the widget is initialized
    fetchFavoriteItems();
  }

  void fetchFavoriteItems() async {
    if (widget.mobileNumber == null || widget.mobileNumber.isEmpty) {
      // Handle case when mobile number is not provided
      return;
    }

    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readfav';

    final mobileNumber = widget.mobileNumber;

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'mobile': mobileNumber},
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final List<dynamic> data = json.decode(response.body);

      // Update the state with the favorite items
      setState(() {
        favoriteItems = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // Handle the error
      print('Failed to fetch favorite items. Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites ${widget.mobileNumber}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(mobileNumber: widget.mobileNumber),
              ),
            );

            // Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: (widget.mobileNumber == null || widget.mobileNumber.isEmpty)
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Looks like you are not signed in...'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Sign In to continue'),
            ),
          ],
        ),
      )
          : favoriteItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your favorites list is empty.'),
          ],
        ),
      )
          :
      Column(
        children: [
          Expanded(
            child:
              ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final cartItem = favoriteItems[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Container(
                        width: 50.0,
                        height: 100.0,
                        child: Image.network(
                          'https://apip.trifrnd.com/fruits/${cartItem['product_image'] ?? ''}', // Use '' or a default image URL if 'product_image' is null
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Container(
                              color: Colors.white70,
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            );
                          },
                        ),
                      ),
                      title: Text('${cartItem['product_title'] ?? ''}'), // Use '' or a default title if 'product_title' is null
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${cartItem['price'] ?? ''}', // Use '' or a default price if 'price' is null
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navigate to ProductDetailsPageFromAPI with product information
                          navigateToProductDetails(cartItem);
                        },
                        child: Text('Buy Now'),
                      ),
                    ),
                  );
                },
              ),


// ... (Your existing code)

// Function to navigate to ProductDetailsPageFromAPI with product information

          ),
        ],
      )
      // ListView.builder(
      //   itemCount: favoriteItems.length,
      //   itemBuilder: (context, index) {
      //     final favoriteItem = favoriteItems[index];
      //     return ListTile(
      //       title: Text('${favoriteItem['product_title']}'),
      //       // Add other information as needed
      //     );
      //   },
      // ),
    );
  }
}
