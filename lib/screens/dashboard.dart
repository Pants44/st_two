import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/screens/ticket.dart';
import 'package:st_two/data/processdropdowns.dart';

enum ConfirmAction { CANCEL, ACCEPT }

String customerfilter;
String resourcefilter;
String statusfilter;
String _customerSelection = '0';
String _resourceSelection = '0';
String _statusSelection = '0';
int biggestResourceCount = 0;

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
    customerfilter = null;
    resourcefilter = null;
    statusfilter = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customerfilter = null;
    resourcefilter = null;
    statusfilter = null;
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
                  _asyncConfirmDialog(context).then((_) => setState(() {}));
                },
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder<TicketsList>(
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
                                      readonly: true,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: Text(
                                    snapshot.data.tickets[index].priorityname
                                        .toString(),
                                  ),
                                  title: Text(
                                    'Ticket ' +
                                        snapshot.data.tickets[index].ticketid
                                            .toString() +
                                        ' - ' +
                                        snapshot.data.tickets[index].ticketname
                                            .toString(),
                                  ),
                                  subtitle: Text(
                                    'Assigned to: ' +
                                        _whosAssigned(snapshot
                                            .data.tickets[index].resources),
                                  ),
                                  trailing: Text(
                                    snapshot.data.tickets[index].status
                                        .toString(),
                                  ),
                                ),
                              ),
                            )
                          : snapshot.data.tickets[index].ticketname
                                      .contains(filter.toLowerCase()) ||
                                  snapshot.data.tickets[index].ticketid
                                      .toString()
                                      .contains(filter.toLowerCase())
                              ? GestureDetector(
                                  onTap: () {
                                    print(
                                      'Open Ticket ' +
                                          snapshot.data.tickets[index].ticketid
                                              .toString(),
                                    );
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
                                            ticket:
                                                snapshot.data.tickets[index]),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      leading: Text(
                                        snapshot
                                            .data.tickets[index].priorityname
                                            .toString(),
                                      ),
                                      title: Text(
                                        'Ticket ' +
                                            snapshot
                                                .data.tickets[index].ticketid
                                                .toString() +
                                            ' - ' +
                                            snapshot
                                                .data.tickets[index].ticketname
                                                .toString(),
                                      ),
                                      subtitle: Text(
                                        'Assigned to: ' +
                                            _whosAssigned(snapshot
                                                .data.tickets[index].resources),
                                      ),
                                      trailing: Text(
                                        snapshot.data.tickets[index].status
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
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
        return MyDialog();
      },
    );
  }

  Future<void> loadTicket() async {
    final sci = ServerConnectionInfo();

    var jsonString = await http.get(sci.serverreqaddress + '/tickets/2');
    final jsonResponse = json.decode(jsonString.body.toString());
    Ticket ticket = new Ticket.fromJson(jsonResponse);

    /*//  removes customer not selected by filter
    if (customerfilter != null && customerfilter != '0') {
      print('cust filter fired');
      ticketslist.tickets
          .removeWhere((item) => item.customerid.toString() != customerfilter);
    }

    //  removes resources not selected by filter
    //  code is different because there can be multiple resources per ticket.
    //  Normal logic would remove to much if another developer was on the ticket
    if (resourcefilter != null && resourcefilter != '0') {
      ticketslist.tickets.removeWhere((item) => item.resources
          .toList()
          .any((test) => test.resourceid.toString() == resourcefilter)
          ? false
          : true);
    }

    // remove ticket's with status not selected by filter
    if (statusfilter != null && statusfilter != '0') {
      ticketslist.tickets
          .removeWhere((item) => item.statusid.toString() != statusfilter);
    }*/

    return ticket;
  }

  Future<TicketsList> loadTicketsList() async {
    final sci = ServerConnectionInfo();

    var jsonString = await http.get(sci.serverreqaddress + '/tickets');
    final jsonResponse = json.decode(jsonString.body.toString());
    TicketsList ticketslist = new TicketsList.fromJson(jsonResponse);

    /*//  removes customer not selected by filter
    if (customerfilter != null && customerfilter != '0') {
      print('cust filter fired');
      ticketslist.tickets
          .removeWhere((item) => item.customerid.toString() != customerfilter);
    }

    //  removes resources not selected by filter
    //  code is different because there can be multiple resources per ticket.
    //  Normal logic would remove to much if another developer was on the ticket
    if (resourcefilter != null && resourcefilter != '0') {
      ticketslist.tickets.removeWhere((item) => item.resources
          .toList()
          .any((test) => test.resourceid.toString() == resourcefilter)
          ? false
          : true);
    }

    // remove ticket's with status not selected by filter
    if (statusfilter != null && statusfilter != '0') {
      ticketslist.tickets
          .removeWhere((item) => item.statusid.toString() != statusfilter);
    }*/

    return ticketslist;
  }

  /*Future<TicketsList> loadTicketsList() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/ticketdata.json");
    final jsonResponse = json.decode(jsonString);
    TicketsList ticketlist = new TicketsList.fromJson(jsonResponse);
    print('Ticket' 's list loaded for Dashboard Screen');

    //  removes customer not selected by filter
    if (customerfilter != null && customerfilter != '0') {
      print('cust filter fired');
      ticketlist.tickets
          .removeWhere((item) => item.customerid.toString() != customerfilter);
    }

    //  removes resources not selected by filter
    //  code is different because there can be multiple resources per ticket.
    //  Normal logic would remove to much if another developer was on the ticket
    if (resourcefilter != null && resourcefilter != '0') {
      ticketlist.tickets.removeWhere((item) => item.resources
              .toList()
              .any((test) => test.resourceid.toString() == resourcefilter)
          ? false
          : true);
    }

    // remove ticket's with status not selected by filter
    if (statusfilter != null && statusfilter != '0') {
      ticketlist.tickets
          .removeWhere((item) => item.statusid.toString() != statusfilter);
    }

    return ticketlist;
  }*/

  String _whosAssigned(List resourcelist) {
    String resources = "";
    for (var i = 0; i < resourcelist.length; i++) {
      if (biggestResourceCount < resourcelist.length) {
        biggestResourceCount = resourcelist.length;
      }
      if (i == resourcelist.length - 1) {
        resources = resources + resourcelist[i].resourcename.toString();
      } else {
        resources = resources + resourcelist[i].resourcename.toString() + ", ";
      }
    }
    return resources;
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<DropdownMenuItem<String>> customerdropdown = [];
  List<DropdownMenuItem<String>> resourcedropdown = [];
  List<DropdownMenuItem<String>> statusdropdown = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<DropdownMenuItem<String>>> loadFilterDropdownCustomer() async {
    if (customerdropdown.length < 1) {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString("assets/customerdropdowndata.json");
      final jsonResponse = json.decode(jsonString);
      CustomerListdd customerlist = new CustomerListdd.fromJson(jsonResponse);

      for (var i = 0; i < customerlist.customers.length; i++) {
        customerdropdown.add(DropdownMenuItem(
          value: customerlist.customers[i].id,
          child: Text(customerlist.customers[i].selection.toString()),
        ));
      }
    }

    return customerdropdown;
  }

  Future<List<DropdownMenuItem<String>>> loadFilterDropdownResource() async {
    if (resourcedropdown.length < 1) {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString("assets/resourcedropdowndata.json");
      final jsonResponse = json.decode(jsonString);
      ResourcesListdd resourceslist =
          new ResourcesListdd.fromJson(jsonResponse);

      for (var i = 0; i < resourceslist.resources.length; i++) {
        resourcedropdown.add(DropdownMenuItem(
          value: resourceslist.resources[i].id,
          child: Text(resourceslist.resources[i].selection.toString()),
        ));
      }
    }

    return resourcedropdown;
  }

  Future<List<DropdownMenuItem<String>>> loadFilterDropdownStatus() async {
    if (statusdropdown.length < 1) {
      String jsonString2 = await DefaultAssetBundle.of(context)
          .loadString("assets/statusdropdowndata.json");
      final jsonResponse2 = json.decode(jsonString2);
      StatusListdd statuslist = new StatusListdd.fromJson(jsonResponse2);

      for (var i = 0; i < statuslist.statusi.length; i++) {
        statusdropdown.add(DropdownMenuItem(
          value: statuslist.statusi[i].id,
          child: Text(statuslist.statusi[i].selection.toString()),
        ));
      }
    }

    return statusdropdown;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder<List<DropdownMenuItem<String>>>(
            future: loadFilterDropdownCustomer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                }
                return snapshot.hasData
                    ? DropdownButton<String>(
                        isExpanded: true,
                        value: _customerSelection,
                        onChanged: (String newValue) {
                          setState(() {
                            _customerSelection = newValue;
                          });

                          print(_customerSelection);
                        },
                        items: snapshot.data,
                      )
                    : Center(child: Container());
              } else {
                return Center(child: Container());
              }
            },
          ),
          FutureBuilder<List<DropdownMenuItem<String>>>(
            future: loadFilterDropdownResource(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                }
                return snapshot.hasData
                    ? DropdownButton<String>(
                        isExpanded: true,
                        value: _resourceSelection,
                        onChanged: (String newValue) {
                          setState(() {
                            _resourceSelection = newValue;
                          });

                          print(_resourceSelection);
                        },
                        items: snapshot.data,
                      )
                    : Center(child: Container());
              } else {
                return Center(child: Container());
              }
            },
          ),
          FutureBuilder<List<DropdownMenuItem<String>>>(
            future: loadFilterDropdownStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                }
                return snapshot.hasData
                    ? DropdownButton<String>(
                        isExpanded: true,
                        value: _statusSelection,
                        onChanged: (String newValue) {
                          setState(() {
                            _statusSelection = newValue;
                          });

                          print(_statusSelection);
                        },
                        items: snapshot.data,
                      )
                    : Center(child: Container());
              } else {
                return Center(child: Container());
              }
            },
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
            customerfilter = _customerSelection;
            resourcefilter = _resourceSelection;
            statusfilter = _statusSelection;
          },
        )
      ],
    );
  }
}
