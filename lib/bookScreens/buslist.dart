import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:busbooking/bookScreens/wheretogo.dart';
import 'package:secure_random/secure_random.dart';

class BusList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Buses'),
    );
  }
}

String lablename = 'Name';
String labelphone = "Phone Number";
String errorlable = 'Value can not be empty';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Bus>> _getUsers() async {
    List<Bus> buses = [];

    final db = await FirebaseFirestore.instance
        .collection('buses')
        .get()
        .then((datas) {
      datas.docs.forEach((element) {
        Bus bus = Bus(
          element.data()['Arrival'],
          element.data()['Atime'],
          element.data()['Ddate'],
          element.data()['Departure'],
          element.data()['DepartureTime'],
          element.data()['Price'],
          element.data()['busNo'],
        );

        String d = Where_To_Go.departurereturn();
        String a = Where_To_Go.arrivalreturn();

        if (element.data()['Departure'] == d &&
            element.data()['Arrival'] == a) {
          buses.add(bus);
        }
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
                  color: Colors.white,
                  child: FutureBuilder(
                    future: _getUsers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot.data);
                      if (snapshot.data == null) {
                        return Container(
                            child: Center(child: CircularProgressIndicator()));
                        // ignore: missing_return
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
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Expanded(
                                      flex: 1,
                                      child: Container(
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
                                            child: Text(
                                                snapshot.data[index].busNo)),
                                      ),
                                    ),
                                    title: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Departurer',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            //SizedBox(width: 15),

                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Arrivalr',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ),

                                            SizedBox(width: 15),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'D-time',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ),

                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'A-Time',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            // Text(snapshot.data[index].Arrival),
                                            // Text(snapshot.data[index].Departure),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                snapshot.data[index].Price,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                snapshot.data[index].Arrival,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                snapshot
                                                    .data[index].DepartureTime,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                snapshot.data[index].Atime,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      'price: ' +
                                          snapshot.data[index].Departure +
                                          " birr",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      textAlign: TextAlign.end,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                  snapshot.data[index],
                                                  snapshot,
                                                  index)));
                                    },
                                  ),
                                ),
                              );
                            });
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

String name = '';
String phone = '';
var secureRandom = SecureRandom();
String s = secureRandom.nextString(length: 10);

class DetailPage extends StatelessWidget {
  final Bus user;
  final snapshot;
  final index;
  DetailPage(this.user, this.snapshot, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.busNo),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100.0),
              ),
            ),
            child: Center(
              child: Text(
                'INFO',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
              ),
              child: ListTile(
                leading: Expanded(
                  flex: 1,
                  child: Container(
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
                    child: Center(child: Text(snapshot.data[index].busNo)),
                  ),
                ),
                title: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Departurer',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                        //SizedBox(width: 15),

                        Expanded(
                          flex: 1,
                          child: Text(
                            'Arrivalr',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),

                        SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'D-time',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),

                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'A-Time',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                        // Text(snapshot.data[index].Arrival),
                        // Text(snapshot.data[index].Departure),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            snapshot.data[index].Price,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            snapshot.data[index].Arrival,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            snapshot.data[index].DepartureTime,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            snapshot.data[index].Atime,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Text(
                  'price: ' + snapshot.data[index].Departure + " birr",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.end,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => DetailPage(
                              snapshot.data[index], snapshot, index)));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Passenger info'),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: lablename,
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: labelphone,
                      ),
                      onChanged: (value) {
                        phone = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            child: Text(
              'Book ticket',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async {
              if (name.isEmpty && phone.isEmpty) {
                print('error');
              } else {
                List<String> names = [
                  'Phone',
                  'Name',
                  'id',
                  'Departure',
                  'Arrival',
                  'Dtime',
                  'Ddate',
                  'Atime',
                ];
                List<String> values = [
                  phone,
                  name,
                  '',
                  snapshot.data[index].Departure,
                  snapshot.data[index].Arrival,
                  snapshot.data[index].DepartureTime,
                  snapshot.data[index].Ddate,
                  snapshot.data[index].Atime,
                ];

                Map<String, dynamic> save = Map.fromIterables(names, values);

                try {
                  /*  final db = await FirebaseFirestore.instance
                    .collection('currentBook')
                    .doc('1')
                    .update(save);*/

                  final dbbb = await FirebaseFirestore.instance
                      .collection('booked')
                      .add(save);

                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => BookTik()));
                } catch (e) {}
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
    );
  }
}

class BookTik extends StatefulWidget {
  @override
  _BookTikState createState() => _BookTikState();
}

class _BookTikState extends State<BookTik> {
  String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100.0),
              ),
            ),
            child: Center(
              child: Text(
                'INFO',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name'),
                    Text(name),
                    SizedBox(height: 10),
                    Text('Phone'),
                    Text(phone),
                    Text('id'),
                    Text(s),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Booking code'),
                        SizedBox(width: 20),
                        BarcodeWidget(
                          barcode:
                              Barcode.qrCode(), // Barcode type and settings
                          data: Text(s).data, // Content
                          width: 200,
                          height: 200,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Bus {
  final String Arrival;
  final String Departure;
  final String Ddate;
  final String DepartureTime;
  final String Price;
  final String busNo;
  final String Atime;

  Bus(this.Arrival, this.Departure, this.Ddate, this.Price, this.busNo,
      this.Atime, this.DepartureTime);
}
