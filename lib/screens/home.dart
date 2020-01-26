import 'package:flutter/material.dart';
import 'package:st_two/login.dart';
import 'package:st_two/screens/dashboard.dart';
import 'package:st_two/screens/customerlist.dart';
import 'package:st_two/screens/customerconnectionlist.dart';
import 'package:st_two/screens/analytics.dart';
import 'package:st_two/screens/tools.dart';
import 'package:st_two/screens/timesheet.dart';
import 'package:st_two/screens/chat.dart';
import 'package:st_two/screens/search.dart';
import 'package:st_two/screens/settings.dart';
import 'package:st_two/data/connect.dart';
import 'package:st_two/theme/themebloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final session = Session();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComp();
  }

  void getComp() async{
    await session.getCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'logoappbar',
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 50
            ),
              child: Container(
              padding: EdgeInsets.all(5),
              child: Image(
                image: AssetImage('assets/st22000.png'),
              ),
            ),
          ),
          ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5, right: 10, bottom: 5),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(title: 'User Settings',),
                  ),
                );
              },
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.assignment, size: 48),
                          Text(
                            'Dashboard',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DashboardPage(title: 'Dashboard'),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.contacts, size: 48),
                          Text(
                            'Customer',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CustomerListPage(title: 'Customers'),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.import_contacts, size: 48),
                          Text(
                            'Connect',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerConnectionList(
                                title: 'Client Connections'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.insert_chart, size: 48),
                          Text(
                            'Analytics',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnalyticsPage(title: 'Analytics'),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.apps, size: 48),
                          Text('Tools', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToolsPage(title: 'Tools'),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.access_time, size: 48),
                          Text(
                            'Timesheet',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TimesheetPage(title: 'Billing'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.message, size: 48),
                          Text(
                            'Chat',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(title: 'Chat'),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search, size: 48),
                          Text(
                            'Search',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      /*onPressed: () {
                        print(session.company.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(title: 'Search')),

                        );
                      },*/
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.arrow_back, size: 48),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(title: 'Solution Tracker Two'),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
