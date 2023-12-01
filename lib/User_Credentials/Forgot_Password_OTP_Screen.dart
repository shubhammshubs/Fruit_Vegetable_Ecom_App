



import 'package:ecom/User_Credentials/login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

import 'Forget_Password.dart';
import 'Forgot_Pass_Email_Verification.dart';
import 'Signup_Screen.dart';

// Code For Checking The OTP ON Forget Password PAGE
class ForgotPassOTP extends StatefulWidget {
  final String mobileNumber;

  const ForgotPassOTP({Key? key, required this.mobileNumber});


  @override
  State<ForgotPassOTP> createState() => _MyOtpState();
}

class _MyOtpState extends State<ForgotPassOTP> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isVerifying = false; // Variable to track verification progress

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code="";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:   const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25,right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/img_2.png',

                width: 480,
                height: 180,
              ),
              const Text('User Verification',
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

              const SizedBox(height: 10,),
              Column(
                children: [
                   Text('Please enter the code we just sent to Mobile Number!',
                    style: TextStyle(fontSize: 16,
                        color: Colors.black45
                    ),
                    textAlign: TextAlign.center,
                  ),
                    Text('Mobile Number: ${widget.mobileNumber}',
                    style: TextStyle(fontSize: 16,
                        color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
              const SizedBox(height: 30,),
              // Text('Mobile Number: ${widget.mobileNumber}'),
              const SizedBox(height: 20,),

              Pinput(
                length: 6,
                // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onChanged: (value){
                  code= value;
                },

              ),


              const SizedBox(height: 60,),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(onPressed: () async {
                  setState(() {
                    isVerifying = true;
                  });
                  try{
                    // Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: ForgotPassMobileVerify.verify,
                        smsCode: code);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    // Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          ForgetPass(
                            mobileNumber: widget.mobileNumber,
                          ),),
                    );
                    Fluttertoast.showToast(
                        msg: "Mobile Verification Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  catch(e){
                    print("Wrong OTP");
                    Fluttertoast.showToast(
                        msg: "Wrong OTP",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                  } finally{
                    // Verification process is complete, hide the loading indicator
                    setState(() {
                      isVerifying = false;
                    });
                  }

                  // Navigator.pushNamed(context, "otp");
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),

                  ),
                  child: isVerifying
                      ? CircularProgressIndicator() // Show loading indicator
                      : const Text('Verify Phone Number',
                    style: TextStyle(
                        color: Colors.white),),

                ),
              ),
              const SizedBox(height: 30,),

              Text(
                "Didn't recived OTP?",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
              GestureDetector(
                onTap: () {
                },
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

