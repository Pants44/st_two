import 'package:flutter/material.dart';

class CustomersPage extends StatefulWidget {
  CustomersPage({Key key}) : super(key: key);


  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {

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