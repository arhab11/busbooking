import 'package:flutter/material.dart';
import 'package:busbooking/constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String departure;
String arrival;

class Where_To_Go extends StatefulWidget {
  @override
  _Where_To_GoState createState() => _Where_To_GoState();

  static String departurereturn() {
    return departure;
  }

  static String arrivalreturn() {
    return arrival;
  }
}

class _Where_To_GoState extends State<Where_To_Go> {
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
        home: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('bus booking'),
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, 'adminsignin');
            /** Do something */
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 225,
              decoration: new BoxDecoration(
                  color: Color(0xFFF36C1F),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60.0),
                  )),
              child: Center(
                  child: Text(
                'Where to go ?',
                style: TextStyle(fontSize: 30, color: Colors.white),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Departure: '),
                      Row(
                        children: [
                          Icon(Icons.directions_car),
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton<String>(
                            value: departure,
                            items: getItems(destination),
                            onChanged: (value) {
                              setState(() {
                                departure = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Text('Arival: '),
                      Row(
                        children: [
                          Icon(Icons.directions_car),
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton<String>(
                            value: arrival,
                            items: getItems(destination),
                            onChanged: (value) {
                              setState(() {
                                arrival = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: ElevatedButton(
                          child: Text(
                            "Find Bus",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'buslist');
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.home,
                                          color: Color(0xFFF36C1F),
                                        ),
                                        Text(
                                          'HOME',
                                          style: TextStyle(
                                            color: Color(0xFFF36C1F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print("tapped on container");
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.sticky_note_2_outlined,
                                          color: Color(0xFFF36C1F),
                                        ),
                                        Text(
                                          'Ticket',
                                          style: TextStyle(
                                            color: Color(0xFFF36C1F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, 'ticket');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
