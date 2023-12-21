// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
//
//
//
// class SearchBartool extends StatefulWidget {
//   @override
//   _SearchBarDemoState createState() => _SearchBarDemoState();
// }
//
//
//
// class _SearchBarDemoState extends State<SearchBartool> {
//   TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _searchResults = [];
//
//   Future<void> _searchProducts(String searchText) async {
//     final apiUrl = "https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readproduct";
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         body: {"product_title": searchText},
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _searchResults = List<Map<String, dynamic>>.from(data['records']);
//         });
//       } else {
//         // Handle the case when the API call fails or returns an error
//         print('Failed to load products');
//       }
//     } catch (error) {
//       // Handle the case when an error occurs during the API call
//       print('Error: $error');
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(1.0),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) {
//                 // Perform the search when the user enters text
//                 _searchProducts(value);
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search for products...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20.0),
//           // Display the search results
//           // Expanded(
//           //   child: ListView.builder(
//           //     itemCount: _searchResults.length,
//           //     itemBuilder: (context, index) {
//           //       final product = _searchResults[index];
//           //       return ListTile(
//           //         title: Text(product['product_title']),
//           //         subtitle: Text('ID: ${product['product_id']}'),
//           //         // Add more information as needed
//           //       );
//           //     },
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
