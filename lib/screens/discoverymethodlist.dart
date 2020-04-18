import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/discoverymethod.dart';

import 'package:st_two/screens/discoverymethod.dart';

final dmlist = DiscoveryMethodList();
final session = Session();

class DiscoveryMethodListPage extends StatefulWidget {
  DiscoveryMethodListPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _DiscoveryMethodListPageState createState() =>
      _DiscoveryMethodListPageState();
}

class _DiscoveryMethodListPageState extends State<DiscoveryMethodListPage> {
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
            hintText: 'Discovery Methods',
          ),
          onChanged: (text) {},
        ),
      ),
      body: FutureBuilder<DiscoveryMethodList>(
        future: dmlist.fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.discoverymethods.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                              onTap: () {
                                print('Open Discovery Method ' +
                                    snapshot
                                        .data.discoverymethods[index].dmid
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DiscoveryMethodPage(
                                      mode: 'edit',
                                      ronly: true,
                                      title: 'View Discovery Method',
                                      dmid: snapshot
                                          .data.discoverymethods[index].dmid,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(snapshot.data
                                      .discoverymethods[index].discoverymethod
                                      .toString()),
                                ),
                              ),
                            )
                          : snapshot
                                  .data.discoverymethods[index].discoverymethod
                                  .contains(filter.toLowerCase())
                              ? GestureDetector(
                                  onTap: () {
                                    print('Open Discovery Method ' +
                                        snapshot.data.discoverymethods[index]
                                            .discoverymethod
                                            .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DiscoveryMethodPage(
                                                mode: 'edit',
                                                ronly: true,
                                                title: 'Discovery Method ' +
                                                    snapshot
                                                        .data
                                                        .discoverymethods[index]
                                                        .discoverymethod
                                                        .toString(),
                                                dmid: snapshot
                                                    .data
                                                    .discoverymethods[index]
                                                    .dmid),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(snapshot
                                          .data
                                          .discoverymethods[index]
                                          .discoverymethod
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
              builder: (context) => DiscoveryMethodPage(
                mode: 'add',
                ronly: false,
                title: 'Add Discovery Method',
              ),
            ),
          );
        },
      ),
    );
  }
}
