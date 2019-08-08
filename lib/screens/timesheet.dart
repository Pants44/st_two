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