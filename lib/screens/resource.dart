import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/processtickets.dart';
import 'package:st_two/size_config.dart';

import 'package:http/http.dart' as http;

TextEditingController _resourceid = TextEditingController();
TextEditingController _resourcename = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _extension = TextEditingController();
bool inbool = false;
bool ronly = false;

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


  asdfasdf(){

  }

  @override
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  //State Values

  String mode;
  bool ronly;
  String title;
  Resource resource;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mode = widget.mode;
    ronly = widget.ronly;
    title = widget.title;
    resource = widget.resource;

    if (mode == 'edit') {
      _loadData(resource);
    } else if (mode == 'add') {
      _resourceid.text = '';
      _resourcename.text = '';
      inbool = false;
      _email.text = '';
      _extension.text = '';
    }
  }

  void _loadData(Resource resource) async {
    _resourceid.text = resource.resourceid.toString();
    _resourcename.text = resource.resourcename.toString();
    inbool = resource.inactive ? true : false;
    _email.text = resource.email.toString();
    _extension.text = resource.extension.toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Test Snackbar'),
                onPressed: () {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('This is a test')));
                },
              ),
              TextFormField(
                controller: _resourceid,
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                validator: (value) {
                  if(widget.mode == 'add'){
                    if (value.isEmpty) {
                      return 'Resource needs an ID';
                    }
                  }else {
                    if (value == ''){
                      return 'Resource ID cannot be null';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _resourcename,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if(widget.mode == 'add'){
                    if (value.isEmpty) {
                      return 'Resource needs an Name';
                    }
                  }else{
                    if(value == ''){
                      return 'Resource name cannot be blank';
                    }
                  }
                  return null;
                },
              ),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Inactive',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: inbool,
                      onChanged: (value) {
                        setState(() {
                          inbool = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value){
                  if(widget.mode == 'add'){
                    return null;
                  }else {
                    if(value == ''){
                      return 'Email cannot be removed after it is created';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _extension,
                decoration: InputDecoration(
                  labelText: 'Extension',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ResourceFOB(widget.mode, widget.ronly, context),
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

Widget ResourceFOB(String mode, bool readonlymode, BuildContext context) {
  if (mode == 'add') {
    return Builder(
      builder: (BuildContext context) {
        return FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            createResource(context);
          },
        );
      },
    );
  } else if (mode == 'edit') {
    if (readonlymode == true) {
      return FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: (){
          ronly = false;

        },
      );
    } else {
      return FloatingActionButton(
        child: Icon(Icons.check),
      );
    }
  }
}

Future<String> createResource(BuildContext context) async {
  bool resourcecreated;

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final resid = _resourceid.text.toString() ?? '';
    final resname = _resourcename.text.toString() ?? '';
    final resinactive = inbool.toString();
    final resemail = _email.text.toString() ?? '';
    final resextension = _extension.text.toString() ?? '';
    final resrowrevnum = 1.toString();
    final rescompany = 1.toString();

    final str = '{"resourceid":"' +
        resid.trim() +
        '",' +
        '"resourcename":"' +
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
        '",' +
        '"company":"' +
        rescompany +
        '"}';

    print(str);

    var postresource;
    try {
      postresource = await http.post(
        'http://192.168.0.110:8888/resources',
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
      ));
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

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final resid = _resourceid.text.toString();
    final resname = _resourcename.text.toString();
    final resinactive = inbool.toString();
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
        'http://192.168.0.110:8888/resources/' + resid,
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
      ));
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
  final url = 'http://192.168.0.110:8888/resources/' + resourceid.toString();

  var postresource = await http.delete(url);
  print(postresource.statusCode);
  if (postresource.statusCode == 200) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Resource deleted'),
        duration: Duration(seconds: 2 ),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}
