  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;

  class Product {
    final String id;
    final String title;
    final String type;
    final String image;
    final double price;
    final String description;
    final String keywords;

    Product({
      required this.id,
      required this.title,
      required this.type,
      required this.image,
      required this.price,
      required this.description,
      required this.keywords,
    });

    factory Product.fromJson(Map<String, dynamic> json) {
      return Product(
        id: json['product_id'] ?? '',
        title: json['product_title'] ?? '',
        type: json['product_type'] ?? '',
        image: json['product_image'] ?? '',
        price: json['product_price'] != null ? double.parse(json['product_price']) : 0.0,
        description: json['product_desc'] ?? '',
        keywords: json['product_keywords'] ?? '',
      );
    }
  }

  class VegetablePage extends StatefulWidget {
    @override
    _VegetablePageState createState() => _VegetablePageState();
  }

  class _VegetablePageState extends State<VegetablePage> {
    List<Product> products = [];

    @override
    void initState() {
      super.initState();
      // Fetch products and filter by id
      fetchProductsById();
    }

    Future<void> fetchProductsById() async {
      try {
        final response = await http.post(
          Uri.parse('https://apip.trifrnd.com/fruits/vegfrt.php?apicall=product'),
          body: {'product_cat': 'vegetable'},
        );

        if (response.statusCode == 200) {

          final List<dynamic> data = json.decode(response.body);

          // Filter products based on specified ids (1, 2, 3)
          List<Product> filteredProducts = data
              .map((item) => Product.fromJson(item))
              .where((product) => ['1', '2', '3','4'].contains(product.id))
              .toList();

          setState(() {
            products = filteredProducts;
          });
        } else {
          throw Exception('Failed to load data from the API');
        }
      } catch (e) {
        print('Exception occurred: $e');
        throw Exception('Failed to load data from the API');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Vegetable Page'),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text('Product Name: ${product.title}'),
                subtitle: Image.network(
                  'https://apip.trifrnd.com/fruits/${product.image}',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      );
    }
  }
