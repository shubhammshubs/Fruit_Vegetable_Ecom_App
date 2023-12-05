import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Card_Details.dart';
import 'Product_Summery.dart';

class PaymentMethodsPage extends StatefulWidget {
  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  String selectedOption = ''; // Variable to track the selected radio option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cash',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Adjust the color as needed
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                ),
                child: ListTile(
                  leading: Icon(Icons.money, color: Colors.green),
                  title: Text('Cash'),
                  trailing: Radio(
                    activeColor: Colors.green,
                    value: 'Cash',
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
        
              Text(
                'Wallet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
        
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Adjust the color as needed
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                ),
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.green),
                  title: Text('Wallet'),
                  trailing: Radio(
                    activeColor: Colors.green,
                    value: 'Wallet',
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
              ),
        
              SizedBox(height: 20,),
        
              Text(
                'Credit/Debit Card',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
        
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Adjust the color as needed
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                ),
                child: ListTile(
                  onTap: () {
                    // Add logic to navigate to Add Card page
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCardForm2()));
                  },
                  leading: Icon(Icons.credit_card, color: Colors.green),
                  title: Text('Add Card'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
                ),
              ),
              SizedBox(height: 20,),
        
              Text(
                'More Payment Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
        
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Adjust the color as needed
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(FontAwesomeIcons.anglesRight, color: Colors.green),
                      title: Text('UPI'),
                      trailing: Radio(
                       activeColor: Colors.green,
                        value: 'UPI',
                        groupValue: selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.googlePay, color: Colors.green),
                      title: Text('Google Pay'),
                      trailing: Radio(
                        activeColor: Colors.green,
                        value: 'Google Pay',
                        groupValue: selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.paypal, color: Colors.green),
                      title: Text('Paytm'),
                      trailing: Radio(
                        activeColor: Colors.green,
                        value: 'Paytm',
                        groupValue: selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            // Button logic
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderReview()));
            final snackBar = SnackBar(
              content: Text(' $selectedOption is Selected for Payment', textAlign: TextAlign.center),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text(
            'Confirm Payment',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
