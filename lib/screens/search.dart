import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:st_two/data/processsearch.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController tecSearch = TextEditingController();
  var searchFocusNode = FocusNode();

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
            hintText: 'Search ST',
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
            child: Image(
              image: AssetImage('assets/st22000.png'),
            ),
          )
        ],
      ),
      body: FutureBuilder<EverythingList>(
        future: _loadEverythingList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView(
                    children: <Widget>[
                Container(child:Text('Tickets:')),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.tickets.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text('Ticket'),
                              ),
                            );
                          }),
                      Container(child:Text('Customers:')),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.customers.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text('Customer'),
                              ),
                            );
                          }),
                      Container(child:Text('POCs:')),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.pocs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text('POC'),
                              ),
                            );
                          }),
                    ],
                  )
                : Container(child:Text('failed here'));
          }
          return Container(child:Text('failed there'));
        },
      ), /*Center(
        child: Text("Search", style: TextStyle(fontSize: 36, color: Colors.grey[700])),
      ),*/
    );
  }

  Future<EverythingList> _loadEverythingList() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/everythingdata.json");
    final jsonResponse = json.decode(jsonString);
    EverythingList everythinglist = new EverythingList.fromJson(jsonResponse);
    print('Everything list loaded');
    return everythinglist;
  }
}
