import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:st_two/screens/resource.dart';
import 'package:st_two/data/processtickets.dart';

import 'package:http/http.dart' as http;

class ResourceListPage extends StatefulWidget {
  ResourceListPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _ResourceListPageState createState() => _ResourceListPageState();
}

class _ResourceListPageState extends State<ResourceListPage> {
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
            hintText: 'Resources',
          ),
          onChanged: (text) {},
        ),
      ),
      body: FutureBuilder(
        future: fetchResources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.resources.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                              onTap: () {
                                print('Open Resource ' +
                                    snapshot.data.resources[index].resourceid
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(

                                    builder: (context) => ResourcePage(
                                      mode: 'edit',
                                      ronly: true,
                                      title: 'View Resource',
                                      resource: snapshot.data.resources[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(snapshot
                                      .data.resources[index].resourcename
                                      .toString()),
                                  subtitle: Text(snapshot
                                      .data.resources[index].email
                                      .toString()),
                                ),
                              ),
                            )
                          : snapshot.data.resources[index].resourcename
                                      .contains(filter.toLowerCase()) ||
                                  snapshot.data.resources[index].email
                                      .toString()
                                      .contains(filter.toLowerCase())
                              ? GestureDetector(
                                  onTap: () {
                                    print('Open Resource ' +
                                        snapshot
                                            .data.resources[index].resourcename
                                            .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResourcePage(
                                            mode: 'edit',
                                            ronly: true,
                                            title: 'Resource ' +
                                                snapshot.data.resources[index]
                                                    .resourcename
                                                    .toString(),
                                            resource:
                                                snapshot.data.resources[index]),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(snapshot
                                          .data.resources[index].resourcename
                                          .toString()),
                                      subtitle: Text(snapshot
                                          .data.resources[index].email
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
              builder: (context) => ResourcePage(
                mode: 'add',
                title: 'Add Resource',
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<ResourcesList> fetchResources() async {
  var jsonString = await http.get("http://192.168.0.110:8888/resources");
  final jsonResponse = json.decode(jsonString.body.toString());
  ResourcesList resources = new ResourcesList.fromJson(jsonResponse);
  return resources;
}
