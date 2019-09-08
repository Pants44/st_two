import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomerconnections.dart';
import 'package:st_two/data/processdropdowns.dart';
import 'package:st_two/screens/connection.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class CustomerConnectionList extends StatefulWidget {
  CustomerConnectionList({Key key, this.title}) : super(key: key);

  final title;

  @override
  _CustomerConnectionListState createState() => _CustomerConnectionListState();
}

class _CustomerConnectionListState extends State<CustomerConnectionList> {
  String _versionSelection = 'All Versions';
  List<DropdownMenuItem<String>> versiondropdown = [];

  TextEditingController tecSearch = TextEditingController();
  var searchFocusNode = FocusNode();
  String filter;
  int _selectedIndex = 0;

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
            hintText: 'Search Connections',
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
        future: loadConnectionList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.ccon.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConnectionPage(
                                    title: 'View Connection',
                                    cc: snapshot.data.ccon[index],
                                    readonly: true,
                                  ),
                                ),
                              ),
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(snapshot
                                      .data.ccon[index].customername
                                      .toString()),
                                  subtitle: Text('Version: ' +
                                      snapshot.data.ccon[index].erpversion
                                          .toString(),),
                                  trailing: Text(snapshot.data.ccon[index].customerinactive.toString(),),
                                ),
                              ))
                          : snapshot.data.ccon[index].customername
                                      .contains(filter) ||
                                  snapshot.data.ccon[index].erpversion
                                      .toString()
                                      .contains(filter)
                              ? GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConnectionPage(
                                        title: 'View Connection',
                                        cc: snapshot.data.ccon[index],
                                        readonly: true,
                                      ),
                                    ),
                                  ),
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(snapshot
                                          .data.ccon[index].customername
                                          .toString()),
                                      subtitle: Text('Version: ' +
                                          snapshot.data.ccon[index].erpversion
                                              .toString(),),
                                      trailing: Text(snapshot.data.ccon[index].customerinactive.toString(),),
                                    ),
                                  ),
                                )
                              : Container();
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
                isExpanded: true,
                value: _versionSelection,
                onChanged: (String newValue) {
                  setState(() {
                    _versionSelection = newValue;
                  });

                  print(_versionSelection);
                },
                items: versiondropdown,
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
        .loadString("assets/versiondropdowndata.json");
    final jsonResponse = json.decode(jsonString);
    VersionListdd versionlist = new VersionListdd.fromJson(jsonResponse);

    for (var i = 0; i < versionlist.versions.length; i++) {
      versiondropdown.add(DropdownMenuItem(
        value: versionlist.versions[i].id,
        child: Text(versionlist.versions[i].id.toString()),
      ));
    }
  }

  Future<ConnectionList> loadConnectionList() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/customerconnectiondata.json");
    final jsonResponse = json.decode(jsonString);
    ConnectionList connectionlist = new ConnectionList.fromJson(jsonResponse);
    print('Connection list loaded for Customer Connection List Screen');
    return connectionlist;
  }
}
