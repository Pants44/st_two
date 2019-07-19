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

  Future<TicketsList> loadTicketsList() async{
    String jsonString =
    await DefaultAssetBundle.of(context).loadString("assets/ticketdata-simplified.json");
    final jsonResponse = json.decode(jsonString);
    TicketsList ticketlist = new TicketsList.fromJson(jsonResponse);
    print(ticketlist.tickets[0].ticketid.toString());
    print("it should have ran");
    return ticketlist;
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
                    print(snapshot.data.tickets[index].ticketid.toString());
                  },
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Card(
                            child: Center(
                              child: Text(snapshot.data.tickets[index].priority.toString()),
                            ),
                          )
                        ),
                        Flexible(
                          flex: 6,
                          child:
                            Card(
                              child: ListTile(
                                leading: Text(snapshot.data.tickets[index].priority.toString()),
                                title: Text("Ticket " + snapshot.data.tickets[index].ticketid.toString() + " - " + snapshot.data.tickets[index].ticketname.toString()),
                              ),
                            )
                        )
                      ],
                    ),

                  ),
                );
              },
            )
                : Center(child: CircularProgressIndicator(),);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}