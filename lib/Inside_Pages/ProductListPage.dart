import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../APi/Category_vegitable_API.dart';
import '../APi/Product_class.dart';
import '../widgets/best_deals_slider.dart';
import 'package:http/http.dart' as http;

import 'Product_Details_Display_from_API.dart';


class ProductListPage extends StatefulWidget {
  final String productCategory;
  final String mobileNumber;

  ProductListPage({
    required this.productCategory,
    required this.mobileNumber,

    });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> productList;

  @override
  void initState() {
    super.initState();
    productList = fetchDataFromApi(widget.productCategory);
  }



  void _navigateToProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPageFromAPI(product: product, mobileNumber: widget.mobileNumber,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          widget.productCategory,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: productList,
        builder: (context, snapshot) {
          print('Snapshot Data: $snapshot.data');

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              // If data is available, display the product list
              List<Product> products = snapshot.data!;
              return
                ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading:
                          Container(
                            width: 50.0, // Set a suitable width for the image
                            height: 100.0, // Set a suitable height for the image
                            child:
                            CachedNetworkImage(
                                imageUrl: ImageHelper.getProductImageUrl(products[index].image),
                                // width: containerWidth,
                                // height: containerHeight,
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

                            )

                            // Image.network(
                            //   ImageHelper.getProductImageUrl(products[index].image),
                            //   // 'https://apip.trifrnd.com/fruits/${products[index].image}',
                            //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
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
                          title: Text(products[index].title),
                          subtitle: Text('Rs: ${products[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green, // Price text color
                          ),),
                          onTap: () => _navigateToProductDetails(products[index]),
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.black26,
                          margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                        ),
                      ],
                    );
                  },
                );
            } else {
              // If no data is available, display a message
              return Center(child: Text(
                  'No products available for ${widget.productCategory}'));
            }
          } else if (snapshot.hasError) {
            // If there is an error, display an error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // If the Future is still loading, display a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


// Add a factory constructor to create a Product from a JSON object
// class Product {
//   final String title;
//   final String type;
//   final String image;
//   final double price;
//   final String description;
//   final String keywords;
//
//   Product({
//     required this.title,
//     required this.type,
//     required this.image,
//     required this.price,
//     required this.description,
//     required this.keywords,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       title: json['product_title'] ?? '',
//       type: json['product_type'] ?? '',
//       image: json['product_image'] ?? '',
//       price: json['product_price'] != null ? double.parse(json['product_price']) : 0.0,
//       description: json['product_desc'] ?? '',
//       keywords: json['product_keywords'] ?? '',
//     );
//   }
// }
