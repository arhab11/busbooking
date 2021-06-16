import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/face.jpg'),
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
