import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Book extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'book'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Bus> buses = [];
  Future<List<Bus>> _getUsers() async {
    final db = await FirebaseFirestore.instance
        .collection('buses')
        .get()
        .then((datas) {
      datas.docs.forEach((element) {
        Bus bus = Bus(
            element.data()['Arrival'],
            element.data()['Departure'],
            element.data()['Ddate'],
            element.data()['Price'],
            element.data()['busNo'],
            element.data()['Atime']);

        buses.add(bus);
      });
    });

    print(buses.length);

    return buses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Buses',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Container(
                  color: Color(0xFFE0D0D0),
                  child: FutureBuilder(
                    future: _getUsers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot.data);
                      if (snapshot.data == null) {
                        return Container(
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                  ),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    height: 400,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Center(
                                        child:
                                            Text(snapshot.data[index].busNo)),
                                  ),
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Departure',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Arrival',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          // Text(snapshot.data[index].Arrival),
                                          // Text(snapshot.data[index].Departure),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data[index].Ddate,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            snapshot.data[index].Atime,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                          // Text(snapshot.data[index].Arrival),
                                          // Text(snapshot.data[index].Departure),
                                        ],
                                      ),
                                      Text(snapshot.data[index].Price + " birr")
                                    ],
                                  ),
                                  subtitle:
                                      Text(snapshot.data[index].Departure),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                                snapshot.data[index])));
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class DetailPage extends StatelessWidget {
  final Bus user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.busNo),
      ),
    );
  }
}

class Bus {
  final String Arrival;
  final String Departure;
  final String Ddate;
  final String Price;
  final String busNo;
  final String Atime;

  Bus(this.Arrival, this.Departure, this.Ddate, this.Price, this.busNo,
      this.Atime);
}
