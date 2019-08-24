import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';

import 'package:st_two/screens/home.dart';
import 'package:st_two/screens/dashboard.dart';
import 'package:st_two/screens/ticket.dart';
import 'package:st_two/screens/customers.dart';
import 'package:st_two/screens/customerentry.dart';
import 'package:st_two/screens/customerconnectionlist.dart';
import 'package:st_two/screens/connection.dart';
import 'package:st_two/screens/analytics.dart';
import 'package:st_two/screens/tools.dart';
import 'package:st_two/screens/timesheet.dart';
import 'package:st_two/screens/chat.dart';
import 'package:st_two/screens/search.dart';
import 'package:st_two/screens/billingentry.dart';
import 'package:st_two/theme/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solution Tracker 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: colorSTBlue,
        accentColor: colorSTBlue,
        backgroundColor: colorSTbg,
        canvasColor: colorSTbg,
        primaryColor: colorSTother,
        bottomAppBarColor: colorSTother,

      ),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new MyHomePage(),
        '/dashboard': (BuildContext context) => new DashboardPage(),
        '/ticket': (BuildContext context) => new TicketPage(),
        '/customers': (BuildContext context) => new CustomersPage(),
        '/customerentry': (BuildContext context) => new CustomerEntry(),
        '/connectionlist': (BuildContext context) => new CustomerConnectionList(),
        '/connect': (BuildContext context) => new ConnectionPage(),
        '/analytics': (BuildContext context) => new AnalyticsPage(),
        '/tools': (BuildContext context) => new ToolsPage(),
        '/timesheet': (BuildContext context) => new TimesheetPage(),
        '/chat': (BuildContext context) => new ChatPage(),
        '/search': (BuildContext context) => new SearchPage(),
        '/billingentry': (BuildContext context) => new BillingEntryPage(),


      },
      home: LoginPage(title: 'Solution Tracker Two'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController tecLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        body: Form(
            child: (orientation == Orientation.portrait)
                ? Center(
                    child: ListView(
                      children: <Widget>[
                        Container(
                            height: SizeConfig.safeBlockVertical * 50,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            child: Hero(
                              tag: 'logoappbar',
                              child: Center(
                                child: Image(
                                  image: AssetImage('assets/st22000.png'),
                                ),
                              ),
                            )),
                        Container(
                          height: SizeConfig.safeBlockVertical * 50,
                          width: SizeConfig.safeBlockHorizontal * 80,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: SizeConfig.safeBlockHorizontal * 80,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        hintText: "Username",
                                        fillColor: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16, bottom: 16),
                                ),
                                Container(
                                  width: SizeConfig.safeBlockHorizontal * 80,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        hintText: "Password",
                                        fillColor: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16, bottom: 16),
                                ),
                                RaisedButton(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () => Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                          transitionDuration: Duration(milliseconds: 500),
                                          pageBuilder: (_, __, ___) => MyHomePage(title: 'Solution Tracker Two',))),
                                  color: colorSTBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.only(
                                      top: 16, bottom: 16, left: 32, right: 32),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: SizeConfig.safeBlockVertical * 80,
                        width: SizeConfig.safeBlockHorizontal * 50,
                        child: Hero(
                          tag: 'logoappbar',
                          child: Center(
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 40,
                                child: Image(
                                  image: AssetImage('assets/st22000.png'),
                                ),
                              )
                          ),
                        )
                      ),
                      Container(
                        height: SizeConfig.safeBlockVertical * 100,
                        width: SizeConfig.safeBlockHorizontal * 50,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: SizeConfig.safeBlockHorizontal * 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Colors.grey[800]),
                                      hintText: "Username",
                                      fillColor: Colors.white),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(top: 16, bottom: 16),
                              ),
                              Container(
                                width: SizeConfig.safeBlockHorizontal * 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Colors.grey[800]),
                                      hintText: "Password",
                                      fillColor: Colors.white),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(top: 16, bottom: 16),
                              ),
                              RaisedButton(
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 18),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage(
                                          title: 'Solution Tracker Two',
                                        )),
                                  );
                                },
                                color: colorSTBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                padding: EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                    left: 32,
                                    right: 32),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
