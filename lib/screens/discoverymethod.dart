import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/data/processcustomers.dart';
import 'package:st_two/size_config.dart';

import 'package:http/http.dart' as http;

TextEditingController _dmid = TextEditingController();
TextEditingController _discoverymethod = TextEditingController();
int _rowrevnum, _company;
bool vinbool = false;
bool vronly = false;
String vmode = '';
String vtitle = '';

final _formKey = GlobalKey<FormState>();

class DiscoveryMethodPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final DiscoveryMethod dm;

  DiscoveryMethodPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.dm})
      : super(key: key);

  @override
  _DiscoveryMethodPageState createState() => _DiscoveryMethodPageState();
}

class _DiscoveryMethodPageState extends State<DiscoveryMethodPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vmode = widget.mode;
    vronly = widget.ronly;
    vtitle = widget.title;

    if (vmode == 'edit') {
      _loadData(widget.dm);
    } else if (vmode == 'add') {
      _dmid.text = '';
      _discoverymethod.text = '';
      //vinbool = false;
    }
  }

  void _loadData(DiscoveryMethod dm) async {
    _dmid.text = dm.dmid.toString();
    _discoverymethod.text = dm.discoverymethod.toString();
    vinbool = dm.inactive;
    _rowrevnum = dm.rowrevnum;
    _company = dm.company;
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
                  deleteDiscoveryMethod(widget.dm.dmid, context);
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
                controller: _dmid,
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Discovery Method needs an ID';
                    }
                  } else {
                    if (value == '') {
                      return 'Discovery Method name cannot be blank';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _discoverymethod,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Discovery Method needs an Name';
                    }
                  } else {
                    if (value == '') {
                      return 'Discovery Method name cannot be blank';
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
                vtitle = 'Edit Discovery Method';
                setState(() {});
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                //update mode
                if (vmode == 'edit' && vronly == false){

                  updateDiscoveryMethod(int.parse(_dmid.text), _company, context);
                  vtitle = 'View Discovery Method';
                } else if (vmode == 'add' && vronly == true){
                  createDiscoveryMethod(context);
                  vtitle = 'View Discovery Method';
                }
                vronly = !vronly;
                setState(() {});
              }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dmid.text = '';
    _discoverymethod.text = '';
    //vinbool = '';
    super.dispose();
  }
}

Future<String> createDiscoveryMethod(BuildContext context) async {
  bool discoverymethodcreated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final dmname = _discoverymethod.text.toString() ?? '';
    final stainactive = vinbool.toString();
    final dmcompany = _company.toString();

    final str = '{"discoverymethod":"' +
        dmname.trim() +
        '",' +
        '"inactive":"' +
        stainactive +
        '",' +
        '"company":"' +
        dmcompany +
        '"}';

    print(str);

    var postdm;
    try {
      postdm = await http.post(
        sci.serverreqaddress + '/discoverymethods',
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (postdm?.statusCode == 200) {
      print('Discovery Method: ' + _discoverymethod.text.toString() + ', created');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Discovery Method' + _discoverymethod.text.toString() + ', created.'),
        duration: Duration(seconds: 3),
      ),);
      discoverymethodcreated = true;
    }
  }

  if (discoverymethodcreated ?? false) {
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

Future<String> updateDiscoveryMethod(int dmid, int comp, BuildContext context) async {
  bool dmupdated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final discoverymethod = _discoverymethod.text.toString();
    final stainactive = vinbool.toString();
    final dmrowrevnum = _rowrevnum.toString();
    final company = comp;

    ///staid cannot be updated through here

    final str = '{"discoverymethod":"' +
        discoverymethod.trim() +
        '",' +
        '"inactive":"' +
        stainactive +
        '",' +
        '"rowrevnum":"' +
        dmrowrevnum +
        '",' +
        '"company":"' +
        company.toString() + '"}';

    print(str);

    var putdm;
    try {
      putdm = await http.put(
        sci.serverreqaddress + '/discoverymethods/' + dmid.toString(),
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (putdm?.statusCode == 200) {
      print('Discovery Method: ' + _discoverymethod.text.toString() + ', updated.');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Discovery Method' + _discoverymethod.text.toString() + ', updated.'),
        duration: Duration(seconds: 3),
      ),);
      dmupdated = true;
    }
  }

  if (dmupdated ?? false) {
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

Future<void> deleteDiscoveryMethod(int dmid, BuildContext context) async {
  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  final url = sci.serverreqaddress + '/discoverymethods/' + dmid.toString();

  var postdm = await http.delete(url);
  print(postdm.statusCode);
  if (postdm.statusCode == 200) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Discovery Method deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}
