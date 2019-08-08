import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  AnalyticsPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

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
      body: Center(
        child: Text("Coming in V2"),
      ),
    );
  }
}