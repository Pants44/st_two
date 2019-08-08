import 'package:flutter/material.dart';

class TimesheetPage extends StatefulWidget {
  TimesheetPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _TimesheetPageState createState() => _TimesheetPageState();
}

class _TimesheetPageState extends State<TimesheetPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
            child: Image(
              image: AssetImage('assets/st22000.png'),
            ),
          )
        ],
      ),
      body: Center(
        child: Text("blank slate"),
      ),
    );
  }
}