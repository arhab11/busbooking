import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  String password;
  String email;
  Color _errorcolor = Colors.white;
  Color _normalcolor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Manage App'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
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
                  Text('Admin is: admin@gmail.com and pass 1234567'),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        ),
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
                        fillColor: _errorcolor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        ),
                        labelText: 'password',
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Sign IN',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      try {
                        /*final user = await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);*/

                        final admin = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);

                        if (admin != null) {
                          //print("worked");
                          Navigator.pushNamed(context, 'admin');
                        } else if (admin == null) {
                          print("failed");
                        }
                      } catch (e) {
                        print(e);
                        setState(() {
                          _errorcolor = Colors.redAccent;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      primary: Colors.red,
                      onPrimary: Colors.white,
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
      ),
    ));
  }
}
