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

// class _FavoritesPageState extends State<FavoritesScreen>
//     with SingleTickerProviderStateMixin {
//   List<Map<String, dynamic>> favoriteItems = [];
//   late AnimationController _dismissController = AnimationController(
//     vsync: this,
//     duration: Duration(seconds: 5),
//   );
//
//   late final Animation<Offset> _offsetAnimation = Tween<Offset>(
//     begin: const Offset(0, 0),
//     end: Offset(1, 0),
//   ).animate(
//     CurvedAnimation(parent: _dismissController, curve: Curves.ease),
//   );
//
//   @override
//   void dispose() {
//     _dismissController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Add a listener to detect when the animation completes
//     _dismissController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         // Animation has completed, delay for 2 seconds and then dispose the controller
//         Future.delayed(Duration(seconds: 2), () {
//           _dismissController.dispose();
//         });
//       }
//     });
//
//     // Start the animation
//     _dismissController.forward();
//     fetchFavoriteItems();
//   }
class _FavoritesPageState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> favoriteItems = [];
  late AnimationController _animationController;
  // late Animation<Offset> _enterAnimation;
  late Animation<Offset> _exitAnimation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _exitAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    // Add a listener to detect when the animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });

    // _animationController.forward();

    // Fetch favorite items when the widget is initialized
    fetchFavoriteItems();
    // Delay the animation start by 1 second
    Future.delayed(Duration(seconds: 2), () {
      _animationController.forward();
    });
  }




  // bool showTutorial = true; // Initially show the tutorial

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
  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch favorite items when the widget is initialized
  //   fetchFavoriteItems();
  //   // _dismissController = AnimationController(
  //   //   vsync: this,
  //   //   duration: Duration(seconds: 2),
  //   // );
  //   // Set showTutorial to true initially
  //
  // }


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
      final dynamic data = json.decode(response.body);

      // Check if the data is a List<dynamic>
      if (data is List<dynamic>) {
        // Update the state with the cart items
        setState(() {
          favoriteItems = List<Map<String, dynamic>>.from(data);
        });
      } else {
        print('No Data in FavoriteScreen: $data');
        // Handle the error appropriately, e.g., show a message to the user
      }
    } else {
      // Handle the error
      print('Failed to fetch cart items. Error: ${response.body}');
    }
  }
  //   if (response.statusCode == 200) {
  //     // Parse the response body
  //     final List<dynamic> data = json.decode(response.body);
  //
  //     // Update the state with the favorite items
  //     setState(() {
  //       favoriteItems = List<Map<String, dynamic>>.from(data);
  //     });
  //   } else {
  //     // Handle the error
  //     print('Failed to fetch favorite items. Error: ${response.body}');
  //   }
  // }

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
            child: ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final cartItem = favoriteItems[index];
                return Stack(

                  children: [

                  Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.bottomLeft, // Center the content vertically
                    padding: EdgeInsets.only(left: 14.0, bottom: 45), // Adjusted for alignment left
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),

                    for (int i = 0; i < 2; i++)
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: i == 0 ? const Offset(0, 0) : const Offset(0.15, 0),  // Start from the zero position or half left
                          end: i == 0 ? const Offset(0.15, 0) : const Offset(0, 0),   // Move to half right or end at the zero position
                        ).animate(_animationController),
                        child: i == 0
                            ? Dismissible(
                          key: Key(cartItem['product_id'].toString()),
                          onDismissed: (direction) {
                            removeFromFavorites(cartItem);
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(right: 14.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Container(
                                width: 50.0,
                                height: 100.0,
                                child: Image.network(
                                  'https://apip.trifrnd.com/fruits/${cartItem['product_image'] ?? ''}',
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
                              title: Text('${cartItem['product_title'] ?? ''}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${cartItem['price'] ?? ''}',
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
                                  navigateToProductDetails(cartItem);
                                },
                                child: Text('Buy Now'),
                              ),
                            ),
                          ),
                        )
                            : Container(),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      )

    );
  }

  void removeFromFavorites(Map<String, dynamic> productInfo) async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=remfav';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'mobile': widget.mobileNumber,
        'product_id': productInfo['product_id'] ?? '',
        'product_title': productInfo['product_title'] ?? '',
        'product_image': productInfo['product_image'] ?? '',
        'price': productInfo['price'] ?? '',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        favoriteItems.remove(productInfo);
      });
      print(response.body);
    } else {
      // Handle the error
      print('Failed to remove from favorites. Error: ${response.body}');
    }
  }
}
