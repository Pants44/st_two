import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/size_config.dart';

import 'package:http/http.dart' as http;

TextEditingController _resourceid = TextEditingController();
TextEditingController _resourcename = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _extension = TextEditingController();
bool vinbool = false;
bool vronly = false;
String vmode = '';
String vtitle = '';

final _formKey = GlobalKey<FormState>();

class ResourcePage extends StatefulWidget {
  ResourcePage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.resource})
      : super(key: key);

  ///modes are as follows

  ///edit
  ///add

  final String mode;
  final bool ronly;
  final String title;
  final Resource resource;

  @override
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vmode = widget.mode;
    vronly = widget.ronly;
    vtitle = widget.title;

    if (vmode == 'edit') {
      _loadData(widget.resource);
    } else if (vmode == 'add') {
      _resourceid.text = '';
      _resourcename.text = '';
      vinbool = false;
      _email.text = '';
      _extension.text = '';
    }
  }

  void _loadData(Resource resource) async {
    _resourceid.text = resource.resourceid.toString();
    _resourcename.text = resource.resourcename.toString();
    vinbool = resource.inactive ? true : false;
    _email.text = resource.email.toString();
    _extension.text = resource.extension.toString();
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
                  deleteResource(widget.resource.resourceid, context);
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
                controller: _resourceid,
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _resourcename,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Resource needs an Name';
                    }
                  } else {
                    if (value == '') {
                      return 'Resource name cannot be blank';
                    }
                  }
                  return null;
                },
              ),
              Row(
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
              ),
              TextFormField(
                readOnly: vronly,
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (widget.mode == 'add') {
                    return null;
                  } else {
                    if (value == '') {
                      return 'Email cannot be removed after it is created';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _extension,
                decoration: InputDecoration(
                  labelText: 'Extension',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: (vronly == true)
          ? FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () {
                vronly = !vronly;
                vtitle = 'Edit Resource';
                setState(() {});
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                //update mode
                if (vmode == 'edit' && vronly == false){

                  updateResource(context);
                  vtitle = 'View Resource';
                }else if (vmode == 'add' && vronly == false){
                  createResource(context);
                  vtitle = 'View Resource';
                }
                vronly = !vronly;
                setState(() {});
              }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resourceid.text = '';
    _resourcename.text = '';
    _email.text = '';
    _extension.text = '';
    super.dispose();
  }
}

Future<String> createResource(BuildContext context) async {
  bool resourcecreated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final resname = _resourcename.text.toString() ?? '';
    final resinactive = vinbool.toString();
    final resemail = _email.text.toString() ?? '';
    final resextension = _extension.text.toString() ?? '';
    final rescompany = 1.toString();

    final str = '{"resourcename":"' +
        resname.trim() +
        '",' +
        '"inactive":"' +
        resinactive +
        '",' +
        '"email":"' +
        resemail.trim() +
        '",' +
        '"extension":"' +
        resextension.trim() +
        '",' +
        '"company":"' +
        rescompany +
        '"}';

    print(str);

    var postresource;
    try {
      postresource = await http.post(
        sci.serverreqaddress + '/resources',
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (postresource?.statusCode == 200) {
      print('Resource: ' + _resourcename.text.toString() + ', created');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Resource' + _resourcename.text.toString() + ', created.'),
        duration: Duration(seconds: 3),
      ),);
      resourcecreated = true;
    }
  }

  if (resourcecreated ?? false) {
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

Future<String> updateResource(BuildContext context) async {
  bool resourceupdated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final resid = _resourceid.text.toString();
    final resname = _resourcename.text.toString();
    final resinactive = vinbool.toString();
    final resemail = _email.text.toString();
    final resextension = _extension.text.toString();
    final resrowrevnum = 1.toString();

    ///resid cannot be updated through here

    final str = '{"resourcename":"' +
        resname.trim() +
        '",' +
        '"inactive":"' +
        resinactive +
        '",' +
        '"email":"' +
        resemail.trim() +
        '",' +
        '"extension":"' +
        resextension.trim() +
        '",' +
        '"rowrevnum":"' +
        resrowrevnum +
        '"}';

    print(str);

    var putresource;
    try {
      putresource = await http.put(
        sci.serverreqaddress + '/resources/' + resid,
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (putresource?.statusCode == 200) {
      print('Resource: ' + _resourcename.text.toString() + ', updated.');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Resource' + _resourcename.text.toString() + ', updated.'),
        duration: Duration(seconds: 3),
      ),);
      resourceupdated = true;
    }
  }

  if (resourceupdated ?? false) {
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

Future<void> deleteResource(int resourceid, BuildContext context) async {
  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  final url = sci.serverreqaddress + '/resources/' + resourceid.toString();

  var delresource = await http.delete(url);
  print(delresource.statusCode);
  if (delresource.statusCode == 200) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Resource deleted'),
        duration: Duration(seconds: 1),
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
  }
}
