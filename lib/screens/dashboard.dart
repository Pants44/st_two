import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/screens/home.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/screens/ticket.dart';
import 'package:st_two/screens/dashboardfilter.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController tecSearch = TextEditingController();
  var searchFocusNode = FocusNode();

  String filter;
  int _selectedIndex = 0;
  List jsondata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tecSearch.addListener(() {
      setState(() {
        filter = tecSearch.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: TextField(
          controller: tecSearch,
          focusNode: searchFocusNode,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Search Tickets',
          ),
        ),
        actions: <Widget>[
          Hero(
            tag: 'logoappbar',
            child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 5),
                child: GestureDetector(
                  child: Icon(Icons.filter_list),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DashboardFilter(title: 'Filter'),
                          fullscreenDialog: true,),
                    );
                  },
                )),
          )
        ],
      ),
      body: FutureBuilder(
        future: loadTicketsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.tickets.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                              onTap: () {
                                print('Open Ticket ' +
                                    snapshot.data.tickets[index].ticketid
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TicketPage(
                                          title: 'Ticket ' +
                                              snapshot
                                                  .data.tickets[index].ticketid
                                                  .toString() +
                                              ' - ' +
                                              snapshot.data.tickets[index]
                                                  .ticketname
                                                  .toString(),
                                          ticket:
                                              snapshot.data.tickets[index])),
                                );
                              },
                              child: Card(
                                child: ListTile(
                                  leading: Text(snapshot
                                      .data.tickets[index].priority
                                      .toString()),
                                  title: Text('Ticket ' +
                                      snapshot.data.tickets[index].ticketid
                                          .toString() +
                                      ' - ' +
                                      snapshot.data.tickets[index].ticketname
                                          .toString()),
                                  subtitle: Text('Assigned to: ' +
                                      _whosAssigned(snapshot
                                          .data.tickets[index].resources)),
                                  trailing: Text(snapshot
                                      .data.tickets[index].status
                                      .toString()),
                                ),
                              ))
                          : snapshot.data.tickets[index].ticketname
                                      .contains(filter) ||
                                  snapshot.data.tickets[index].ticketid
                                      .toString()
                                      .contains(filter)
                              ? GestureDetector(
                                  onTap: () {
                                    print('Open Ticket ' +
                                        snapshot.data.tickets[index].ticketid
                                            .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TicketPage(
                                              title: 'Ticket ' +
                                                  snapshot.data.tickets[index]
                                                      .ticketid
                                                      .toString() +
                                                  ' - ' +
                                                  snapshot.data.tickets[index]
                                                      .ticketname
                                                      .toString(),
                                              ticket: snapshot
                                                  .data.tickets[index])),
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: Text(snapshot
                                          .data.tickets[index].priority
                                          .toString()),
                                      title: Text('Ticket ' +
                                          snapshot.data.tickets[index].ticketid
                                              .toString() +
                                          ' - ' +
                                          snapshot
                                              .data.tickets[index].ticketname
                                              .toString()),
                                      subtitle: Text('Assigned to: ' +
                                          _whosAssigned(snapshot
                                              .data.tickets[index].resources)),
                                      trailing: Text(snapshot
                                          .data.tickets[index].status
                                          .toString()),
                                    ),
                                  ))
                              : Container();
                    },
                  )
                : Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.clear),
            title: Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;

    switch (index) {
      case 0:
        {
          FocusScope.of(context).unfocus();
          FocusScope.of(context).requestFocus(searchFocusNode);
        }
        break;

      case 1:
        {
          FocusScope.of(context).unfocus();
          tecSearch.text = "";
        }
        break;

      default:
        {}
        break;
    }

    setState(() {});
  }

  Future<TicketsList> loadTicketsList() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/ticketdata.json");
    final jsonResponse = json.decode(jsonString);
    TicketsList ticketlist = new TicketsList.fromJson(jsonResponse);
    print('Ticket' 's list loaded for Dashboard Screen');
    return ticketlist;
  }

  String _whosAssigned(List resourcelist) {
    String resources = "";
    for (var i = 0; i < resourcelist.length; i++) {
      if (i == resourcelist.length - 1) {
        resources = resources + resourcelist[i].resourcename.toString();
      } else {
        resources = resources + resourcelist[i].resourcename.toString() + ", ";
      }
    }
    return resources;
  }
}
