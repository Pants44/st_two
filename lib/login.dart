import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';

import 'package:st_two/screens/home.dart';
import 'package:st_two/theme/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: colorSTBlue,
        backgroundColor: colorSTbg,
        canvasColor: colorSTbg,
        primaryColor: colorSTother,
        bottomAppBarColor: colorSTother,
      ),
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
                            child: Center(
                              child: Image(
                                image: AssetImage('assets/st22000.png'),
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
                        child: Center(
                          child: Container(
                            width: SizeConfig.safeBlockHorizontal * 40,
                            child: Image(
                              image: AssetImage('assets/st22000.png'),
                            ),
                          )
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
