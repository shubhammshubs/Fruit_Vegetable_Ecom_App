import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/screens/my_cart.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import '../APi/Category_vegitable_API.dart';
import '../APi/Product_class.dart';
import '../User_Credentials/login_Screen.dart';
import '../widgets/popular_items_slider.dart';

class ProductDetailsPageFromAPI extends StatefulWidget {
  final Product product;
  final String mobileNumber;


  ProductDetailsPageFromAPI({required this.product,
    required this.mobileNumber
  });

  @override
  State<ProductDetailsPageFromAPI> createState() => _ProductDetailsPageFromAPIState();
}

class _ProductDetailsPageFromAPIState extends State<ProductDetailsPageFromAPI> {
  int selectedQuantity = 1;
 // Initial quantity
  double totalPrice = 0.0;
 // Initialize total price

  void initState() {
    super.initState();
    // Set initial total price to the product's price
    totalPrice = widget.product.price;
  }

  void updateTotalPrice() {
    // Calculate total price based on selected quantity
    totalPrice = selectedQuantity * widget.product.price;
  }
  void incrementQuantity() {
    setState(() {
      selectedQuantity++;
      updateTotalPrice(); // Update total price when quantity changes
    });
  }

  void decrementQuantity() {
    if (selectedQuantity > 1) {
      setState(() {
        selectedQuantity--;
        updateTotalPrice(); // Update total price when quantity changes
      });
    }
  }

  bool isSavedForLater = false;
 // State to track whether saved for later
  Icon _filledHeartIcon = Icon(
    Icons.favorite,
    color: Colors.red, // Set the filled color here
  );

// Define an empty heart icon
  Icon _emptyHeartIcon = Icon(
    Icons.favorite_border,
    color: Colors.grey, // Set the empty color here
  );

  // Function to save for later
  void saveForLater() {
    setState(() {
      isSavedForLater = !isSavedForLater; // Toggle the state
    });
  }


  void addToCart() async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=addtocart';

    // Replace 'your_api_key_here' with the actual API key
    // final apiKey = 'your_api_key_here';

    // Replace 'your_mobile_number' and 'your_product_id' with actual values
    final mobileNumber = widget.mobileNumber;
    final productId = widget.product.id.toString(); // Assuming product id is an int

    final quantity = selectedQuantity.toString();
    final price = totalPrice.toString(); // Use the updated total price
    final title = widget.product.title.toString();
    final image = widget.product.image.toString();

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        // 'api_key': apiKey,
        'mobile': mobileNumber,
        'product_id': productId,
        'quantity': quantity,
        'price': price,
        'product_title': title,
        'product_image': image,
      },
    );
    if (mobileNumber != null && mobileNumber.isNotEmpty) {
      // final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=addtocart';

      // ... (rest of the function remains unchanged)

      if (response.statusCode == 200) {
        // Successful request, handle the response as needed
        print('Response Body: ${response.body}');
        print('Item added to cart successfully Done');

        // Navigate to the cart
        Navigator.push(context, 
            MaterialPageRoute(builder: (context) => 
                AddToCartPage(mobileNumber: widget.mobileNumber, product: widget.product,)));
      } else {
        // Error handling, print the error message
        print('Failed to add item to cart. Error: ${response.body}');
      }
    } else {
      // User has not provided the mobile number, navigate to LoginScreen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(product: widget.product,)));
    }

    // if (response.statusCode == 200) {
    //   // Successful request, handle the response as needed
    //   print('Response Body: ${response.body}');
    //   // print(response.);
    //   print('Item added to cart successfully Done');
    //   // Show a SnackBar to inform the user that the item has been added
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AddToCartPage()));
    //   final snackBar = SnackBar(
    //       content: Text('Item has been added to the cart',
    //         textAlign: TextAlign.center,));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //
    // } else {
    //   // Error handling, print the error message
    //   print('Failed to add item to cart. Error: ${response.body}');
    // }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    return WillPopScope(
        onWillPop: () async {
      // Handle the back button press
      Navigator.popUntil(context, (route) => route.isFirst);
      return true;
    },
    child: Scaffold(

      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Product Details',
          style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:

        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    AddToCartPage(
                      mobileNumber: widget.mobileNumber,
                      product: widget.product,)));
          },
              // Icon(Icons.shopping_cart)
              icon: Icon(Icons.shopping_cart  ))
// In your build method, use a ternary operator to display the appropriate icon based on the state
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 // favoriteItems.add(widget.product);
//                 final snackBar = SnackBar(
//                     content: Text('Item has been added to the Favorites'));
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//                 // Navigator.pop(context);
//
//               //
//                 isSavedForLater =
//                 !isSavedForLater; // Toggle the saved for later state
//               });
//             },
//             icon: isSavedForLater ? _filledHeartIcon : _emptyHeartIcon,
//           )
        ],
      ),
      key: GlobalKey<ScaffoldState>(), // Add a GlobalKey for the Scaffold

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Images Carousel
            Container(
              height: 300.0,
              width: screenWidth,
              // Adjust the height as needed
              color: Colors.grey[100],

              // Replace with the off-white color you prefer
              child:
              // Text('image: ${widget.product.image}'),
              // Image.network('https://apip.trifrnd.com/fruits/${widget.product.image}'),
              CachedNetworkImage(
                imageUrl: ImageHelper.getProductImageUrl(widget.product.image),
                width: screenWidth, // Set a suitable width
                height: 200.0, // Set a suitable height
                placeholder: (BuildContext context, String url) {
                  // You can return a widget to be displayed while the image is loading
                  return Container(
                    color: Colors.grey, // Placeholder color
                  );
                },
                errorWidget: (BuildContext context, String url, dynamic error) {
                  // You can return a widget to be displayed when an error occurs
                  return Container(
                    width: screenWidth, // Set a suitable width
                    height: 200.0, // Set a suitable height
                    color: Colors.white70, // Placeholder color
                    child: Icon(
                      Icons.error,
                      color: Colors.red, // Error icon color
                    ),
                  );
                },
                cacheManager: DefaultCacheManager(),
              ),
              // Image.network(
              //   ImageHelper.getProductImageUrl(widget.product.image),
              //
              //   // 'https://apip.trifrnd.com/fruits/${widget.product.image}',
              //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              //     // You can return a widget to be displayed when an error occurs
              //     // double screenWidth = MediaQuery.of(context).size.width;
              //
              //     return Container(
              //       width: screenWidth, // Set a suitable width
              //       height: 200.0, // Set a suitable height
              //       color: Colors.white70, // Placeholder color
              //       child: Icon(
              //         Icons.error,
              //         color: Colors.red, // Error icon color
              //       ),
              //     );
              //   },
              // ),
            ),

            // Product Title
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Title: ${widget.product.title}', // Display the product name
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Product Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Place Rs and Quantity at both corners
                    children: [
                      Text(
                        'Rs.: ${widget.product.price}',
                        // Display the product price
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Price text color
                        ),
                      ),
                      SizedBox(width: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Place Rs and Quantity at both corners
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.0),
                              // Adjust the radius as needed
                              color: Colors.green, // Background color
                            ),
                            child: IconButton(
                              onPressed: decrementQuantity,
                              icon: Icon(Icons.remove),
                              color: Colors.white, // Icon color
                              iconSize: 16.0, // Adjust the icon size here
                            ),
                          ),
                          Text(
                            " ${selectedQuantity.toString()} KG ",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.0),
                              // Adjust the radius as needed
                              color: Colors.green, // Background color
                            ),
                            child: IconButton(
                              onPressed: incrementQuantity,
                              icon: Icon(Icons.add),
                              color: Colors.white, // Icon color
                              iconSize: 20.0, // Adjust the icon size here
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Product Id: ${widget.product.id}', // Header for product description
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text("Mobile: ${widget.mobileNumber}"),
            // Product Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'description: ${widget.product.description}', // Header for product description
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ExpandableText(
                widget.product.description, // Display the product description
                style: TextStyle(fontSize: 14.0),
                expandText: 'Read More',
                collapseText: 'Read Less',
                maxLines: 7, // Set the maximum number of lines to display before expanding
              ),
            ),

            SizedBox(height: 6,),
            Container(
              height: 1.0, // Height of the line
              color: Colors.black, // Color of the line
              margin: EdgeInsets.symmetric(
                  vertical: 10.0), // Optional margin to adjust spacing
            ),

            // More Items Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ' More Items',
                  style: TextStyle(fontSize: 25,
                      color: Colors.black,
                      fontFamily: "NexaRegular"),
                ),
                SizedBox(height: 6,),
                Container(
                  height: 250.0, // Set a suitable height
                  child: PopularItemsSlider(),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Rs. $totalPrice',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            // Text(
            //   'Rs. ${widget.product.price}',
            //   // Display the total price with two decimal places
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.green,
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                // cart.addItem(widget.product, selectedQuantity);
                // // Assuming you have a selectedProduct and selectedQuantity
                // cart.addItem(widget.product, selectedQuantity, widget.product.images[0]); // You can choose the desired image index
                // (cartItem as Product);
                addToCart();
                // // Show a SnackBar to inform the user that the item has been added
                // final snackBar = SnackBar(
                //     content: Text('Item has been added to the cart'));
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // Navigator.pop(context);
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    ),
    );
  }
}