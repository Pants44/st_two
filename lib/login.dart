import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';

import 'package:st_two/screens/home.dart';
import 'package:st_two/screens/dashboard.dart';
import 'package:st_two/screens/ticket.dart';
import 'package:st_two/screens/customerlist.dart';
import 'package:st_two/screens/customer.dart';
import 'package:st_two/screens/customerconnectionlist.dart';
import 'package:st_two/screens/connection.dart';
import 'package:st_two/screens/analytics.dart';
import 'package:st_two/screens/tools.dart';
import 'package:st_two/screens/timesheet.dart';
import 'package:st_two/screens/chat.dart';
import 'package:st_two/screens/search.dart';
import 'package:st_two/screens/billingentry.dart';
import 'package:st_two/theme/colors.dart';
import 'package:st_two/theme/themebloc.dart';
import 'package:st_two/screens/settings.dart';
import 'package:st_two/data/processdropdowns.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:st_two/data/connect.dart';
import 'dart:convert';

void main() => runApp(ThemeSwitcher());

String companyfilter;

String _companySelection = '4';

class ThemeSwitcher extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      builder: (context) => ThemeBloc(),
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (builder, snapshot) {
        return MaterialApp(
          title: 'Solution Tracker 2',
          debugShowCheckedModeBanner: false,
          theme: snapshot,
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => new MyHomePage(),
            '/dashboard': (BuildContext context) => new DashboardPage(),
            '/ticket': (BuildContext context) => new TicketPage(),
            '/customers': (BuildContext context) => new CustomerListPage(),
            '/customerentry': (BuildContext context) => new CustomerPage(),
            '/connectionlist': (BuildContext context) =>
                new CustomerConnectionList(),
            '/connect': (BuildContext context) => new ConnectionPage(),
            '/analytics': (BuildContext context) => new AnalyticsPage(),
            '/tools': (BuildContext context) => new ToolsPage(),
            '/timesheet': (BuildContext context) => new TimesheetPage(),
            '/chat': (BuildContext context) => new ChatPage(),
            '/search': (BuildContext context) => new SearchPage(),
            '/billingentry': (BuildContext context) => new BillingEntryPage(),
          },
          home: LoginPage(
            title: 'Solution Tracker Two',
          ),
        );
      },
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

  final sci = ServerConnectionInfo();
  final session = Session();

  List<DropdownMenuItem<String>> companydropdown = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                              padding: EdgeInsets.only(top: 16, bottom: 16, left:64, right:64),
                              child: FutureBuilder<List<DropdownMenuItem<String>>>(
                                future: loadCompanyDropdown(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                    }
                                    return snapshot.hasData
                                        ? DropdownButton<String>(
                                      isExpanded: true,
                                      value: _companySelection,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _companySelection = newValue;
                                        });

                                        print(_companySelection);
                                      },
                                      items: snapshot.data,
                                    )
                                        : Center(child: Container());
                                  } else {
                                    return Center(child: Container());
                                  }
                                },
                              ),
                            ),
                            RaisedButton(
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: (){
                                session.setCurCompany(int.parse(_companySelection));
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                        Duration(milliseconds: 500),
                                        pageBuilder: (context, __, ___) =>
                                            MyHomePage(
                                              title: 'Solution Tracker Two',
                                            )));
                              },
                              color: colorSTBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: EdgeInsets.only(
                                  top: 16, bottom: 16, left: 32, right: 32),
                            )
                          ],
                        ),
                      ),
                    ),
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
                              )),
                            )),
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
                                  width: SizeConfig.safeBlockHorizontal * 40,
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
                                  padding: EdgeInsets.only(top: 16, bottom: 16, left:64, right:64),
                                  child: FutureBuilder<List<DropdownMenuItem<String>>>(
                                    future: loadCompanyDropdown(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          print(snapshot.error.toString());
                                        }
                                        return snapshot.hasData
                                            ? DropdownButton<String>(
                                          isExpanded: true,
                                          value: _companySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _companySelection = newValue;
                                            });

                                            print(_companySelection);
                                          },
                                          items: snapshot.data,
                                        )
                                            : Center(child: Container());
                                      } else {
                                        return Center(child: Container());
                                      }
                                    },
                                  ),
                                ),
                                RaisedButton(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    session.setCurCompany(int.parse(_companySelection));
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
                                      top: 16, bottom: 16, left: 32, right: 32),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top:124),
        child: FloatingActionButton(
          child: Icon(Icons.settings),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          foregroundColor: Colors.white,
          elevation: 0,
          splashColor: Color.fromRGBO(255, 255, 255, 0),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(title: 'User Settings',),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Future<List<DropdownMenuItem<String>>> loadCompanyDropdown(BuildContext context) async {
    await sci.getServerInfo();

    if (companydropdown.length < 1) {
      var jsonString = await http.get(sci.serverreqaddress + '/companydrop');
      final jsonResponse = json.decode(jsonString.body.toString());
      CompanyListdd companylist = new CompanyListdd.fromJson(jsonResponse);

      for (var i = 0; i < companylist.companies.length; i++) {
        companydropdown.add(
          DropdownMenuItem(
            value: companylist.companies[i].id,
            child: Text(companylist.companies[i].selection.toString()),
          ),
        );
      }
    }
    return companydropdown;
  }
}


