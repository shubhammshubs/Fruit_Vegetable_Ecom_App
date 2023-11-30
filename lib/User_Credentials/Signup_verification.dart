import 'package:ecom/User_Credentials/signup_verification_OTP.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_Screen.dart';



class SignupMobileVerify extends StatefulWidget {
  const SignupMobileVerify({super.key});

  static String verify="";

  @override
  State<SignupMobileVerify> createState() => _SignupMobileVerifyState();
}

class _SignupMobileVerifyState extends State<SignupMobileVerify> {
  TextEditingController countrycode = TextEditingController();
  var _mobileController="";
  bool showProgressIndicator = false; // Declare the variable

  // final TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text="+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25,right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset('assets/images/anar.jpg',

                width: 280,
                height: 180,
              ),
              const SizedBox(height: 10,),

              const Text('Phone Verification',
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

              const SizedBox(height: 10,),
              const Text('We need to register your phone before getting started !',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,),
              const SizedBox(height: 30,),

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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Icon(
                          Icons.mobile_friendly,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 40,

                        child: TextField(
                          readOnly: true,
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
                        child: TextField(
                          onChanged: (value) {
                            // setState(() {
                            _mobileController = value;
                            // }
                            // );
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,

                  children:[

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: ElevatedButton(

                        onPressed: () async {

                          print("${countrycode.text+_mobileController}");

                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '${countrycode.text+_mobileController}',
                            verificationCompleted: (PhoneAuthCredential credential) {
                              setState(() {
                                showProgressIndicator = false; // Verification is complete, hide the indicator
                              });
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              String errorMessage = e.message?? 'An error occurred';  // Get the error message from FirebaseAuthException
                              print('Firebase verification error: $errorMessage');
                              Fluttertoast.showToast(
                                msg: errorMessage,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,

                                fontSize: 16.0,
                              );
                              setState(() {
                                showProgressIndicator = false; // Verification failed, hide the indicator
                              });
                            },
                            codeSent: (String verificationId, int? resendToken) {

                              SignupMobileVerify.verify=verificationId;
                              setState(() {
                                showProgressIndicator = false; // Code sent, hide the indicator
                              });
                              // Navigator.pushNamed(context, "otp");

                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => SignupVerifyOTP(mobileNumber: _mobileController,),),
                              );

                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},

                          );
                          setState(() {
                            showProgressIndicator = true; // Start the verification, show the indicator
                          });
                          // Navigator.pushNamed(context, "otp");
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),

                        ),

                        child: const Text('Send the code',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),),
                      ),
                    ),
                    // Display CircularProgressIndicator while verifying
                    if (showProgressIndicator) // You need to conditionally display it
                      CircularProgressIndicator(),
                  ],
                ),
              ),
              const SizedBox(height: 20,),

              // Code for Login Page Button

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen(),),
                  );
                },
                child: Text(
                  'Already Registered? Login Here',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent[100],
                      decoration: TextDecoration.underline
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}