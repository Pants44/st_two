import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomers.dart';
import 'package:st_two/screens/customerentry.dart';
import 'package:st_two/data/processdropdowns.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class CustomersPage extends StatefulWidget {
  CustomersPage({Key key, this.title}) : super(key: key);
  final title;

  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  String _statusSelection = 'Select All';
  List<DropdownMenuItem<String>> statusdropdown = [];

  TextEditingController tecSearch = TextEditingController();
  var searchFocusNode = FocusNode();
  String filter;
  int _selectedIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tecSearch.addListener(() {
      setState(() {
        filter = tecSearch.text;
      });
    });
    loadFilterDropdowns();
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
              hintText: 'Search Customers',
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
                  )),
            )
          ],
        ),
        body: FutureBuilder(
          future: loadCustomerList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.customers.length,
                      itemBuilder: (context, index) {
                        return filter == null || filter == ""
                            ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerEntry(
                                        title: snapshot
                                            .data.customers[index].customername,
                                        customer:
                                            snapshot.data.customers[index])),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(snapshot
                                        .data.customers[index].customerid
                                        .toString() +
                                    " - " +
                                    snapshot.data.customers[index].customername
                                        .toString()),
                              ),
                            ))
                            : snapshot.data.customers[index].customername.contains(filter) ?
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerEntry(
                                        title: snapshot
                                            .data.customers[index].customername,
                                        customer:
                                        snapshot.data.customers[index])),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(snapshot
                                    .data.customers[index].customerid
                                    .toString() +
                                    " - " +
                                    snapshot.data.customers[index].customername
                                        .toString()),
                              ),
                            )) : Container();
                      },
                    )
                  : Center(child: CircularProgressIndicator());
            } else {
              return CircularProgressIndicator();
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
      ),);
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
        .loadString("assets/customerstatusdropdowndata.json");
    final jsonResponse = json.decode(jsonString);
    CustomerStatusListdd customerstatus = new CustomerStatusListdd.fromJson(jsonResponse);

    for (var i = 0; i < customerstatus.customerstatusi.length; i++) {
      statusdropdown.add(DropdownMenuItem(
        value: customerstatus.customerstatusi[i].id,
        child: Text(customerstatus.customerstatusi[i].id.toString()),
      ));
    }
  }

  Future<CustomerList> loadCustomerList() async {
    print('func called');
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/customerdata.json");
    final jsonResponse = json.decode(jsonString);
    CustomerList customerlist = new CustomerList.fromJson(jsonResponse);
    print('Customers list loaded for Customer List Screen');
    return customerlist;
  }
}
