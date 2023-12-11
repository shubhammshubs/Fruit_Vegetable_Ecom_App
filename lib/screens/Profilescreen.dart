import 'package:ecom/HomePage1.dart';
import 'package:ecom/Screens/Home_screen.dart';
import 'package:ecom/User_Credentials/login_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Profilescreen extends StatelessWidget {
//   final String mobileNumber;
//    Profilescreen({super.key,
//     required this.mobileNumber});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text(
//           'Profile',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 600) {
//             // Use a two-column layout for larger screens
//             return TwoColumnLayout(mobileNumber: mobileNumber,);
//           } else {
//             // Use a single-column layout for smaller screens
//             return SingleColumnLayout(mobileNumber: mobileNumber,);
//           }
//         },
//       ),
//     );
//   }
// }

class Profilescreen extends StatelessWidget {
  final String? mobileNumber; // Make mobileNumber nullable
  Profilescreen({super.key, required this.mobileNumber});

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
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (mobileNumber != null && mobileNumber!.isNotEmpty) {
            // User is logged in, show the profile
            if (constraints.maxWidth > 600) {
              return TwoColumnLayout(mobileNumber: mobileNumber!);
            } else {
              return SingleColumnLayout(mobileNumber: mobileNumber!);
            }
          } else {
            // User is not logged in, show "Sign In to continue" button
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign In to continue'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Sign In'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class TwoColumnLayout extends StatelessWidget {
  final String mobileNumber;
  TwoColumnLayout({
    required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                  'Shubham Mahajan Mobile ${mobileNumber}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ProfileActions(mobileNumber: '${mobileNumber}',),
        ),
      ],
    );
  }
}

class SingleColumnLayout extends StatelessWidget {
  final String mobileNumber;

  SingleColumnLayout({
    required this.mobileNumber,
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
            'Shubham Mahajan ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'mobile : ${mobileNumber}',
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
