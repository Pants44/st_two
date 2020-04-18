import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/resource.dart';
import 'package:st_two/size_config.dart';

//For screen
bool vronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

//Objects

//Data
TextEditingController _resourceid = TextEditingController();
TextEditingController _resourcename = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _phoneext = TextEditingController();
int _rowrevnum;
bool _vinbool = false;
bool _vdefbool = false;

final _formKey = GlobalKey<FormState>();

class ResourcePage extends StatefulWidget {
  ResourcePage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.resourceid})
      : super(key: key);

  ///modes are as follows

  ///edit
  ///add

  final String mode;
  final bool ronly;
  final String title;
  final int resourceid;

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
      _loadData(widget.resourceid);
    } else if (vmode == 'add') {
      _loadData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resourceid.text = '';
    _resourcename.text = '';
    _vinbool = false;
    _vdefbool = false;
    _email.text = '';
    _phoneext.text = '';
    super.dispose();
  }

  Future<void> _loadData([int resid = 0]) async {

    if (resid == 0) {
      _resourceid.text = '';
      _resourcename.text = '';
      _email.text = '';
      _phoneext.text = '';
      _vinbool = false;
      _vdefbool = false;
      vchanged = false;
      setState((){});

    } else {
      Resource res = await Resource().fetch(resid);
      _resourceid.text = res.resourceid.toString();
      _resourcename.text = res.resourcename.toString();
      _email.text = res.email.toString();
      _phoneext.text = res.phoneext.toString();
      _vinbool = res.inactive;
      _vdefbool = res.defaultoption;
      _rowrevnum = res.rowrevnum;
      vchanged = false;
      setState((){});

    }
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
                  Resource().delete(int.parse(_resourceid.text), context);
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
                onChanged: (value){
                 vchanged = true;
                },
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Resource needs an name';
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
                    child: Text(
                      'Inactive',
                      style: TextStyle(
                        color: vronly ? Colors.grey : Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Switch(
                        value: _vinbool,
                        onChanged: vronly ? null : (v){
                          setState(() {
                            _vinbool = v == true;
                            vchanged = true;

                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Default',
                      style: TextStyle(
                        color: vronly ? Colors.grey : Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Switch(
                        value: _vdefbool,
                        onChanged: vronly ? null : (v){
                          setState(() {
                            _vdefbool = v == true;
                            vchanged = true;

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
                onChanged: (value){
                  vchanged = true;
                },
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _phoneext,
                decoration: InputDecoration(
                  labelText: 'Extension',
                ),
                onChanged: (value){
                  vchanged = true;
                },
                validator: (value){
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: (vronly == true)
          ? FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          if(_formKey.currentState.validate()){
            vronly = !vronly;
            vtitle = 'Edit Status';
          }

          setState(() {});
        },
      )
          : FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            //update mode
            if (vmode == 'edit' && vronly == false) {
              if (_formKey.currentState.validate()) {
                Future(()=>Resource().update(int.parse(_resourceid.text), _resourcename.text.trim(), _vinbool, _vdefbool, _email.text.trim(), _phoneext.text.trim(), _rowrevnum, vchanged, context)).then((v)=> _loadData(int.parse(_resourceid.text)));
                vtitle = 'View Resource';
                vronly = !vronly;
              }
            } else if (vmode == 'add' && vronly == false) {
              if (_formKey.currentState.validate()) {
                Resource().create(_resourcename.text.trim(), _vinbool, _vdefbool, _email.text.trim(), _phoneext.text.trim(), context);
                vtitle = 'View Resource';
                vronly = !vronly;
              }
            }
            setState(() {});
          }),
    );
  }
}