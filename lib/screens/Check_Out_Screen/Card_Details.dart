import 'package:flutter/material.dart';



class AddCardForm2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Card'),
        ),
        body: AddCardForm(),
      ),
    );
  }
}

class AddCardForm extends StatefulWidget {
  @override
  _AddCardFormState createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _cardholderName = '';
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Cardholder Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the cardholder name';
                }
                return null;
              },
              onSaved: (value) {
                _cardholderName = value!;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Card Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the card number';
                }
                return null;
              },
              onSaved: (value) {
                _cardNumber = value!;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Expiry Date (MM/YYYY)'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the expiry date';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _expiryDate = value!;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'CVV'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the CVV';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _cvv = value!;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Add your logic to save the card details
                  // For example, you can print the details
                  print('Cardholder Name: $_cardholderName');
                  print('Card Number: $_cardNumber');
                  print('Expiry Date: $_expiryDate');
                  print('CVV: $_cvv');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
