import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/screens/home.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/screens/ticket.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List jsondata;

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
        leading: BackButton(),
        title: Text(widget.title),
        actions: <Widget>[
          Hero(
            tag: 'logoappbar',
            child: Padding(
              padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                          title: 'Solution Tracker Two',
                        )),
                  );
                },
                child: Image(
                  image: AssetImage('assets/st22000.png'),
                ),
              )
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: loadTicketsList(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data.tickets.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    print('Open Ticket ' + snapshot.data.tickets[index].ticketid.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TicketPage(title: 'Ticket ' + snapshot.data.tickets[index].ticketid.toString() + ' - ' + snapshot.data.tickets[index].ticketname.toString(), ticket: snapshot.data.tickets[index])),
                      );
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text(snapshot.data.tickets[index].priority.toString()),
                      title: Text('Ticket ' + snapshot.data.tickets[index].ticketid.toString() + ' - ' + snapshot.data.tickets[index].ticketname.toString()),
                      subtitle: Text('Assigned to: ' + _whosAssigned(snapshot.data.tickets[index].resources)),
                      trailing: Text(snapshot.data.tickets[index].status.toString()),

                    ),
                  )
                );
              },
            )
                : Center(child: CircularProgressIndicator());
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }


  Future<TicketsList> loadTicketsList() async{
    String jsonString =
    await DefaultAssetBundle.of(context).loadString("assets/ticketdata.json");
    final jsonResponse = json.decode(jsonString);
    TicketsList ticketlist = new TicketsList.fromJson(jsonResponse);
    print('Ticket''s list loaded for Dashboard Screen');
    return ticketlist;
  }

  String _whosAssigned(List resourcelist){
    String resources="";
    for(var i = 0; i < resourcelist.length; i++){
      if(i == resourcelist.length-1){
        resources = resources + resourcelist[i].resourcename.toString();
      }else{
        resources = resources + resourcelist[i].resourcename.toString() + ", ";
      }

    }
    return resources;
  }
}