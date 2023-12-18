import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../APi/Add_To_Cart_API.dart';
import '../APi/Display_User_info_API.dart';
import '../HomePage1.dart';
import '../User_Credentials/login_Screen.dart';
import '../widgets/AddressPopUp.dart';
import 'Check_Out_Screen/Delivery_Address.dart';
import 'ProfilePage_Screens/Manage_Address.dart';  // Import ApiService

class Profilescreen extends StatelessWidget {
  final String mobileNumber;

  Profilescreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: (mobileNumber == null || mobileNumber!.isEmpty)
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Looks like you are not signed in...'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Sign In to continue'),
            ),
          ],
        ),
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<Map<String, dynamic>?>(
            // Fetch user information asynchronously using ApiService
            future: ApiServiceaddress.fetchUserInfo(mobileNumber),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while fetching data
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if there's an error
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Looks like you are not signed in...'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Sign In to continue'),
                      ),
                    ],
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                // Display a message when no data is available
                return const Text('User information not available.');
              } else {
                // User information is available, display it
                final userInfo = snapshot.data!;
                return (constraints.maxWidth > 600)
                    ? TwoColumnLayout(
                  mobileNumber: mobileNumber!,
                  userInfo: userInfo,
                )
                    : SingleColumnLayout(
                  mobileNumber: mobileNumber!,
                  userInfo: userInfo,
                );
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
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Username: ${userInfo['username']}',
                    style: const TextStyle(
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
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${userInfo['username']}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Mobile : $mobileNumber',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'email :${userInfo['email']}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text(
          //   '${userInfo['city']},${userInfo['state']}',
          //   style: const TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

          // Move the ProfileActions widget inside the SingleChildScrollView
          ProfileActions(mobileNumber: mobileNumber),
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
    final snackBar = const SnackBar(content: Text('Successfully Logout'));
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
        const Divider(
        color: Colors.black12,
        thickness: 1.5,
          indent: 20,
          endIndent: 20,
      ),
        ListTile(
          leading: Icon(Icons.location_pin, color: Colors.green),
          title: Text('Manage Address'),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.green),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                // DeliveryAddressPage(),
                    ManageAddress(mobileNumber: mobileNumber),
              ),
            );
          },
        ),

      ListTile(
        leading: Icon(Icons.credit_card, color: Colors.green),
        title: Text('Manage Address'),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.green),
        // onTap: () {
        //   // Use the addressInfo here
        //   AddressPopup.showAddressDialog(context, mobileNumber,);
        // },
      ),
          // Add the rest of your ListTile items here
          const ListTile(
            leading: Icon(Icons.attach_money,color: Colors.green,),
            title: Text('My Wallet'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          const ListTile(
            leading: Icon(Icons.card_giftcard,color: Colors.green,),
            title: Text('My Coupons'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          const ListTile(
            leading: Icon(Icons.settings,color: Colors.green,),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          const ListTile(
            leading: Icon(Icons.help,color: Colors.green,),
            title: Text('Help Center'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          const ListTile(
            leading: Icon(Icons.policy,color: Colors.green,),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.green),
            title: const Text('Log out'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.green),
            onTap: () => _logout(context), // Trigger the logout function
          ),
          const ListTile(
            leading: Icon(Icons.share,color: Colors.green,),
            title: Text('Invites Friends'),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.green,),
          ),
        ],
      ),
    );
  }
}
