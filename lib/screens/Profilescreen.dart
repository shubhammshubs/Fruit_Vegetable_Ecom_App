import 'dart:convert';

import 'package:ecom/HomePage1.dart';
import 'package:ecom/Screens/Home_screen.dart';
import 'package:ecom/User_Credentials/login_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class Profilescreen extends StatelessWidget {
  final String mobileNumber; // Make mobileNumber nullable
  Profilescreen({super.key, required this.mobileNumber});

  Future<Map<String, dynamic>?> fetchUserInfo(String mobileNumber) async {
    final apiUrl = 'https://apip.trifrnd.com/Fruits/vegfrt.php?apicall=readinfo';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'mobile': mobileNumber},
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // Handle the error
      print('Failed to fetch user information. Error: ${response.body}');
      return null;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(mobileNumber: mobileNumber),
              ),
            );

            // Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: (mobileNumber == null || mobileNumber!.isEmpty)
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Looks like you are not signed in...'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Sign In to continue'),
            ),
          ],
        ),
      )
          :LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<Map<String, dynamic>?>(
            // Fetch user information asynchronously
            future: fetchUserInfo(mobileNumber!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while fetching data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if there's an error
                return       Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Looks like you are not signed in...'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text('Sign In to continue'),
                      ),
                    ],
                  ),
                );

              } else if (!snapshot.hasData || snapshot.data == null) {
                // Display a message when no data is available
                return Text('User information not available.');
              } else {
                // User information is available, display it
                final userInfo = snapshot.data!;
                return (constraints.maxWidth > 600)
                    ? TwoColumnLayout(mobileNumber: mobileNumber!, userInfo: userInfo)
                    : SingleColumnLayout(mobileNumber: mobileNumber!, userInfo: userInfo);
              }
            },
          );
        },
      ),
    );
  }
}

class TwoColumnLayout extends StatelessWidget {
  final String mobileNumber;
  final Map<String, dynamic> userInfo;

  TwoColumnLayout({
    required this.mobileNumber,
    required this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/1.png'),
                    backgroundColor: Colors.white,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // Handle the "Edit Profile" action here
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Mobile ${mobileNumber}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Username: ${userInfo['username']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ProfileActions(mobileNumber: '${mobileNumber}'),
        ),
      ],
    );
  }
}

class SingleColumnLayout extends StatelessWidget {
  final String mobileNumber;
  final Map<String, dynamic> userInfo;

  SingleColumnLayout({
    required this.mobileNumber,
    required this.userInfo,

  });


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/1.png'),
                  backgroundColor: Colors.white,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      // Handle the "Edit Profile" action here
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${userInfo['username']}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Mobile : ${mobileNumber}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'email :${userInfo['email']}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Move the ProfileActions widget inside the SingleChildScrollView
          ProfileActions(mobileNumber: '${mobileNumber}'),
        ],
      ),
    );
  }
}


class ProfileActions extends StatelessWidget {
  final String mobileNumber;
  ProfileActions({
    required this.mobileNumber});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data, you might want to clear specific keys

    // Navigate to the login screen
    final snackBar = SnackBar(content: Text('Successfully Logout'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(mobileNumber: ''),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
        Divider(
        color: Colors.black12,
        thickness: 1.5,
          indent: 20,
          endIndent: 20,
      ),
          ListTile(
            leading: Icon(Icons.location_pin, color: Colors.green),
            title: Text('Manage Address'),
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.green),
          ),
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.green),
            title: Text('Payment Methods'),
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.green),
          ),
          // Add the rest of your ListTile items here
          ListTile(
            leading: Icon(Icons.attach_money,color: Colors.green,),
            title: Text('My Wallet'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard,color: Colors.green,),
            title: Text('My Coupons'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          ListTile(
            leading: Icon(Icons.settings,color: Colors.green,),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          ListTile(
            leading: Icon(Icons.help,color: Colors.green,),
            title: Text('Help Center'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          ListTile(
            leading: Icon(Icons.policy,color: Colors.green,),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.green),
            title: Text('Log out'),
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.green),
            onTap: () => _logout(context), // Trigger the logout function
          ),
          ListTile(
            leading: Icon(Icons.share,color: Colors.green,),
            title: Text('Invites Friends'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
        ],
      ),
    );
  }
}
