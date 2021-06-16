import 'package:barcode_widget/barcode_widget.dart';
import 'package:busbooking/bookScreens/buslist.dart';
import 'package:busbooking/bookScreens/wheretogo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  Future<List<Bus>> _getUsers() async {
    List<Bus> buses = [];

    final dbb = await FirebaseFirestore.instance
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
