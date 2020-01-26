import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/size_config.dart';

import 'package:http/http.dart' as http;

TextEditingController _priorityid = TextEditingController();
TextEditingController _priorityname = TextEditingController();
//TextEditingController _email = TextEditingController();
//TextEditingController _extension = TextEditingController();
//bool vinbool = false;
bool vronly = false;
String vmode = '';
String vtitle = '';

final _formKey = GlobalKey<FormState>();

class PriorityPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final Priority priority;

  PriorityPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.priority})
      : super(key: key);



  @override
  _PriorityPageState createState() => _PriorityPageState();
}

class _PriorityPageState extends State<PriorityPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vmode = widget.mode;
    vronly = widget.ronly;
    vtitle = widget.title;

    if (vmode == 'edit') {
      _loadData(widget.priority);
    } else if (vmode == 'add') {
      _priorityid.text = '';
      _priorityname.text = '';
      //vinbool = false;
    }
  }

  void _loadData(Priority priority) async {
    _priorityid.text = priority.priorityid.toString();
    _priorityname.text = priority.priorityname.toString();
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
                  deletePriority(widget.priority.priorityid, context);
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
                controller: _priorityid,
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Priority needs an ID';
                    }
                  } else {
                    if (value == '') {
                      return 'Priority ID cannot be null';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _priorityname,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Priority needs an Name';
                    }
                  } else {
                    if (value == '') {
                      return 'Priority name cannot be blank';
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
                vtitle = 'Edit Priority';
                setState(() {});
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                //update mode
                if (vmode == 'edit' && vronly == false){

                  updatePriority(context);
                  vtitle = 'View Priority';
                }
                vronly = !vronly;
                setState(() {});
              }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priorityid.text = '';
    _priorityname.text = '';
    //vinbool = '';
    super.dispose();
  }
}

Future<String> createStatus(BuildContext context) async {
  bool prioritycreated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final priid = _priorityid.text.toString() ?? '';
    final priname = _priorityname.text.toString() ?? '';
    //final priinactive = vinbool.toString();
    final prirowrevnum = 1.toString();
    final pricompany = 1.toString();

    final str = '{"priorityid":"' +
        priid.trim() +
        '",' +
        '"priorityname":"' +
        priname.trim() +
        //'",' +
        //'"inactive":"' +
        //priinactive +
        '",' +
        '"rowrevnum":"' +
        prirowrevnum +
        '",' +
        '"company":"' +
        pricompany +
        '"}';

    print(str);

    var postpriority;
    try {
      postpriority = await http.post(
        sci.serverreqaddress + '/priorities',
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (postpriority?.statusCode == 200) {
      print('Priority: ' + _priorityname.text.toString() + ', created');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Priority' + _priorityname.text.toString() + ', created.'),
        duration: Duration(seconds: 3),
      ),);
      prioritycreated = true;
    }
  }

  if (prioritycreated ?? false) {
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

Future<String> updatePriority(BuildContext context) async {
  bool priorityupdated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final priid = _priorityid.text.toString();
    final priname = _priorityname.text.toString();
    //final priinactive = vinbool.toString();
    final prirowrevnum = 1.toString();

    ///staid cannot be updated through here

    final str = '{"priorityname":"' +
        priname.trim() +
        '",' +
        '"inactive":"' +
        //priinactive +
        '",' +
        '"rowrevnum":"' +
        prirowrevnum +
        '"}';

    print(str);

    var putpriority;
    try {
      putpriority = await http.put(
        sci.serverreqaddress + '/priorities/' + priid,
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (putpriority?.statusCode == 200) {
      print('Priority: ' + _priorityname.text.toString() + ', updated.');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Priority' + _priorityname.text.toString() + ', updated.'),
        duration: Duration(seconds: 3),
      ),);
      priorityupdated = true;
    }
  }

  if (priorityupdated ?? false) {
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

Future<void> deletePriority(int priorityid, BuildContext context) async {
  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  final url = sci.serverreqaddress + '/priorities/' + priorityid.toString();

  var postpriority = await http.delete(url);
  print(postpriority.statusCode);
  if (postpriority.statusCode == 200) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Priority deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}