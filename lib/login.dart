import 'package:flutter/material.dart';

import 'package:st_two/screens/home.dart';
import 'package:st_two/theme/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: colorSTBlue,
        backgroundColor: colorSTbg,
        canvasColor: colorSTbg,
        primaryColor: colorSTother,
        bottomAppBarColor: colorSTother,

      ),
      home: MyLoginPage(title: 'Solution Tracker Two'),

    );
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 96, right: 96),
                    child: Image(
                      image: AssetImage('assets/st22000.png'),

                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Username",
                          fillColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Password",
                          fillColor: Colors.white),
                    ),

                  ),
                  RaisedButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Solution Tracker Two',)),
                      );
                    },
                    color: colorSTBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
