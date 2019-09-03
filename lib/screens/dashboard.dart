import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/screens/ticket.dart';
import 'package:st_two/data/processdropdowns.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  String _resourceSelection = '0';
  String _statusSelection = '0';
  String _customerSelection = '0';
  List<DropdownMenuItem<String>> resourcedropdown = [];
  List<DropdownMenuItem<String>> statusdropdown = [];
  List<DropdownMenuItem<String>> customerdropdown = [];

  TextEditingController tecSearch = TextEditingController();
  var searchFocusNode = FocusNode();

  String filter;
  int _selectedIndex = 0;
  List jsondata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFilterDropdowns();
    tecSearch.addListener(() {
      setState(() {
        filter = tecSearch.text;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tecSearch.dispose();
    searchFocusNode.dispose();
    super.dispose();
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
                    _asyncConfirmDialog(context);
                  },
                ),),
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
                                          title: 'View Ticket',
                                          ticket: snapshot.data.tickets[index],
                                          readonly: true,),),
                                );
                              },
                              child: Card(
                                elevation: 5,
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
                                      .contains(filter.toLowerCase()) ||
                                  snapshot.data.tickets[index].ticketid
                                      .toString()
                                      .contains(filter.toLowerCase())
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
                                    elevation: 5,
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

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filters'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButton<String>(
                isDense: true,
                value: _customerSelection,
                onChanged: (String newValue) {
                  setState(() {
                    _customerSelection = newValue;
                  });

                  print(_customerSelection);
                },
                items: customerdropdown,
              ),
              DropdownButton<String>(
                isDense: true,
                value: _resourceSelection,
                onChanged: (String newValue) {
                  setState(() {
                    _resourceSelection = newValue;
                  });

                  print(_resourceSelection);
                },
                items: resourcedropdown,
              ),
              DropdownButton<String>(
                isDense: true,
                value: _statusSelection,
                onChanged: (String newValue) {
                  setState(() {
                    _statusSelection = newValue;
                  });

                  print(_statusSelection);
                },
                items: statusdropdown,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  void loadFilterDropdowns() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/resourcedropdowndata.json");
    final jsonResponse = json.decode(jsonString);
    ResourcesListdd resourceslist = new ResourcesListdd.fromJson(jsonResponse);

    String jsonString2 = await DefaultAssetBundle.of(context)
        .loadString("assets/statusdropdowndata.json");
    final jsonResponse2 = json.decode(jsonString2);
    StatusListdd statuslist = new StatusListdd.fromJson(jsonResponse2);

    String jsonString3 = await DefaultAssetBundle.of(context)
        .loadString("assets/customerdropdowndata.json");
    final jsonResponse3 = json.decode(jsonString3);
    CustomerListdd customerlist = new CustomerListdd.fromJson(jsonResponse3);

    for (var i = 0; i < resourceslist.resources.length; i++) {
      resourcedropdown.add(DropdownMenuItem(
        value: resourceslist.resources[i].resourceid,
        child: Text(resourceslist.resources[i].resourcename.toString()),
      ));
    }

    for (var i = 0; i < statuslist.statusi.length; i++) {
      statusdropdown.add(DropdownMenuItem(
        value: statuslist.statusi[i].statusid,
        child: Text(statuslist.statusi[i].status.toString()),
      ));
    }

    for (var i = 0; i < customerlist.customers.length; i++) {
      customerdropdown.add(DropdownMenuItem(
        value: customerlist.customers[i].customerid,
        child: Text(customerlist.customers[i].customername.toString()),
      ));
    }
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
