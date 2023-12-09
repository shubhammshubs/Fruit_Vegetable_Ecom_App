// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class ImageSlider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Implement the image slider widget here
//     return Container(
//       child: CarouselSlider(
//         items: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.black12, // Set the border color
//                 width: 1.0,          // Set the border width
//               ),
//               borderRadius: BorderRadius.circular(20),
//               // Adjust border radius as needed
//             ),
//             child: Image.asset('assets/images/1.png'), // Image 1
//           ),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.black12, // Set the border color
//                 width: 1.0,            // Set the border width
//               ),
//               borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
//             ),
//             child: Image.asset('assets/images/2.png'), // Image 2
//           ),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.black12, // Set the border color
//                 width: 1.0,            // Set the border width
//               ),
//               borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
//             ),
//             child: Image.asset('assets/images/3.png'), // Image 3
//           ),
//         ],
//         options: CarouselOptions(
//           height: 200.0,
//           enlargeCenterPage: true,
//           autoPlay: true,
//         ),
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../APi/Category_vegitable_API.dart';
import '../APi/Product_class.dart';
import '../Inside_Pages/Product_Details_Display_from_API.dart';
import 'dart:async';

// ... (existing imports)
class PopularItems1Slider extends StatefulWidget {
  final String productCategory;

  PopularItems1Slider({
    required this.productCategory,
  });

  @override
  _PopularItemsSliderState createState() => _PopularItemsSliderState();
}

class _PopularItemsSliderState extends State<PopularItems1Slider> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.page == 2) {
        // If on the last page, go back to the first page
        _pageController.jumpToPage(0);
      } else {
        // Otherwise, move to the next page
        _pageController.nextPage(
          duration: Duration(milliseconds: 2500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHeight = 200.0; // Set your desired height

    return Center(
      child: Container(
        height: containerHeight,
        child: FutureBuilder<List<Product>>(
          future: fetchDataFromApi(widget.productCategory),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                List<Product> products = snapshot.data!;

                // Only display the first 3 products
                // List<Product> firstThreeProducts =
                // products.length > 3 ? products.sublist(0, 3) : products;
                // Display the first, second, and last products
                List<Product?> selectedProducts = [
                  products.isNotEmpty ? products[0] : null,
                  products.length > 1 ? products[1] : null,
                  products.isNotEmpty ? products[5] : null,
                ];

                // Filter out null values
                List<Product> firstThreeProducts =
                selectedProducts.where((product) => product != null).cast<Product>().toList();

                return PageView.builder(
                  controller: _pageController,
                  itemCount: firstThreeProducts.length,
                  itemBuilder: (context, index) {
                    Product product = firstThreeProducts[index];

                    return InkWell(
                      onTap: () {
                        // Navigate to ProductDetailsPageFromAPI when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPageFromAPI(product: product, mobileNumber: '',),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5.0,left: 5.0),
                        width: containerWidth,
                        height: containerHeight,
                        decoration: BoxDecoration(
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
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child:
                           CachedNetworkImage(
                          imageUrl: ImageHelper.getProductImageUrl(product.image),
                          width: containerWidth,
                          height: containerHeight,
                          fit: BoxFit.contain,
                          errorWidget: (BuildContext context, String url, dynamic error) {
                          return Container(
                          color: Colors.white70,
                          child: Icon(
                          Icons.error,
                          color: Colors.red,
                          ),
                          );
                    },
                             cacheManager: DefaultCacheManager(),

                           ),

                          // Image.network(
                          //   ImageHelper.getProductImageUrl(product.image),
                          //   width: containerWidth,
                          //   height: containerHeight,
                          //   fit: BoxFit.contain,
                          //   errorBuilder:
                          //       (BuildContext context, Object error,
                          //       StackTrace? stackTrace) {
                          //     return Container(
                          //       color: Colors.white70,
                          //       child: Icon(
                          //         Icons.error,
                          //         color: Colors.red,
                          //       ),
                          //     );
                          //   },
                          // ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                      'No products available for ${widget.productCategory}'),
                );
              }
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
