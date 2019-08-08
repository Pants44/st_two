
import 'package:flutter/material.dart';

class ConnectionPage extends StatefulWidget {
  ConnectionPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Image(
                  image: AssetImage('assets/st22000.png'),
                ),
              )
          )
      ),
      body: Center(
        child: Text("blank slate"),
      ),
    );
  }
}