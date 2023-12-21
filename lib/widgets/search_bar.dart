import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../APi/Product_class.dart';
import '../Inside_Pages/Product_Details_Display_from_API.dart';

class SearchController {
  void Function(String)? onChanged;
  void Function(String)? onSubmitted;
  void Function()? onTap;
  void Function(List<String>)? setSuggestions;

  void openView() {
    onTap?.call();
  }

  void closeView(String selectedItem) {
    onSubmitted?.call(selectedItem);
  }
}

class SearchBar extends StatelessWidget {
  final String mobileNumber;

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final InputDecoration? decoration;

  SearchBar({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.decoration,
    required this.mobileNumber,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: decoration,
    );
  }
}

class SearchBartool extends StatefulWidget {
  final String mobileNumber;

  SearchBartool({required this.mobileNumber});
  @override
  _SearchBartoolState createState() => _SearchBartoolState();
}
class _SearchBartoolState extends State<SearchBartool> {

  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  SearchController _searchControllerWrapper = SearchController();

  Future<void> _searchProducts(String searchText) async {
    final apiUrl =
        "https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readproduct";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {"product_title": searchText},
      );

      print('Search Text: $searchText');
      print('API Response Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _searchResults = [data]; // Assuming the response is a single map
        });
        _searchControllerWrapper.setSuggestions?.call([_searchResults.first['product_title'] as String]);

        _showDetailsDropdown();
      } else {
        // Handle the case when the API call fails or returns an error
        print('Failed to load products');
      }
    } catch (error) {
      // Handle the case when an error occurs during the API call
      // Handle the case when an error occurs during the API call
      print('Error1: $error');
      // Handle the case when an error occurs during the API call
      // print('Error1: $error');
      // Fluttertoast.showToast(
      //   msg: 'Product is not available',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
    }
  }

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


  void _showDetailsDropdown() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // print('_searchResults length: ${_searchResults.length}');
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchResults.isNotEmpty) ...{
                InkWell(
                  onTap: () {
                    Navigator.pop(context); // Close the bottom sheet
                    navigateToProductDetails(_searchResults.first);
                  },
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Container(
                        width: 50.0,
                        height: 100.0,
                        child: Image.network(
                          'https://apip.trifrnd.com/fruits/${_searchResults.first['product_image'] ?? ''}',
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Container(
                              color: Colors.white70,
                              child: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            );
                          },
                        ),
                      ),
                      title: Text('${_searchResults.first['product_title'] ?? ''}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_searchResults.first['product_price'] ?? ''}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ),
              } else ...{
                // Display a message when no products are available
                Text(
                  'No products available.',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              },
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
          // TextField(
          //   controller: _searchController,
          //   onChanged: (value) {
          //     // Perform the search when the user enters text
          //     // _searchProducts(value);
          //   },
          //   onSubmitted: (value) {
          //     // Perform the search when the user submits (presses Enter/Search)
          //     _searchProducts(value);
          //   },
          //   onEditingComplete: () {
          //     // Perform the search when the user presses the right tick on the keypad
          //     _searchProducts(_searchController.text);
          //   },
          //   decoration: InputDecoration(
          //     hintText: 'Search for products...',
          //     prefixIcon: const Icon(Icons.search),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //   ),
          //   // mobileNumber: widget.mobileNumber,
          // )

          SearchBar(
            controller: _searchController,
            onChanged: (value) {
              // Perform the search when the user enters text
              _searchProducts(value);
            },
            onSubmitted: (value) {
              // Perform the search when the user submits (presses Enter/Search)
              _searchProducts(value);
            },
            decoration: InputDecoration(
              hintText: 'Search for products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ), mobileNumber: widget.mobileNumber,
          )
        ),
        // SizedBox(height: 20.0),
      ],
    );
  }
}
