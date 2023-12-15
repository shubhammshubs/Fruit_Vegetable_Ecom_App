// import 'package:flutter/material.dart';
// import '../APi/Display_User_info_API.dart';
//
// class LocationWidget extends StatefulWidget {
//   final String mobileNumber;
//
//   LocationWidget({required this.mobileNumber});
//   @override
//   _LocationWidgetState createState() => _LocationWidgetState();
// }
//
// class _LocationWidgetState extends State<LocationWidget> {
//   late Future<Map<String, dynamic>?> _userInfo;
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch user information when the widget initializes
//     _userInfo = ApiServiceaddress.fetchUserInfo(widget.mobileNumber);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Location',
//             style: TextStyle(
//               color: Colors.black54,
//               fontFamily: "NexaRegular",
//             ),
//           ),
//           SizedBox(height: 1),
//           FutureBuilder<Map<String, dynamic>?>(
//             future: _userInfo,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator(); // Display a loading indicator
//               } else if (snapshot.hasError) {
//                 return Text('Error loading user information');
//               } else if (!snapshot.hasData || snapshot.data == null) {
//                 return Text('User information not available.');
//               } else {
//                 // User information is available, display it
//                 final userInfo = snapshot.data!;
//                 return Row(
//                   children: [
//                     Icon(Icons.location_on, color: Colors.red),
//                     Text(
//                       '${userInfo['city']},${userInfo['state']}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
