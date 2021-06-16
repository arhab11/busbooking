import 'dart:io';

import 'package:busbooking/result.dart';
import 'package:flutter/material.dart';

class Book_Manage extends StatelessWidget {
  Result result;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('bus booking'),
          leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, 'adminsignin');
              /** Do something */
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                OutlinedButton.icon(
                  icon: Icon(Icons.star_outline),
                  label: Text(
                    "Book Now",
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'book');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(30),
                    side: BorderSide(width: 2.0, color: Colors.blue),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                OutlinedButton.icon(
                  icon: Icon(Icons.star_outline),
                  label: Text(
                    "Manage Booking",
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'manage');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(30),
                    side: BorderSide(width: 2.0, color: Colors.blue),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
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
