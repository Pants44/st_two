import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/screens/status.dart';
import 'package:st_two/data/processtickets.dart';

import 'package:http/http.dart' as http;

class StatusListPage extends StatefulWidget {
  StatusListPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _StatusListPageState createState() => _StatusListPageState();
}

class _StatusListPageState extends State<StatusListPage> {
  TextEditingController tecSearch = TextEditingController();

  String filter;

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
    filter = null;
    tecSearch.dispose();
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
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Statuses',
          ),
          onChanged: (text) {},
        ),
      ),
      body: FutureBuilder<StatusList>(
        future: fetchStatuses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.statuslist.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                              onTap: () {
                                print('Open Status ' +
                                    snapshot.data.statuslist[index].statusid
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StatusPage(
                                      mode: 'edit',
                                      ronly: true,
                                      title: 'View Status',
                                      status: snapshot.data.statuslist[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(snapshot
                                      .data.statuslist[index].statusname
                                      .toString()),
                                ),
                              ),
                            )
                          : snapshot.data.statuslist[index].statusname
                                      .contains(filter.toLowerCase())
                              ? GestureDetector(
                                  onTap: () {
                                    print('Open Status ' +
                                        snapshot
                                            .data.statuslist[index].statusname
                                            .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StatusPage(
                                            mode: 'edit',
                                            ronly: true,
                                            title: 'Status ' +
                                                snapshot.data.statuslist[index]
                                                    .statusname
                                                    .toString(),
                                            status:
                                                snapshot.data.statuslist[index]),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(snapshot
                                          .data.statuslist[index].statusname
                                          .toString()),
                                    ),
                                  ),
                                )
                              : Container();
                    },
                  )
                : Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StatusPage(
                mode: 'add',
                ronly: false,
                title: 'Add Status',
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<StatusList> fetchStatuses() async {
  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  var jsonString = await http.get(sci.serverreqaddress + "/statuses");
  final jsonResponse = json.decode(jsonString.body.toString());
  StatusList statuses = new StatusList.fromJson(jsonResponse);
  return statuses;
}
