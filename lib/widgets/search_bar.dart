import 'package:flutter/material.dart';


// class Searchbar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title: Text('Search Bar Example'),
//         // ),
//         // body: SearchBartool(),
//       ),
//     );
//   }
// }

class SearchBartool extends StatefulWidget {
  @override
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBartool> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: [
      Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0,),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for products...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
          // SizedBox(height: 20.0),
          // ElevatedButton(
          //   onPressed: () {
          //     // You can implement search functionality here
          //     final searchText = _searchController.text;
          //     print('Searching for: $searchText');
          //   },
          //   child: Text('Search'),
          // ),
        ],
      ),
    );
  }
}
