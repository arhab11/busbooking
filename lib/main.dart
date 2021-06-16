import 'package:busbooking/Admin.dart';
import 'package:busbooking/addAdmin.dart';
import 'package:busbooking/adminsignin.dart';
import 'package:busbooking/bookScreens/addbus.dart';
import 'package:busbooking/bookScreens/ticket.dart';
import 'package:busbooking/bookScreens/wheretogo.dart';
import 'package:busbooking/manage.dart';
import 'package:flutter/material.dart';
import 'package:busbooking/welcomepage.dart';
import 'package:busbooking/BookAndManage.dart';
import 'package:busbooking/book.dart';
import 'package:firebase_core/firebase_core.dart';

import 'adminBooks.dart';
import 'bookScreens/buslist.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData) {
            return MaterialApp(
              initialRoute: 'wheretogo',
              routes: {
                'welcomepage': (context) => WelcomePage(),
                'bookmanage': (context) => Book_Manage(),
                'book': (context) => BookNow(),
                'manage': (context) => ListDisplay(),
                'admin': (context) => AdminPage(),
                'adminsignin': (context) => SignIn(),
                'addadmin': (context) => AddAdmin(),
                'wheretogo': (context) => Where_To_Go(),
                'buslist': (context) => BusList(),
                'addbus': (context) => AddBus(),
                'ticket': (contex) => Ticket()
              },
              home: Scaffold(
                body: SafeArea(
                  child: Text(''),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
