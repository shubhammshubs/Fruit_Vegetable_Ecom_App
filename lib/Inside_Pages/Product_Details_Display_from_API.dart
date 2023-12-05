import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../APi/Category_vegitable_API.dart';
import '../APi/Product_class.dart';
import '../widgets/popular_items_slider.dart';

class ProductDetailsPageFromAPI extends StatefulWidget {
  final Product product;

  ProductDetailsPageFromAPI({required this.product});

  @override
  State<ProductDetailsPageFromAPI> createState() => _ProductDetailsPageFromAPIState();
}

class _ProductDetailsPageFromAPIState extends State<ProductDetailsPageFromAPI> {
  int selectedQuantity = 1;
 // Initial quantity
  double totalPrice = 0.0;
 // Initialize total price
  void incrementQuantity() {
    setState(() {
      selectedQuantity++;
      // updateTotalPrice();

    });
  }

  void decrementQuantity() {
    if (selectedQuantity > 1) {
      setState(() {
        selectedQuantity--;
        // updateTotalPrice();

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

  // @override
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
// In your build method, use a ternary operator to display the appropriate icon based on the state
          IconButton(
            onPressed: () {
              setState(() {
                // favoriteItems.add(widget.product);
                final snackBar = SnackBar(
                    content: Text('Item has been added to the Favorites'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                // Navigator.pop(context);

              //
                isSavedForLater =
                !isSavedForLater; // Toggle the saved for later state
              });
            },
            icon: isSavedForLater ? _filledHeartIcon : _emptyHeartIcon,
          )
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
              'Rs. ${widget.product.price}',
              // Display the total price with two decimal places
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // cart.addItem(widget.product, selectedQuantity);
                // Assuming you have a selectedProduct and selectedQuantity
                // cart.addItem(widget.product, selectedQuantity, widget.product.images[0]); // You can choose the desired image index
                // (cartItem as Product);

                // Show a SnackBar to inform the user that the item has been added
                final snackBar = SnackBar(
                    content: Text('Item has been added to the cart'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.pop(context);
              },
              child: Text('Add to Cart'),
            ),


          ],
        ),
      ),
    );
  }
}