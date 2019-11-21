import 'package:flutter/material.dart';

import 'package:st_two/size_config.dart';
import 'package:st_two/screens/resourcelist.dart';
import 'package:st_two/bloc/resourcelistbloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

class ToolsPage extends StatefulWidget {
  ToolsPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            child: Container(
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 5,
                child: Container(
                  child: ListTile(
                    title: Text('User Accounts'),
                    subtitle: Text(
                        'Information and Security settings related to User Accounts'),
                    isThreeLine: true,
                    onTap: () {},
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  child: ListTile(
                    title: Text('Resources'),
                    subtitle: Text(
                        'Settings and attributes for developers, consultants, etc'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResourceListPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  child: ListTile(
                    title: Text('Statuses'),
                    subtitle: Text('Information related to each ticket status'),
                    onTap: () {},
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  child: ListTile(
                    title: Text('Skills'),
                    subtitle: Text(
                        'These identify what resources can handle which tickets'),
                    onTap: () {},
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  child: ListTile(
                    title: Text('Priorities'),
                    subtitle: Text('Manages how tickets are prioritized'),
                    onTap: () {},
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  child: ListTile(
                    title: Text('Discovery Methods'),
                    subtitle: Text('How our customers discovery us'),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
