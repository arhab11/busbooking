import 'package:busbooking/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBus extends StatefulWidget {
  @override
  _AddBusState createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
  String busNo;
  String Departure;
  String Arrival;
  String DepartureDate;
  String ArrivalTime;
  String DepartureTime;
  String price;
  String departure = 'Adama';
  String arrival = 'Adama';
  List<DropdownMenuItem> getItems(List<String> data) {
    List<DropdownMenuItem<String>> ditems = [];

    for (int i = 0; i < data.length; i++) {
      String city = data[i];
      var newItem = DropdownMenuItem(child: Text(city), value: city);

      ditems.add(newItem);
    }

    return ditems;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 600,
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
                        SizedBox(height: 10),
                        TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                            ),
                            labelText: 'Bus Number',
                          ),
                          onChanged: (value) {
                            busNo = value;
                          },
                        ),
                        SizedBox(height: 10),
                        Stack(
                          children: [
                            TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: departure,
                              items: getItems(destination),
                              onChanged: (value) {
                                setState(() {
                                  departure = value;
                                  Departure = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: arrival,
                              items: getItems(destination),
                              onChanged: (value) {
                                setState(() {
                                  arrival = value;
                                  Arrival = value;
                                });
                              },
                            ),
                          ],
                        ),
                        TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                            ),
                            labelText: 'Departure Date',
                          ),
                          onChanged: (value) {
                            DepartureDate = value;
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                            ),
                            labelText: 'Departure Time',
                          ),
                          onChanged: (value) {
                            DepartureTime = value;
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                            ),
                            labelText: 'Arrival Time',
                          ),
                          onChanged: (value) {
                            ArrivalTime = value;
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                            ),
                            labelText: 'Price',
                          ),
                          onChanged: (value) {
                            price = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                child: Text(
                  "Add Bus",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  List<String> names = [
                    'Arrival',
                    'Atime',
                    'Ddate',
                    'Departure',
                    'DepartureTime',
                    'Price',
                    'busNo'
                  ];
                  List<String> values = [
                    Arrival,
                    ArrivalTime,
                    DepartureDate,
                    Departure,
                    DepartureTime,
                    price,
                    busNo,
                  ];

                  Map<String, dynamic> save = Map.fromIterables(names, values);

                  final dbb = await FirebaseFirestore.instance
                      .collection('buses')
                      .add(save);

                  Navigator.pushNamed(context, 'wheretogo');
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
    ));
  }
}
