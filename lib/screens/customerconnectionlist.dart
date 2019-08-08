import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomerconnections.dart';

class CustomerConnectionList extends StatefulWidget {
  CustomerConnectionList({Key key, this.title}) : super(key: key);

  final title;

  @override
  _CustomerConnectionListState createState() => _CustomerConnectionListState();
}

class _CustomerConnectionListState extends State<CustomerConnectionList> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
        actions: <Widget>[
          Hero(
            tag: 'logoappbar',
            child: Padding(
              padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
              child: Image(
                image: AssetImage('assets/st22000.png'),
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: loadConnectionList(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data.ccon.length,
              itemBuilder: (context, index){
                return GestureDetector(
                    onTap: (){
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data.ccon[index].customername.toString()),
                        subtitle: Text('Version: ' + snapshot.data.ccon[index].version.toString()),
                      ),
                    )
                );
              },
            )
                : Center(child: CircularProgressIndicator());
          } else {
            return CircularProgressIndicator();
          }

        },
      )
    );
  }

  Future<ConnectionList> loadConnectionList() async{
    String jsonString =
    await DefaultAssetBundle.of(context).loadString("assets/customerconnectiondata.json");
    final jsonResponse = json.decode(jsonString);
    ConnectionList connectionlist = new ConnectionList.fromJson(jsonResponse);
    print('Connection list loaded for Customer Connection List Screen');
    return connectionlist;
  }
}