import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List jsondata;

  Future<String> _retrieveData() async {
    return await rootBundle.loadString("assets/ticketdata.json");
  }

  Future loadTickets() async {
    String jsonString = await _retrieveData();

    jsondata = json.decode(jsonString);
    print(jsondata);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 5),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Image(
              image: AssetImage('assets/st22000.png'),
            ),
          )
        )
      ),
      body: Center(
        child: ListView.builder(
          itemCount: jsondata == null ? 0 : jsondata.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Text(jsondata[index]["ticket"]["ticketname"]),
            );
          },
        )
      ),
    );
  }
}