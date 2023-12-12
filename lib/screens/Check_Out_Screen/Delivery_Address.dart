import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Payment_Options.dart';

class DeliveryAddressPage extends StatefulWidget {
  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  List<Map<String, dynamic>> deliveryAddresses = [
    {
      'name': '@My Home',
      'address': '1901 Deccen Avn . Shivajinagar , Pune 91063',
      'isSelected': false,
    },
    {
      'name': '@My Office',
      'address': '4517 Bandra Ave. West , Mumbai 91495',
      'isSelected': false,
    },
    {
      'name': '@My Parent\'s House',
      'address': '8502 Parliament Rd . old Del , Delhi 98380',
      'isSelected': false,
    },
    {
      'name': '@My Friend\'s House',
      'address': '2464 Majestic  . Mesa , Bangalore 45463',
      'isSelected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Delivery Addresses'),
      ),
      body: ListView.builder(
        itemCount: deliveryAddresses.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text(deliveryAddresses[index]['name']),
                subtitle: Text(deliveryAddresses[index]['address']),
                trailing: GestureDetector(
                  onTap: () {
                    // Handle the checkbox tap here
                    setState(() {
                      // Unselect all items
                      for (int i = 0; i < deliveryAddresses.length; i++) {
                        deliveryAddresses[i]['isSelected'] = false;
                      }

                      // Select the tapped item
                      deliveryAddresses[index]['isSelected'] = true;
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blueGrey.shade100,
                      ),
                    ),
                    child: deliveryAddresses[index]['isSelected']
                        ? Icon(
                      Icons.circle,
                      size: 16,
                      color: Colors.green,
                    )
                        : null,
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: 0,
                color: Colors.blueGrey.shade100,
              ),
            ],

          );
        },
      ),

      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            // Button logic
            final snackBar = SnackBar(
              content: Text('Saved Address',textAlign: TextAlign.center,),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context)=>
            //         PaymentMethodsPage(mobileNumber: '',)));
            // Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text(
            'Apply',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new delivery address functionality
            // You can add your logic here, such as opening a new screen or dialog
          },
          tooltip: 'Add New Delivery Address',
          child: Icon(Icons.add),
        ),

    );
  }
}
