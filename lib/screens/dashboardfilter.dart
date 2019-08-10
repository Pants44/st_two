import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/screens/home.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/screens/ticket.dart';

class DashboardFilter extends StatefulWidget {
  DashboardFilter({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardFilterState createState() => _DashboardFilterState();
}

class _DashboardFilterState extends State<DashboardFilter> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              DropdownButton(
                hint: Text('Customer'),
                items: [
                  DropdownMenuItem(
                    child: Text('Option 1'),
                    value: 'Option1',
                  ),
                  DropdownMenuItem(
                    child: Text('Option 2'),
                    value: 'Option2',
                  )
                ],
              ),
              DropdownButton(
                hint: Text('Resource'),
                items: [
                  DropdownMenuItem(
                    child: Text('Option 1'),
                    value: 'Option1',
                  ),
                  DropdownMenuItem(
                    child: Text('Option 2'),
                    value: 'Option2',
                  )
                ],
              ),
              DropdownButton(
                onChanged: (value){

                },
                hint: Text('Status'),
                items: [
                  DropdownMenuItem(
                    child: Text('Option 1'),
                    value: 'Option1',
                  ),
                  DropdownMenuItem(
                    child: Text('Option 2'),
                    value: 'Option2',
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
