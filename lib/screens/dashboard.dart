import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List jsondata;

  Future<List> loadTickets() async {
    String jsonString =
    await DefaultAssetBundle.of(context).loadString("assets/ticketdata.json");
    var jsondata = json.decode(jsonString);
    return jsondata["ticket"];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loadTickets();
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
        ),

      ),
      body: FutureBuilder<List>(
        future: loadTickets(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
          }
          return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      print(snapshot.data[index]["ticketid"].toString());
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        child: Text("Ticket " + snapshot.data[index]["ticketid"].toString() + " - " + snapshot.data[index]["ticketname"].toString()),
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}