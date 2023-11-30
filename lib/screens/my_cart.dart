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
// import 'package:flutter/material.dart';
// // import '../Classes/CartItem_Class.dart';
// import '../User_Credentials/login_Screen.dart';
//
// class MyCart extends StatefulWidget {
//   final Cart cart;
//
//   MyCart({required this.cart});
//
//   @override
//   _MyCartState createState() => _MyCartState();
// }
//
//
// class _MyCartState extends State<MyCart> {
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
//       body: ListView.builder(
//         itemCount: widget.cart.items.length,
//         itemBuilder: (context, index) {
//           final CartItem item = widget.cart.items[index];
//
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               leading: Image.asset(
//                 item.imagePath,
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//               ),
//               title: Text(item.product.name),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Price: \$${double.parse(item.product.price).toStringAsFixed(2)}',
//                     style: TextStyle(color: Colors.green),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.remove),
//                         onPressed: () {
//                           setState(() {
//                             if (item.quantity > 1) {
//                               item.quantity--; // Decrement the item's quantity
//                             }
//                           });
//                         },
//                       ),
//                       Text('${item.quantity}'),
//                       IconButton(
//                         icon: Icon(Icons.add),
//                         onPressed: () {
//                           setState(() {
//                             item.quantity++; // Increment the item's quantity
//                           });
//                         },
//                       ),
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text('Total: \$${widget.cart.calculateTotal().toStringAsFixed(2)}'),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => LoginScreen(),
//                   ),
//                 );
//                 // Add code to handle the "Place Order" action here
//               },
//               child: Text('Place Order'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
