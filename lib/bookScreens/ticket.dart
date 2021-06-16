import 'package:barcode_widget/barcode_widget.dart';
import 'package:busbooking/bookScreens/wheretogo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'buslist.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

String p, n, s;

Future<List<BookedUser>> _getBookedUsers() async {
  List<BookedUser> bookeduser = [];

  final db =
      await FirebaseFirestore.instance.collection('booked').get().then((datas) {
    datas.docs.forEach((element) {
      BookedUser booked = BookedUser(
        element.data()['Arrival'],
        element.data()['Atime'],
        element.data()['Ddate'],
        element.data()['Departure'],
        element.data()['DepartureTime'],
        element.data()['Price'],
        element.data()['busNo'],
        element.data()['Name'],
        element.data()['Phone'],
      );

      if (element.data()['Phone'] == p && element.data()['Name'] == n) {
        bookeduser.add(booked);
      }
    });
  });

  print(bookeduser.length);

  return bookeduser;
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  'Show Ticket',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )),
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                          ),
                          labelText: 'name',
                        ),
                        onChanged: (value) {
                          n = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                          ),
                          labelText: 'Phone',
                        ),
                        onChanged: (value) {
                          p = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screen()));
                            // print(db);
                          } catch (e) {}
                        },
                        child: Text('Show Ticket'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return (FutureBuilder(
      future: _getBookedUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.data);
        if (snapshot.data[0] == null) {
          print(snapshot.data.Name);
          return Container(child: Center(child: CircularProgressIndicator()));
          // ignore: missing_return
        } else {
          print(snapshot.data.Name);
          print(snapshot.data.Name);

          return (MaterialApp(
              home: Scaffold(
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
                          Text(snapshot.data.Name),
                          SizedBox(height: 10),
                          Text('Phone'),
                          Text(snapshot.data.Phone),
                          Text('id'),
                          //Text(s),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Booking code'),
                              SizedBox(width: 20),
                              BarcodeWidget(
                                barcode: Barcode
                                    .qrCode(), // Barcode type and settings
                                data: Text(snapshot.data.Name).data, // Content
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
          )));
        }
      },
    ));
  }
}

class BookedUser {
  final String Arrival;
  final String Departure;
  final String Ddate;
  final String DepartureTime;
  final String Price;
  final String busNo;
  final String Atime;
  final String Name;
  final String phone;

  BookedUser(this.Arrival, this.Departure, this.Ddate, this.Price, this.busNo,
      this.Atime, this.DepartureTime, this.Name, this.phone);
}
