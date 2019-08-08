import 'package:flutter/material.dart';

class ToolsPage extends StatefulWidget {
  ToolsPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {

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