import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          Image.asset('images/bytebank_logo.png'),
          Container(
            height: 100,
            width: 120,
            color: Colors.lightBlue,
            child: Column(
              children: [
                Icon(Icons.people),
                Text('Contacts'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
