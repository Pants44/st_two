import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/size_config.dart';

import 'package:http/http.dart' as http;

TextEditingController _statusid = TextEditingController();
TextEditingController _statusname = TextEditingController();
//TextEditingController _email = TextEditingController();
//TextEditingController _extension = TextEditingController();
//bool vinbool = false;
bool vronly = false;
String vmode = '';
String vtitle = '';

final _formKey = GlobalKey<FormState>();

class StatusPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final Status status;

  StatusPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.status})
      : super(key: key);



  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vmode = widget.mode;
    vronly = widget.ronly;
    vtitle = widget.title;

    if (vmode == 'edit') {
      _loadData(widget.status);
    } else if (vmode == 'add') {
      _statusid.text = '';
      _statusname.text = '';
      //vinbool = false;
    }
  }

  void _loadData(Status status) async {
    _statusid.text = status.statusid.toString();
    _statusname.text = status.statusname.toString();
    //vinbool = status.inactive ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(vtitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () {},
          ),
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteStatus(widget.status.statusid, context);
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                readOnly: true,
                controller: _statusid,
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Status needs an ID';
                    }
                  } else {
                    if (value == '') {
                      return 'Status ID cannot be null';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _statusname,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Status needs an Name';
                    }
                  } else {
                    if (value == '') {
                      return 'Status name cannot be blank';
                    }
                  }
                  return null;
                },
              ),
              /*Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('Inactive', style: TextStyle(
                      color: vronly ? Colors.grey : Colors.white,
                    ),

                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: vronly
                          ? Switch(
                        value: vinbool,
                        onChanged: null,
                      )
                          : Switch(
                        value: vinbool,
                        onChanged: (value) {
                          setState(() {
                            vinbool = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
      floatingActionButton: (vronly == true)
          ? FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () {
                vronly = !vronly;
                vtitle = 'Edit Status';
                setState(() {});
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                //update mode
                if (vmode == 'edit' && vronly == false){

                  updateStatus(context);
                  vtitle = 'View Status';
                }
                vronly = !vronly;
                setState(() {});
              }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _statusid.text = '';
    _statusname.text = '';
    //vinbool = '';
    super.dispose();
  }
}

Future<String> createStatus(BuildContext context) async {
  bool statuscreated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final staid = _statusid.text.toString() ?? '';
    final staname = _statusname.text.toString() ?? '';
    //final stainactive = vinbool.toString();
    final starowrevnum = 1.toString();
    final stacompany = 1.toString();

    final str = '{"statusid":"' +
        staid.trim() +
        '",' +
        '"statusname":"' +
        staname.trim() +
        //'",' +
        //'"inactive":"' +
        //stainactive +
        '",' +
        '"rowrevnum":"' +
        starowrevnum +
        '",' +
        '"company":"' +
        stacompany +
        '"}';

    print(str);

    var poststatus;
    try {
      poststatus = await http.post(
        sci.serverreqaddress + '/statuses',
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (poststatus?.statusCode == 200) {
      print('Status: ' + _statusname.text.toString() + ', created');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Status' + _statusname.text.toString() + ', created.'),
        duration: Duration(seconds: 3),
      ),);
      statuscreated = true;
    }
  }

  if (statuscreated ?? false) {
    Navigator.of(context).pop();
  } else {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Something went wrong'),
        duration: Duration(seconds: 3),
      ),
    );
    print('Something went wrong');
  }
}

Future<String> updateStatus(BuildContext context) async {
  bool statusupdated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final staid = _statusid.text.toString();
    final staname = _statusname.text.toString();
    //final stainactive = vinbool.toString();
    final starowrevnum = 1.toString();

    ///staid cannot be updated through here

    final str = '{"statusname":"' +
        staname.trim() +
        '",' +
        '"inactive":"' +
        //stainactive +
        '",' +
        '"rowrevnum":"' +
        starowrevnum +
        '"}';

    print(str);

    var putstatus;
    try {
      putstatus = await http.put(
        sci.serverreqaddress + '/statuses/' + staid,
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (putstatus?.statusCode == 200) {
      print('Status: ' + _statusname.text.toString() + ', updated.');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Status' + _statusname.text.toString() + ', updated.'),
        duration: Duration(seconds: 3),
      ),);
      statusupdated = true;
    }
  }

  if (statusupdated ?? false) {
    Navigator.of(context).pop();
  } else {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Something went wrong'),
        duration: Duration(seconds: 3),
      ),
    );
    print('Something went wrong');
  }
}

Future<void> deleteStatus(int statusid, BuildContext context) async {
  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  final url = sci.serverreqaddress + '/statuses/' + statusid.toString();

  var poststatus = await http.delete(url);
  print(poststatus.statusCode);
  if (poststatus.statusCode == 200) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Status deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}
