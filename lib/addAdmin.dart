import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final _auth = FirebaseAuth.instance;

  String currentUser;

  String email, password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;

      if (user != null) {
        currentUser = user.email;
        print(user.email);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  'Admin Panel',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0))),
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0))),
                    labelText: 'password',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text('ADD'),
                onPressed: () async {
                  try {
                    final admin = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);

                    if (admin != null) {
                      print("worked");
                      Navigator.pushNamed(context, 'admin');
                    } else if (admin == null) {
                      print("failed");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
