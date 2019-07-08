import 'package:flutter/material.dart';

import 'package:st_two/theme/colors.dart';
import 'package:st_two/screens/dashboard.dart';
import 'package:st_two/screens/customers.dart';
import 'package:st_two/screens/search.dart';
import 'package:st_two/screens/analytics.dart';
import 'package:st_two/screens/tools.dart';
import 'package:st_two/screens/timesheet.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.only(top:24, bottom: 24),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.assignment, size: 48),
                        Text('Dashboard', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardPage()),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.only(top:24, bottom: 24),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.contacts, size: 48),
                        Text('Customer', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomersPage()),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.only(top:24, bottom: 24),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.search, size: 48),
                        Text('Search', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.only(top:24, bottom: 24),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.insert_chart, size: 48),
                        Text('Analytics', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AnalyticsPage()),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.only(top:24, bottom: 24),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.apps, size: 48),
                        Text('Tools', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ToolsPage()),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.only(top:24, bottom: 24),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.access_time, size: 48),
                        Text('Timesheet', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TimesheetPage()),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        //tooltip: 'Increment',
        //child: Icon(Icons.add),
        //foregroundColor: Colors.white,
      //), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
