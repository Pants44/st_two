import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/status.dart';
import 'package:st_two/size_config.dart';


//For screen
bool vronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

//Objects

//Data
TextEditingController _statusid = TextEditingController();
TextEditingController _statusname = TextEditingController();
int _rowrevnum;
bool _vinbool = false;
bool _vdefbool = false;


final _formKey = GlobalKey<FormState>();

class StatusPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final int statusid;

  StatusPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.statusid})
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
      _loadData(widget.statusid);
    } else if (vmode == 'add') {
      _loadData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _statusid.text = '';
    _statusname.text = '';
    _vinbool = false;
    _vdefbool = false;
    super.dispose();
  }

  Future<void> _loadData([int staid = 0]) async {

    if (staid == 0) {
      _statusid.text = '';
      _statusname.text = '';
      _vinbool = false;
      _vdefbool = false;
      vchanged = false;
      setState((){});

    } else {
      Status sta = await Status().fetch(staid);
      _statusid.text = sta.statusid.toString();
      _statusname.text = sta.statusname.toString();
      _vinbool = sta.inactive;
      _vdefbool = sta.defaultoption;
      _rowrevnum = sta.rowrevnum;
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
                  Status().delete(int.parse(_statusid.text), context);
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
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _statusname,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value){
                  vchanged = true;
                },
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Status needs an name';
                    }
                  } else {
                    if (value == '') {
                      return 'Status name cannot be blank';
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
                Future(()=>Status().update(int.parse(_statusid.text), _statusname.text.trim(), _vinbool, _vdefbool, _rowrevnum, vchanged, context)).then((v)=> _loadData(int.parse(_statusid.text)));
                vtitle = 'View Status';
                vronly = !vronly;
              }
            } else if (vmode == 'add' && vronly == false) {
              if (_formKey.currentState.validate()) {
                Status().create(_statusname.text.trim(),
                    _vinbool, _vdefbool, context);
                vtitle = 'View Status';
                vronly = !vronly;
              }
            }
            setState(() {});
          }),
    );
  }
}