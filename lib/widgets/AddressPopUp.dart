import 'package:flutter/material.dart';
import '../../APi/Update_address_API.dart';

class AddressPopup {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static bool shouldSetInitialValues = true;

  static Future<void> showAddressDialog(BuildContext context, String mobileNumber,
      {Map<String, dynamic>? addressInfo}) async {
    TextEditingController stateController = TextEditingController();
    TextEditingController districtController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    bool isUpdate = addressInfo != null &&
        addressInfo.containsKey('address') &&
        addressInfo['address'] != null &&
        addressInfo['address'].isNotEmpty;

    // Set the initial values in the controllers if it's an update
    if (isUpdate && shouldSetInitialValues) {
      stateController.text = addressInfo!['state'] ?? '';
      districtController.text = addressInfo!['district'] ?? '';
      cityController.text = addressInfo!['city'] ?? '';
      addressController.text = addressInfo!['address'] ?? '';
      shouldSetInitialValues = false;
    }

    await showDialog(
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
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      _submitForm(context, mobileNumber, isUpdate,
                          stateController, districtController, cityController, addressController);
                    },
                  ),
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
                _submitForm(context, mobileNumber, isUpdate, stateController, districtController,
                    cityController, addressController);
              },
              child: Text(isUpdate ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _submitForm(BuildContext context, String mobileNumber, bool isUpdate,
      TextEditingController stateController, TextEditingController districtController,
      TextEditingController cityController, TextEditingController addressController) async {
    if (_formKey.currentState!.validate()) {
      bool success = await ApiServiceUpdateAddress.updateAddress(
        mobile: mobileNumber,
        state: stateController.text,
        district: districtController.text,
        city: cityController.text,
        address: addressController.text,
      );

      if (success) {
        print('Address updated successfully');
        shouldSetInitialValues = true;
        Navigator.of(context).pop();
      } else {
        print('Failed to update the address');
      }
    }
  }
}
