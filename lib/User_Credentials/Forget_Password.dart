import 'dart:convert';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../Screens/Home_screen.dart';
import 'login_Screen.dart';


class ForgetPass extends StatefulWidget {
  final String mobileNumber;

  ForgetPass({required this.mobileNumber});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  // final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  late TextEditingController _mobileController; // Declare _mobileController
  bool _passwordVisible = false;


  @override
  void initState() {
    // TODO: implement initState
    countrycode.text="+91";
    _mobileController = TextEditingController(text: widget.mobileNumber); // Initialize _mobileController with the provided mobile number

    super.initState();
  }
  Future<void> _resetpassword(BuildContext context) async {


    final String apiUrl =
        'https://apip.trifrnd.com/fruits/vegfrt.php?apicall=updatepwd';

    // Simulate a delay of 1 second
    await Future.delayed(const Duration(seconds: 1));

    final response = await http.post(Uri.parse(apiUrl),
        body: {
          "mobile": _mobileController.text,
          "password": _confirmPasswordController.text,

        });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("Response body: ${response.body}");

      print("Decoded data: $responseData");
      // Fluttertoast.showToast(
      //   msg: "Password reset successful \n Out SIde the IF",
      //   toastLength: Toast.LENGTH_SHORT,
      //   backgroundColor: Colors.green,
      //   textColor: Colors.white,
      // );
      if (responseData == "Done") {
        // Login successful, you can navigate to the next screen
        print("Password reset successful");
        final user = json.decode(response.body)[0];

        Fluttertoast.showToast(
          msg: "Password reset successful",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Use Navigator to push HomePage onto the stack
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  LoginScreen(

          ),),
        );

      } else {
        // Login failed, show an error message
        print("Password Reset failed");
        Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }

    } else {
      // Handle error if the API call was not successful
      print("API call failed");
      Fluttertoast.showToast(
        msg: "Server Connction Error!",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to the SignInPage when the back button is pressed
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        // Return false to prevent the default back button behavior
        return false;
      },
      child: MaterialApp(
        home: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Register Screen'),
          //   backgroundColor: Colors.teal,
          //   centerTitle: true,
          // ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 100,),
                Container(
                  // color: Colors.white, // Set the background color to white
                  child: Center(
                    child: Image.asset(
                      'assets/images/img_5.png',
                      width: 480,
                      height: 180,
                    ),
                  ),
                ),
                const SizedBox(height: 30,),

                Text(
                  'Rest Password',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.green,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Code for Entering Name

                          // const SizedBox(height: 30,),

                          // Code for Entering Email


                          // const SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.mobile_friendly,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: TextFormField(
                                      readOnly: true, // Set the field to read-only
                                      controller: countrycode,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "|",
                                    style: TextStyle(fontSize: 33, color: Colors.grey),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      // readOnly: true, // Set the field to read-only
                                      readOnly: true, // Set the field to read-only
                                      keyboardType: TextInputType.number,
                                      controller: _mobileController,
                                      // keyboardType: TextInputType.number,
                                      // controller: _mobileController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Phone',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),





                          // Code for Entering Password
                          //  Password 1
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter Password',
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(),
                                // Password visibility toggle
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              onChanged: (String value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 30,),
                          //  Password 2
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                labelText: 'Enter Password Again',
                                hintText: 'Enter Password Again',
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(),
                                // Password visibility toggle
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              onChanged: (String value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 30,),

                          // Code for Submit button

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () async {
                                // Handle login logic here
                                if (_formKey.currentState!.validate()) {
                                  if (_passwordController.text == _confirmPasswordController.text) {
                                    // await _signUp(context);
                                    _resetpassword(context);

                                    // ('Password reset successful', Colors.green);

                                  }else {
                                    (
                                        Fluttertoast.showToast(
                                          msg: "Passwords do not match !",
                                          toastLength: Toast.LENGTH_SHORT,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        )
                                    );
                                  }
                                }
                              },
                              color: Colors.green,
                              textColor: Colors.white,
                              child: const Text('Reset',
                                style: TextStyle(
                                  fontSize: 16,
                                ),),
                            ),
                          ),

                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
