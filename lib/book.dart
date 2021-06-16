import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:busbooking/constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookNow extends StatefulWidget {
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  String deparcher = 'AA';
  String arival = 'AA';
  String _bus = 'toyota';
  String name = '';
  String phone = '';
  String arvi = '';
  String depar = '';
  String date = '';
  bool isThereBus = false;
  List<String> temp = [];

  List<DropdownMenuItem> getItems(List<String> data) {
    List<DropdownMenuItem<String>> ditems = [];

    for (int i = 0; i < data.length; i++) {
      String city = data[i];
      var newItem = DropdownMenuItem(child: Text(city), value: city);

      ditems.add(newItem);
    }

    return ditems;
  }

  Widget map() {
    const _intianroute = CameraPosition(
        target: LatLng(13.553358276484452, 39.49927344645997), zoom: 11.5);
    return (Container(
      child: GoogleMap(
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _intianroute,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Book'),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                decoration: new BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60.0),
                    )),
                child: map(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'name',
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                  onChanged: (value) {
                    phone = value;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('dep: '),
                  Text('arv: '),
                ],
              ),
              /* Text('Bus'),
                DropdownButton(
                  icon: const Icon(Icons.search),
                  items: getItems(bus),
                  value: _bus,
                  onChanged: (value) {
                    setState(() {
                      _bus = value;
                    });
                  },
                ),*/
              ElevatedButton(
                  onPressed: () async {
                    /* try {
                        final user = await _auth.createUserWithEmailAndPassword(
                            email: name, password: phone);
                        if (user != null) {
                          print("wowowo");
                        } else {
                          print("faild");
                        }
                      } catch (e) {
                        print(e);
                      }*/
                    /* List<String> names = ['model', 'seat', 'year'];
                      List<dynamic> ages = ["toyota", 60, 2000];

                      Map<String, dynamic> map = Map.fromIterables(names, ages);*/
                    /*  Map<String, dynamic> js = Map.fromIterable(myfile);
                      print("js");*/
                    List<String> mylist = [];
                  },
                  child: Text('Search')),
            ],
          ),
        ),
      ),
    );
  }
}
