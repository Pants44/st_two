import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/industry.dart';

import 'package:st_two/screens/industry.dart';

final industrylist = IndustryList();
final session = Session();

class IndustryListPage extends StatefulWidget {
  IndustryListPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _IndustryListPageState createState() => _IndustryListPageState();
}

class _IndustryListPageState extends State<IndustryListPage> {
  TextEditingController tecSearch = TextEditingController();

  String curfilter, filterindname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tecSearch.addListener(() {
      setState(() {
        curfilter = tecSearch.text.toLowerCase();
        print('filter: ' + curfilter);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    curfilter = null;
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
            hintText: 'Industries',
          ),
          onChanged: (text) {},
        ),
      ),
      body: FutureBuilder<IndustryList>(
        future: industrylist.fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.industries.length,
                    itemBuilder: (context, index) {
                      filterindname = snapshot
                          .data.industries[index].industryname
                          .toLowerCase();

                      return curfilter == null || curfilter == ""
                          ? GestureDetector(
                              onTap: () {
                                print('Open Industry ' +
                                    snapshot
                                        .data.industries[index].industryid
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IndustryPage(
                                      mode: 'edit',
                                      ronly: true,
                                      title: 'View Industry',
                                      industryid: snapshot
                                          .data.industries[index].industryid,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(snapshot
                                      .data.industries[index].industryname
                                      .toString()),
                                ),
                              ),
                            )
                          : filterindname.contains(curfilter)
                              ? GestureDetector(
                                  onTap: () {
                                    print('Open Industry ' +
                                        snapshot
                                            .data.industries[index].industryname
                                            .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => IndustryPage(
                                                mode: 'edit',
                                                ronly: true,
                                                title: 'Industry ' +
                                                    snapshot
                                                        .data
                                                        .industries[index]
                                                        .industryname
                                                        .toString(),
                                                industryid: snapshot
                                                    .data
                                                    .industries[index]
                                                    .industryid,
                                              )),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(snapshot
                                          .data.industries[index].industryname
                                          .toString()),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndustryPage(
                mode: 'add',
                ronly: false,
                title: 'Add Industry',
              ),
            ),
          );
        },
      ),
    );
  }
}
