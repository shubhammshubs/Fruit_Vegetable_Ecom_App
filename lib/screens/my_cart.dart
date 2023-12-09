// // import 'package:flutter/material.dart';
// // import '../Classes/CartItem_Class.dart';
// // import '../User_Credentials/login_Screen.dart';
// //
// // class mycart extends StatelessWidget {
// //   final Cart cart;
// //
// //   mycart({required this.cart});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// // appBar: AppBar(
// // title: const Text(
// // 'Profile',
// // style: TextStyle(color: Colors.black),
// // ),
// // centerTitle: true,
// // backgroundColor: Colors.transparent,
// // elevation: 0,
// // leading: IconButton(
// // onPressed: () {
// // Navigator.pop(context);
// // },
// // icon: const Icon(Icons.arrow_back, color: Colors.black),
// // ),
// // ),
// //       body: ListView.builder(
// //         itemCount: cart.items.length,
// //         itemBuilder: (context, index) {
// //           final CartItem item = cart.items[index];
// //           final double price = double.parse(item.product.price);
// //
// //           return
// //             Card(
// //               margin: EdgeInsets.all(8.0),
// //               child: ListTile(
// //                 leading: Image.asset(
// //                   item.imagePath, // Use the provided image path
// //                   width: 80,
// //                   height: 80,
// //                   fit: BoxFit.cover,
// //                 ),
// //                 title: Text(item.product.name),
// //
// //                 subtitle: Text('Price: \Rs.${double.parse(item.product.price).toStringAsFixed(2)}',
// //                 style: TextStyle(color: Colors.green),),
// //                 trailing: Text('Quantity: ${item.quantity}'),
// //               ),
// //             );
// //
// //         },
// //       ),
// //         bottomNavigationBar: BottomAppBar(
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               Text('Total: \Rs.${cart.calculateTotal().toStringAsFixed(2)}'),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.push(context,
// //                   MaterialPageRoute(builder: (context) =>
// //                   LoginScreen(),
// //                   ));
// //                   // Add code to handle the "Place Order" action here
// //                 },
// //                 child: Text('Place Order'),
// //               ),
// //             ],
// //           ),
// //         ),
// //
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
//
// import '../User_Credentials/login_Screen.dart';
// import 'Check_Out_Screen/Delivery_Address.dart';
//
// class tempProduct {
//   final String name;
//   final double price;
//
//   tempProduct({
//     required this.name,
//     required this.price,
//   });
// }
//
// class TempCartItem {
//   final tempProduct product;
//   final int quantity;
//
//   TempCartItem({
//     required this.product,
//     required this.quantity,
//   });
// }
//
// class MyCartPage extends StatefulWidget {
//   final String? mobileNumber;
//
//   MyCartPage({Key? key, this.mobileNumber}) : super(key: key);
//   @override
//   _MyCartPageState createState() => _MyCartPageState();
// }
//
// class _MyCartPageState extends State<MyCartPage> {
//   List<TempCartItem> cartItems = [];
//
//   double get totalAmount {
//     return cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'My Cart',
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
//       body: cartItems.isEmpty
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Mobile number:- ${widget.mobileNumber}'),
//             Text('Your cart is empty.'),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement your checkout logic here
//                 // For example, you can navigate to a checkout page
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//               },
//               child: Text('Sign In to continue'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement your checkout logic here
//                 // For example, you can navigate to a checkout page
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryAddressPage()));
//               },
//               child: Text('Delivery Address'),
//             )
//           ],
//         ),
//
//       )
//           : Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 TempCartItem cartItem = cartItems[index];
//                 return ListTile(
//                   title: Text(cartItem.product.name),
//                   subtitle: Text('\$${cartItem.product.price.toStringAsFixed(2)}'),
//                   trailing: Text('Quantity: ${cartItem.quantity}'),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total: \$${totalAmount.toStringAsFixed(2)}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implement your checkout logic here
//                     // For example, you can navigate to a checkout page
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
//                   },
//                   child: Text('Checkout'),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Implement your checkout logic here
//               // For example, you can navigate to a checkout page
//               // Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
//             },
//             child: Text('Checkout'),
//           )
//         ],
//       ),
//     );
//   }
// }
//
//




// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../APi/Best_Deal_API.dart';
//
// class AddToCartPage extends StatefulWidget {
//   @override
//   _AddToCartPageState createState() => _AddToCartPageState();
// }
//
// class _AddToCartPageState extends State<AddToCartPage> {
//   List<Map<String, dynamic>> cartItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch cart items when the widget is initialized
//     fetchCartItems();
//   }
//
//   void fetchCartItems() async {
//     final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readcart';
//
//     final mobileNumber = '1111111111';
//
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'mobile': mobileNumber},
//     );
//
//     if (response.statusCode == 200) {
//       // Parse the response body
//       final List<dynamic> data = json.decode(response.body);
//
//       // Update the state with the cart items
//       setState(() {
//         cartItems = List<Map<String, dynamic>>.from(data);
//       });
//     } else {
//       // Handle the error
//       print('Failed to fetch cart items. Error: ${response.body}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Text(
//             //   'Cart Items',
//             //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             // ),
//             SizedBox(height: 16),
//             Expanded(
//               child:
//               ListView.builder(
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final cartItem = cartItems[index];
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     child:
//
//                     ListTile(
//                       title: Text('Name: ${cartItem['product_title']}'),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           Text('Product ID: ${cartItem['product_id']}'),
//                           Text('Quantity: ${cartItem['quantity']}'),
//                           Text('Price: ${cartItem['price']}'),
//                           Text('Image: ${cartItem['product_image']}'),
//                           Image.network(
//                             // ImageHelper.getProductImageUrl(product[index].image),
//                             'https://apip.trifrnd.com/fruits/Tomato.jpg',
//                                 // '${cartItem[index].image}',
//                             errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                               return Container(
//                                 color: Colors.white70,
//                                 child: Icon(
//                                   Icons.error,
//                                   color: Colors.red,
//                                 ),
//                               );
//                             },
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../APi/Product_class.dart';
import '../User_Credentials/login_Screen.dart';
import 'Check_Out_Screen/Delivery_Address.dart';

class AddToCartPage extends StatefulWidget {
  final String mobileNumber;
  final Product product;
  AddToCartPage({
    required this.mobileNumber,
    required this.product
  });
  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}
//
// class _AddToCartPageState extends State<AddToCartPage> {
//   List<Map<String, dynamic>> cartItems = [];
//
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch cart items when the widget is initialized
//     fetchCartItems();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Access inherited widgets or localization information here
//     // (e.g., Localizations.of(context), Theme.of(context), etc.)
//   }
//
//   // void fetchCartItems() async {
//   //   final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readcart';
//   //
//   //   final mobileNumber = widget.mobileNumber;
//   //
//   //   final response = await http.post(
//   //     Uri.parse(apiUrl),
//   //     headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//   //     body: {'mobile': mobileNumber},
//   //   );
//   //
//   //   if (response.statusCode == 200) {
//   //     // Parse the response body
//   //     final List<dynamic> data = json.decode(response.body);
//   //
//   //     // Update the state with the cart items
//   //     setState(() {
//   //       cartItems = List<Map<String, dynamic>>.from(data);
//   //     });
//   //   } else {
//   //     // Handle the error
//   //     print('Failed to fetch cart items. Error: ${response.body}');
//   //   }
//   // }
//   void fetchCartItems() async {
//     if (widget.mobileNumber == null || widget.mobileNumber.isEmpty) {
//       // If mobileNumber is not available, show a message and return
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Please Log In First'),
//             content: Text('Log in to view your cart.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // Navigate to the login screen or take any other action
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => LoginScreen()),
//                   // );
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }
//
//     // Continue with the API call
//     final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readcart';
//
//     final mobileNumber = widget.mobileNumber;
//
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'mobile': mobileNumber},
//     );
//
//     if (response.statusCode == 200) {
//       // Parse the response body
//       final List<dynamic> data = json.decode(response.body);
//
//       // Update the state with the cart items
//       setState(() {
//         cartItems = List<Map<String, dynamic>>.from(data);
//       });
//     } else {
//       // Handle the error
//       print('Failed to fetch cart items. Error: ${response.body}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart ${widget.mobileNumber}'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final cartItem = cartItems[index];
//
//                   // Print the image URL to the console
//                   // print('Image URL: ${cartItem['product_image']}');
//
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                         leading:
//                         Container(
//                             width: 50.0, // Set a suitable width for the image
//                             height: 100.0, // Set a suitable height for the image
//                             child:
//                             Image.network(
//                               'https://apip.trifrnd.com/fruits/${cartItem['product_image']}',
//                               errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                                 return Container(
//                                   color: Colors.white70,
//                                   child: Icon(
//                                     Icons.error,
//                                     color: Colors.red,
//                                   ),
//                                 );
//                               },
//                             ),
//                             // CachedNetworkImage(
//                             //   imageUrl: ImageHelper.getProductImageUrl(products[index].image),
//                             //   // width: containerWidth,
//                             //   // height: containerHeight,
//                             //   fit: BoxFit.contain,
//                             //   errorWidget: (BuildContext context, String url, dynamic error) {
//                             //     return Container(
//                             //       color: Colors.white70,
//                             //       child: Icon(
//                             //         Icons.error,
//                             //         color: Colors.red,
//                             //       ),
//                             //     );
//                             //
//                             //   },
//                             //   cacheManager: DefaultCacheManager(),
//                             //
//                             // )
//
//                           // Image.network(
//                           //   ImageHelper.getProductImageUrl(products[index].image),
//                           //   // 'https://apip.trifrnd.com/fruits/${products[index].image}',
//                           //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                           //     return Container(
//                           //       color: Colors.white70,
//                           //       child: Icon(
//                           //         Icons.error,
//                           //         color: Colors.red,
//                           //       ),
//                           //     );
//                           //   },
//                           // ),
//                         ),
//                       title: Text('${cartItem['product_title']}'),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Text('Product ID: ${cartItem['product_id']}'),
//                           // Text('Quantity: ${cartItem['quantity']}'),
//                           // Text('Price: ${cartItem[index].price.toStringAsFixed(2)}',
//                           //   style: TextStyle(
//                           //     fontSize: 12.0,
//                           //     fontWeight: FontWeight.bold,
//                           //     color: Colors.green, // Price text color
//                           //   ),),
//                           Text('Price: ${cartItem['price']}',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green, // Price text color
//                             ),),
//                           SizedBox(height: 10,),
//                           // Text('Image: ${cartItem['product_image']}'),
//                           // Image.network(
//                           //   'https://apip.trifrnd.com/fruits/${cartItem['product_image']}',
//                           //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                           //     return Container(
//                           //       color: Colors.white70,
//                           //       child: Icon(
//                           //         Icons.error,
//                           //         color: Colors.red,
//                           //       ),
//                           //     );
//                           //   },
//                           // ),
//                         ],
//                       ),
//                         trailing: Text('Quantity: \n      ${cartItem['quantity']}'),
//
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _AddToCartPageState extends State<AddToCartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    // Fetch cart items when the widget is initialized
    fetchCartItems();
  }

  void fetchCartItems() async {
    // ... (your existing code)

    if (widget.mobileNumber == null || widget.mobileNumber.isEmpty) {
      // ... (your existing code for showing the login dialog)
      return;
    }

    // Continue with the API call
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readcart';

    final mobileNumber = widget.mobileNumber;

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'mobile': mobileNumber},
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final List<dynamic> data = json.decode(response.body);

      // Update the state with the cart items
      setState(() {
        cartItems = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // Handle the error
      print('Failed to fetch cart items. Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'My Cart ${widget.mobileNumber}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mobile number: ${widget.mobileNumber}'),
            Text('Your cart is empty.'),
            ElevatedButton(
              onPressed: () {
                // Implement your checkout logic here
                // For example, you can navigate to a checkout page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(product: widget.product)),
                );
              },
              child: Text('Sign In to continue'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Implement your checkout logic here
            //     // For example, you can navigate to a checkout page
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => DeliveryAddressPage()),
            //     // );
            //   },
            //   child: Text('Delivery Address'),
            // )
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 100.0,
                      child: Image.network(
                        'https://apip.trifrnd.com/fruits/${cartItem['product_image']}',
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
                    title: Text('${cartItem['product_title']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${cartItem['price']}',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                    trailing: Text('Quantity: \n      ${cartItem['quantity']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
