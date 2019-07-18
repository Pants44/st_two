import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/tickets.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List jsondata;

  Future<Ticket> loadTickets() async {
    String jsonString =
    await DefaultAssetBundle.of(context).loadString("assets/ticketdata-simplified.json");
    final jsonResponse = json.decode(jsonString);
    Ticket ticket = new Ticket.fromJson(jsonResponse);
    print(ticket.ticketname);
    print("it should have ran");
    return ticket;
  }

  String _whosAssigned(List resourcelist){
    String resources="";
    for(var i = 0; i < resourcelist.length; i++){
      print(i);
      if(i == resourcelist.length-1){
        resources = resources + resourcelist[i].resourcename.toString();
      }else{
        resources = resources + resourcelist[i].resourcename.toString() + ", ";
      }

    }
    return resources;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //this.loadTickets();
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
      body: FutureBuilder(
        future: loadTickets(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Card(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Center(
                            child: Text(snapshot.data.priority.toString()),
                          ),
                        )
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Text('Ticket ' + snapshot.data.ticketid.toString() + ' - ' + snapshot.data.ticketname.toString()),
                            Text('Assigned: ' + _whosAssigned(snapshot.data.resources)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}