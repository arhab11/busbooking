import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<ListDisplay> {
  String id;
  String no;
  String busname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getdata();
  }

  Future<List<String>> getdata() async {
    final fb = FirebaseFirestore.instance;
    List<String> mylist = [];

    print('wow');
    try {
      final db = await FirebaseFirestore.instance
          .collection('book')
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('images/bus.jpg'),
              ),
              Text(
                '$busname',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '$id',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '$no',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
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
