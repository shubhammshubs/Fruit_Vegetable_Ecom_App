import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the user's location display here
    return const Padding(
      padding: EdgeInsets.all(16.0),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('Location',
          style: TextStyle(color: Colors.black54,
            fontFamily: "NexaRegular",
          ),),
          SizedBox(height: 1,),
          Row(
            children: [
              Icon(Icons.location_on,color: Colors.green,),
              Text(
                'Pune City,India ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
