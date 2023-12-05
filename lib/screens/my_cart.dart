// import 'package:flutter/material.dart';
// import '../Classes/CartItem_Class.dart';
// import '../User_Credentials/login_Screen.dart';
//
// class mycart extends StatelessWidget {
//   final Cart cart;
//
//   mycart({required this.cart});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// appBar: AppBar(
// title: const Text(
// 'Profile',
// style: TextStyle(color: Colors.black),
// ),
// centerTitle: true,
// backgroundColor: Colors.transparent,
// elevation: 0,
// leading: IconButton(
// onPressed: () {
// Navigator.pop(context);
// },
// icon: const Icon(Icons.arrow_back, color: Colors.black),
// ),
// ),
//       body: ListView.builder(
//         itemCount: cart.items.length,
//         itemBuilder: (context, index) {
//           final CartItem item = cart.items[index];
//           final double price = double.parse(item.product.price);
//
//           return
//             Card(
//               margin: EdgeInsets.all(8.0),
//               child: ListTile(
//                 leading: Image.asset(
//                   item.imagePath, // Use the provided image path
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                 ),
//                 title: Text(item.product.name),
//
//                 subtitle: Text('Price: \Rs.${double.parse(item.product.price).toStringAsFixed(2)}',
//                 style: TextStyle(color: Colors.green),),
//                 trailing: Text('Quantity: ${item.quantity}'),
//               ),
//             );
//
//         },
//       ),
//         bottomNavigationBar: BottomAppBar(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text('Total: \Rs.${cart.calculateTotal().toStringAsFixed(2)}'),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                   MaterialPageRoute(builder: (context) =>
//                   LoginScreen(),
//                   ));
//                   // Add code to handle the "Place Order" action here
//                 },
//                 child: Text('Place Order'),
//               ),
//             ],
//           ),
//         ),
//
//     );
//   }
// }



import 'package:flutter/material.dart';

import '../User_Credentials/login_Screen.dart';
import 'Check_Out_Screen/Delivery_Address.dart';

class tempProduct {
  final String name;
  final double price;

  tempProduct({
    required this.name,
    required this.price,
  });
}

class TempCartItem {
  final tempProduct product;
  final int quantity;

  TempCartItem({
    required this.product,
    required this.quantity,
  });
}

class MyCartPage extends StatefulWidget {
  final String? mobileNumber;

  MyCartPage({Key? key, this.mobileNumber}) : super(key: key);
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<TempCartItem> cartItems = [];

  double get totalAmount {
    return cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
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
            Text('Mobile number:- ${widget.mobileNumber}'),
            Text('Your cart is empty.'),
            ElevatedButton(
              onPressed: () {
                // Implement your checkout logic here
                // For example, you can navigate to a checkout page
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Sign In to continue'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement your checkout logic here
                // For example, you can navigate to a checkout page
                Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryAddressPage()));
              },
              child: Text('Delivery Address'),
            )
          ],
        ),

      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                TempCartItem cartItem = cartItems[index];
                return ListTile(
                  title: Text(cartItem.product.name),
                  subtitle: Text('\$${cartItem.product.price.toStringAsFixed(2)}'),
                  trailing: Text('Quantity: ${cartItem.quantity}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement your checkout logic here
                    // For example, you can navigate to a checkout page
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement your checkout logic here
              // For example, you can navigate to a checkout page
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
            },
            child: Text('Checkout'),
          )
        ],
      ),
    );
  }
}


