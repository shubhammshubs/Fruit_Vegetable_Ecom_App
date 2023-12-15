
import 'package:ecom/HomePage1.dart';
import 'package:flutter/material.dart';
import '../../APi/Display_User_info_API.dart';
import '../../APi/Update_address_API.dart';

class ManageAddress extends StatefulWidget {
  final String mobileNumber;

  ManageAddress({required this.mobileNumber});

  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  Map<String, dynamic>? addressInfo;
  String isSelected="";
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController( );
  TextEditingController pinCodeController = TextEditingController( );
  bool shouldSetInitialValues = true; // Add this flag

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch address information when the screen is initialized
    fetchAddressInfo();
  }

  Future<void> fetchAddressInfo() async {
    try {
      final data = await ApiServiceaddress.fetchUserInfo(widget.mobileNumber);

      setState(() {
        if (data != null) {
          addressInfo = data;
        } else {
          // Set a default message when the data is null
          addressInfo = {'message': 'Enter your address'};
        }
      });
    } catch (e) {
      // Handle the error, e.g., show an error message
      print('Error fetching address information: $e');
    }
  }

  Future<void> showAddAddressDialog() async {
    bool isUpdate = addressInfo != null &&
        addressInfo!.containsKey('address') &&
        addressInfo!['address'] != null &&
        addressInfo!['address'].isNotEmpty;

    // Set the initial values in the controllers if it's an update
    if (isUpdate && shouldSetInitialValues) {
      stateController.text = addressInfo!['state'] ?? '';
      districtController.text = addressInfo!['district'] ?? '';
      cityController.text = addressInfo!['city'] ?? '';
      addressController.text = addressInfo!['address'] ?? '';
      // pinCodeController.text = addressInfo!['pinCode'] ?? '';

      // Set the flag to false after setting initial values
      shouldSetInitialValues = false;
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isUpdate ? 'Update Address' : 'Add New Address'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: stateController,
                    decoration: InputDecoration(labelText: 'State'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the state';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  TextFormField(
                    controller: districtController,
                    decoration: InputDecoration(labelText: 'District'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the district';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(labelText: 'City'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the city';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the address';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  // TextFormField(
                  //   controller: pinCodeController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(labelText: 'Pin Code'),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter the pin code';
                  //     }
                  //     return null;
                  //   },
                  //   textInputAction: TextInputAction.done,
                  //   onEditingComplete: () {
                  //     _submitForm();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: Text(isUpdate ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  // Future<void> _showAddAddressDialog() async {
  //   bool isUpdate = addressInfo != null &&
  //       addressInfo!.containsKey('address') &&
  //       addressInfo!['address'] != null &&
  //       addressInfo!['address'].isNotEmpty;
  //
  //   // Set the initial values in the controllers if it's an update
  //   if (isUpdate && shouldSetInitialValues) {
  //     stateController.text = addressInfo!['state'] ?? '';
  //     districtController.text = addressInfo!['district'] ?? '';
  //     cityController.text = addressInfo!['city'] ?? '';
  //     addressController.text = addressInfo!['address'] ?? '';
  //     pinCodeController.text = addressInfo!['pinCode'] ?? '';
  //
  //     // Set the flag to false after setting initial values
  //     shouldSetInitialValues = false;
  //   }

  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(isUpdate ? 'Update Address' : 'Add New Address'),
  //         content: Form(
  //           key: _formKey,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: <Widget>[
  //                 // Existing TextFormField code...
  //                 TextFormField(
  //                   controller: stateController,
  //                   decoration: InputDecoration(labelText: 'State'),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter the state';
  //                     }
  //                     return null;
  //                   },
  //                   textInputAction: TextInputAction.next,
  //                   onEditingComplete: () {
  //                     FocusScope.of(context).nextFocus();
  //                   },
  //                 ),
  //                 // ... (similar modifications for other TextFormFields)
  //               ],
  //             ),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               _submitForm();
  //             },
  //             child: Text(isUpdate ? 'Update' : 'Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // If all fields are valid, submit the form
      bool success = await ApiServiceUpdateAddress.updateAddress(
        mobile: widget.mobileNumber,
        state: stateController.text,
        district: districtController.text,
        city: cityController.text,
        address: addressController.text
        // address: '${addressController.text} ${pinCodeController.text}',
      );

      if (success) {
        // Address updated successfully
        print('Address updated successfully');
        // Reload the page after adding the address
        fetchAddressInfo();
        setState(() {});
        Navigator.of(context).pop();

        // Reset the flag to true after submitting the form
        shouldSetInitialValues = true;
      } else {
        // Failed to update the address
        print('Failed to update the address');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Address${widget.mobileNumber}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: addressInfo != null &&
            addressInfo!.containsKey('address') &&
            addressInfo!['address'] != null &&
            addressInfo!['address'].isNotEmpty
            ? ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.green),
                title: Text(
                  '${addressInfo!['address']}, \n${addressInfo!['city']},${addressInfo!['state']}',
                ),
                trailing: GestureDetector(
                  onTap: () {
                    // Handle the checkbox tap here
                    setState(() {
                      // Unselect all items
                      for (int i = 0; i < addressInfo!.length; i++) {
                        addressInfo?[i]['isSelected'] = false;
                      }
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
                    child: Icon(
                      Icons.circle,
                      size: 16,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
            : Center(
          child: Text('Enter your address'),
        ),
      ),
      bottomNavigationBar: addressInfo != null &&
          addressInfo!.containsKey('address') &&
          addressInfo!['address'] != null &&
          addressInfo!['address'].isNotEmpty
          ? BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            // Button logic
            final snackBar = SnackBar(
              content: Text(
                'Address Saved',
                textAlign: TextAlign.center,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context)=>
            //         HomePage(mobileNumber: widget.mobileNumber,)));
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text(
            'Apply',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      )
          : SizedBox.shrink(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddAddressDialog();
        },
        tooltip: 'Add New Delivery Address',
        child: Icon(Icons.add),
      ),
    );
  }
}



