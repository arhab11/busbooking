import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminBook extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<AdminBook> {
  String id;
  String no;
  String busname;
  List<String> mylist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getdata();
  }

  Future<List<String>> getdata() async {
    final fb = FirebaseFirestore.instance;

    print('wow');
    try {
      final db = await FirebaseFirestore.instance
          .collection('books')
          .get()
          .then((data) {
        data.docs.forEach((element) {
          busname = element['Bus'];
          id = element['id'];
          no = element['Price'];
          mylist.add(busname);
          mylist.add(id);
          mylist.add(no);
        });
      });

      print(mylist.length);
      for (int i = 0; i < mylist.length; i++) {}
    } catch (e) {
      print(e);
    }

    return mylist;
  }

  Widget mybody(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Manage Booking"),
        ),
        body: Container(
          child: ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              title: Text(mylist.length.toString()),
              subtitle: Text(mylist.length.toString()),
            );
          }),
        ));
  }

  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
        home: FutureBuilder(
      future: getdata(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('error');
          return (Text('Error'));
        } else if (snapshot.hasData) {
          return mybody(context);
        } else {
          return (Center(child: CircularProgressIndicator()));
        }
      },
    ));
  }
}
