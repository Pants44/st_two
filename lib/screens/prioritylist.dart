import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/screens/priority.dart';
import 'package:st_two/data/processtickets.dart';

import 'package:http/http.dart' as http;

class PriorityListPage extends StatefulWidget {
  PriorityListPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _PriorityListPageState createState() => _PriorityListPageState();
}

class _PriorityListPageState extends State<PriorityListPage> {
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
            hintText: 'Priorities',
          ),
          onChanged: (text) {},
        ),
      ),
      body: FutureBuilder<PriorityList>(
        future: fetchPriorities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.priorities.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                              onTap: () {
                                print('Open Priority ' +
                                    snapshot.data.priorities[index].priorityid
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PriorityPage(
                                      mode: 'edit',
                                      ronly: true,
                                      title: 'View Priority',
                                      priority: snapshot.data.priorities[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(snapshot
                                      .data.priorities[index].priorityname
                                      .toString()),
                                ),
                              ),
                            )
                          : snapshot.data.priorities[index].priorityname
                                      .contains(filter.toLowerCase())
                              ? GestureDetector(
                                  onTap: () {
                                    print('Open Priority ' +
                                        snapshot
                                            .data.priorities[index].priorityname
                                            .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PriorityPage(
                                            mode: 'edit',
                                            ronly: true,
                                            title: 'Priority ' +
                                                snapshot.data.priorities[index]
                                                    .priorityname
                                                    .toString(),
                                            priority:
                                                snapshot.data.priorities[index]),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(snapshot
                                          .data.priorities[index].priorityname
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
              builder: (context) => PriorityPage(
                mode: 'add',
                ronly: false,
                title: 'Add Priority',
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<PriorityList> fetchPriorities() async {
  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  var jsonString = await http.get(sci.serverreqaddress + "/priorities");
  final jsonResponse = json.decode(jsonString.body.toString());
  PriorityList priorities = new PriorityList.fromJson(jsonResponse);
  return priorities;
}