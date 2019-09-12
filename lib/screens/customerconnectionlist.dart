import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomerconnections.dart';
import 'package:st_two/data/processdropdowns.dart';
import 'package:st_two/screens/connection.dart';

enum ConfirmAction { CANCEL, ACCEPT }

String versionfilter;

class CustomerConnectionList extends StatefulWidget {
  CustomerConnectionList({Key key, this.title}) : super(key: key);

  final title;

  @override
  _CustomerConnectionListState createState() => _CustomerConnectionListState();
}

class _CustomerConnectionListState extends State<CustomerConnectionList> {
  StreamController<String> mycontroller = StreamController();

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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tecSearch.dispose();
    searchFocusNode.dispose();
    versionfilter = null;
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
                    _asyncConfirmDialog(context).then((_)=>setState((){}));
                  },
                )),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
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
                            subtitle: Text(
                              'Version: ' +
                                  snapshot.data.ccon[index].erpversion
                                      .toString(),
                            ),
                            trailing: Text(
                              snapshot.data.ccon[index].customerinactive
                                  .toString(),
                            ),
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
                          subtitle: Text(
                            'Version: ' +
                                snapshot.data.ccon[index].erpversion
                                    .toString(),
                          ),
                          trailing: Text(
                            snapshot
                                .data.ccon[index].customerinactive
                                .toString(),
                          ),
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
          isListFiltered(),
        ],
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

  Widget isListFiltered() {
    if(versionfilter != null){
      return Center(
        child: Text('Filter has been set'),
      );
    } else {
      return Center(
        child: Container(),
      );
    }
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return MyDialog();
      }
    );
  }

  Future<ConnectionList> loadConnectionList() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/customerconnectiondata.json");
    final jsonResponse = json.decode(jsonString);
    ConnectionList connectionlist = new ConnectionList.fromJson(jsonResponse);
    print('Connection list loaded for Customer Connection List Screen');

    if(versionfilter != null){
      connectionlist.ccon.removeWhere((item) => item.erpversion != versionfilter);
    }
    return connectionlist;
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  String _versionSelection = 'All Versions';
  List<DropdownMenuItem<String>> versiondropdown = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<DropdownMenuItem<String>>> loadFilterDropdowns() async {

    if(versiondropdown.length < 1){
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString("assets/versiondropdowndata.json");
      final jsonResponse = json.decode(jsonString);
      VersionListdd versionlist = new VersionListdd.fromJson(jsonResponse);

      for (var i = 0; i < versionlist.versions.length; i++) {
        versiondropdown.add(DropdownMenuItem(
          value: versionlist.versions[i].id.toString(),
          child: Text(versionlist.versions[i].id.toString()),
        ));
      }
    }

    return versiondropdown;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DropdownMenuItem<String>>>(
      future: loadFilterDropdowns(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            print(snapshot.error.toString());
          }
          return snapshot.hasData ?
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButton<String>(
                  isExpanded: true,
                  value: _versionSelection,
                  onChanged: (String newValue) {
                    setState((){
                      print(newValue.toString());
                      _versionSelection = newValue;

                    });
                  },
                  items: snapshot.data,
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
                  versionfilter = _versionSelection;
                  print('Filter Accepted: '+_versionSelection);
                },
              )
            ],
          )
              :
        Center(child: Container());
        } else {
          return Center(child:Container());
        }
      },
    );
  }
}
