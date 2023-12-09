// // import 'package:flutter/material.dart';
// //
// // import '../Inside_Pages/Product.dart';
// // import '../Inside_Pages/product_details_pg_1.dart';
// // import '../Inside_Pages/product_list.dart';
// //
// // class PopularItemsSlider extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     // Replace these image file names with your actual image file names
// //     final List<Map<String, dynamic>> Popularitem = [
// //       {
// //         'id': 4,
// //         'imagePath': 'assets/images/4.png', // Image for Product 1
// //       },
// //       {
// //         'id': 5,
// //         'imagePath': 'assets/images/5.png', // Image for Product 2
// //       },
// //       {
// //         'id': 3,
// //         'imagePath': 'assets/images/3.png', // Image for Product 2
// //       },
// //       {
// //         'id': 1,
// //         'imagePath': 'assets/images/1.png', // Image for Product 2
// //       },
// //       // Add more image entries with unique ids
// //     ];
// //
// //     return ListView.builder(
// //       scrollDirection: Axis.horizontal,
// //       itemCount: Popularitem.length,
// //       itemBuilder: (context, index) {
// //         final Map<String, dynamic> imageData = Popularitem[index];
// //         final int productId = imageData['id'];
// //
// //         final Product product =
// //         ItemsList.firstWhere((item) => item.id == productId);
// //
// //         return GestureDetector(
// //           onTap: () {
// //             // Navigate to the ProductDetailsPage and pass the selected Product object
// //             Navigator.of(context).push(
// //               MaterialPageRoute(
// //                 builder: (context) => ProductDetailsPage(
// //                   product: product,
// //                 ),
// //               ),
// //             );
// //           },
// //           child: Padding(
// //             padding: EdgeInsets.all(10.0),
// //             child: Column(
// //               children: [
// //                 Container(
// //                   margin: const EdgeInsets.only(top: 10),
// //                   width: 150,
// //                   height: 200,
// //                   decoration:  BoxDecoration(
// //                       color: Colors.white,
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black45,
// //                           blurRadius: 10,
// //                           offset: Offset(2, 2),
// //                         ),
// //                       ],
// //
// //                       borderRadius: BorderRadius.all(Radius.circular(20)),
// //                       border: Border.all(
// //                         color: Colors.black26,
// //                         width: 2.0,
// //                       )
// //                   ),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Container(
// //                         width: 130.0,
// //                         // height: 150.0,
// //                         decoration: BoxDecoration(
// //                           border: Border.all(
// //                             color: Colors.black12, // Set the border color
// //                             width: 1.0,          // Set the border width
// //                           ),
// //                           borderRadius: BorderRadius.circular(10),
// //                           // Adjust border radius as needed
// //                         ),
// //                         child: Image.asset(
// //                           imageData['imagePath'], // Load the correct image path
// //                           width: 100.0,
// //                           height: 100.0,
// //                         ),
// //                       ),
// //                       // Image.asset(
// //                       //   imageData['imagePath'], // Load the correct image path
// //                       //   width: 100.0,
// //                       //   height: 100.0,
// //                       // ),
// //                       SizedBox(height: 8.0),
// //                       Text(product.price,
// //                         style: TextStyle(
// //                           color: Colors.green,
// //                           fontSize: 16.0,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       SizedBox(height: 8.0),
// //                       Text(
// //                         product.name, // Display the product name from the Product object
// //                         style: TextStyle(
// //                           color: Colors.grey[700],
// //                           fontSize: 16.0,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 // Image.asset(
// //                 //   imageData['imagePath'], // Load the correct image path
// //                 //   width: 100.0,
// //                 //   height: 100.0,
// //                 // ),
// //                 // SizedBox(height: 8.0),
// //                 // Text(
// //                 //   product.name, // Display the product name from the Product object
// //                 //   style: TextStyle(
// //                 //     fontSize: 16.0,
// //                 //     fontWeight: FontWeight.bold,
// //                 //   ),
// //                 // ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// //
//
//
//
//
//
// // ... (existing imports)
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//
// import '../APi/Category_vegitable_API.dart';
// import '../APi/Product_class.dart';
// import '../Inside_Pages/Product_Details_Display_from_API.dart';
// class PopularItemsSlider extends StatelessWidget {
//   final String productCategory;
//
//   PopularItemsSlider({
//     required this.productCategory,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Product>>(
//       future: fetchDataFromApi(productCategory),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData && snapshot.data != null) {
//             List<Product> products = snapshot.data!;
//
//             // Only display the last 3 products
//             List<Product> lastThreeProducts = products.length > 3
//                 ? products.sublist(products.length - 4)
//                 : products;
//
//             return SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: lastThreeProducts.map((product) {
//                   return InkWell(
//                     onTap: () {
//                       // Navigate to ProductDetailsPageFromAPI when tapped
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ProductDetailsPageFromAPI(product: product),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 16.0),
//                       width: 150,
//                       height: 200,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black45,
//                             blurRadius: 10,
//                             offset: Offset(2, 2),
//                           ),
//                         ],
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         border: Border.all(
//                           color: Colors.black26,
//                           width: 2.0,
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 130.0,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.black12,
//                                 width: 1.0,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child:
//                             CachedNetworkImage(
//                                 imageUrl:  ImageHelper.getProductImageUrl(product.image),
//                                 width: 100.0,
//                                 height: 100.0,
//                                 fit: BoxFit.contain,
//                                 errorWidget: (BuildContext context, String url, dynamic error) {
//                                   return Container(
//                                     color: Colors.white70,
//                                     child: Icon(
//                                       Icons.error,
//                                       color: Colors.red,
//                                     ),
//                                   );
//
//                                 },
//                               cacheManager: DefaultCacheManager(),
//
//                             )
//
//                           // Image.network(
//                           //     ImageHelper.getProductImageUrl(product.image),
//                           //     width: 100.0,
//                           //     height: 100.0,
//                           //     errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                           //       return Container(
//                           //         color: Colors.white70,
//                           //         child: Icon(
//                           //           Icons.error,
//                           //           color: Colors.red,
//                           //         ),
//                           //       );
//                           //     },
//                           //   ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Text(
//                             '${product.price.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               color: Colors.green,
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Text(
//                             product.title,
//                             style: TextStyle(
//                               color: Colors.grey[700],
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           } else {
//             return Center(
//               child: Text('No products available for $productCategory'),
//             );
//           }
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../APi/Best_Deal_API.dart';
import '../APi/Popular_item_API.dart';
import '../APi/Product_class.dart';
import '../Inside_Pages/Product_Details_Display_from_API.dart';

class PopularItemsSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: PopularItemFromApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            List<Product> products = snapshot.data!;

            // List<Product> firstThreeProducts = products.length > 3
            //     ? products.sublist(0, 4)
            //     : products;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: products.map((product) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPageFromAPI(product: product, mobileNumber: '',),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      width: 150,
                      height: 200,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 130.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: ImageHelper1.getProductImageUrl(product.image),
                              width: 100.0,
                              height: 100.0,
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
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Rs.${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            product.title,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Center(
              child: Text('No products available from the Popular Deals '),
            );
          }
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
