import 'dart:convert';

import 'package:ecom/User_Credentials/Forgot_Password_OTP_Screen.dart';
import 'package:ecom/User_Credentials/Signup_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../HomePage1.dart';
import 'Forgot_Pass_Email_Verification.dart';
import 'Signup_verification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl =
        'https://apip.trifrnd.com/fruits/vegfrt.php?apicall=login';

    // Simulate a delay of 1 second
    await Future.delayed(Duration(seconds: 1));

    final response = await http.post(Uri.parse(apiUrl),
        body: {
          "mobile": _mobileController.text,
          "password": _passwordController.text,
        });

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("Response body: ${response.body}");

      print("Decoded data: $responseData");

      if (responseData == "OK") {
        // Login successful, you can navigate to the next screen
        print("Login successful");
        final user = json.decode(response.body)[0];
        try {
          // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          // sharedPreferences.setString('mobile', _mobileController.text);
        } catch (e) {
          // Handle the exception, e.g., print an error message.
          print('Error: $e');
        }


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              // mobileNumber: _mobileController.text,
            ),
          ),
        );
      } else {
        // Login failed, show an error message
        print("Login failed");
        Fluttertoast.showToast(
          msg: "Invalid mobile number or password!",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
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
    return Scaffold(
      body:
      Center(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                // SizedBox(height: 40,),
                Image.asset('assets/images/orenge.jpg',

                  width: 250,
                  height: 180,
                ),
                const SizedBox(height: 10,),
            
                Text( "Sign In",
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                ),
                SizedBox(height: 10,),
                Text( "Hi! Welcome back, you've been missed",
                  style: TextStyle(color: Colors.black45,
                      // fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 30,),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Mobile',
                      hintText: 'Enter Mobile Number',
                      prefixIcon: Icon(Icons.mobile_friendly),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a mobile';
                      } else if (value.length < 10) {
                        return 'Mobile number must be 10 Digits';
                      }
                      return null;
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: TextFormField(
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: InputDecoration(
                //       labelText: 'Email',
                //       hintText: 'Enter Email',
                //       prefixIcon: Icon(Icons.email),
                //       border: OutlineInputBorder(),
                //     ),
                //     onChanged: (String value){
                //
                //     },
                //     validator: (value){
                //       return value!.isEmpty ? 'Please  Enter Email' : null;
                //     },
                //   ),
                // ),
                SizedBox(height: 30,),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 15),
                //   child: TextFormField(
                //     keyboardType: TextInputType.visiblePassword,
                //     decoration: InputDecoration(
                //       labelText: 'Password',
                //       hintText: 'Enter Password',
                //       prefixIcon: Icon(Icons.password),
                //       border: OutlineInputBorder(),
                //     ),
                //     onChanged: (String value){
                //
                //     },
                //     validator: (value){
                //       return value!.isEmpty ? 'Please  Enter Password' : null;
                //     },
                //   ),
                // ),
                // SizedBox(height: 10,),
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
                      return value!.isEmpty
                          ? 'Please Enter Password'
                          : null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 220,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ForgotPassMobileVerify()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          decoration: TextDecoration.underline, // Add underline decoration here
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () async {
                      // Handle login logic here
                      if (_formKey.currentState!.validate()) {
                        // Show loading indicator
                        setState(() {
                          _isLoading = true;
                        });
            
                        // Perform the login
                        await _login();
            
                        // Hide loading indicator after login completes
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: _isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    ) // Show loading indicator when _isLoading is true
                        : const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 35),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(20.0),
                //     child: MaterialButton(
                //
                //       minWidth: double.infinity,
                //       onPressed:() {},
                //       child: Text('Sign In',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 14,
                //       ),),
                //
                //       color: Colors.green,
                //       textColor: Colors.white,
                //     ),
                //   ),
                // ),
            
                // SizedBox(height: 40,),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 35),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           color: Colors.black45 , // Color of the lines
                //           thickness: 1, // Thickness of the lines
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 8),
                //         child: Text(
                //           'Sign In with',
                //           style: TextStyle(
                //             color: Colors.black45,
                //             // backgroundColor: Colors.teal,
                //             fontSize: 14,
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           color: Colors.black45, // Color of the lines
                //           thickness: 1, // Thickness of the lines
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 30,),
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //
                //     CircleAvatar(
                //       backgroundColor: Colors.white,
                //       radius: 40,
                //       child: ShaderMask(
                //         shaderCallback: (Rect bounds) {
                //           return LinearGradient(
                //             colors: [Colors.red,Colors.yellow,Colors.green, Colors.blue], // Define the colors you want to mix
                //             begin: Alignment.topCenter,
                //             end: Alignment.bottomRight,
                //           ).createShader(bounds);
                //         },
                //         child: Icon(
                //           FontAwesomeIcons.google,
                //           size: 34,
                //           color: Colors.white, // Set the default color of the icon
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 10),
                //     CircleAvatar(
                //       backgroundColor: Colors.white,
                //       radius: 40,
                //       child: Icon(
                //         Icons.apple, // Replace with the appropriate Google icon
                //         color: Colors.black, // Change the color to match the Google icon
                //         size: 38,
                //       ),
                //     ),
                //     SizedBox(width: 10),
                //     CircleAvatar(
                //       backgroundColor: Colors.white,
                //       radius: 40,
                //       child: Icon(
                //         FontAwesomeIcons.facebookF, // Replace with the appropriate Facebook icon
                //         color: Colors.blue, // Change the color to match the Facebook icon
                //         size: 34,
                //       ),
                //     ),
                //     SizedBox(width: 10),
                //
                //     CircleAvatar(
                //       backgroundColor: Colors.white,
                //       radius: 40,
                //       child: Icon(
                //         FontAwesomeIcons.mobileScreen, // Replace with the appropriate Facebook icon
                //         color: Colors.black, // Change the color to match the Facebook icon
                //         size: 34,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 40,),
                // Don't have an account? Sign Up.
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                    // SignUpScreen()
                    SignupMobileVerify()
                    ));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            
            
              ],
            ),
          ),
        ),

      ),

    );
  }
}
