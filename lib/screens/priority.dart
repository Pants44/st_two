import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/priority.dart';
import 'package:st_two/size_config.dart';


//For screen
bool vronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

//Objects

//Data
TextEditingController _priorityid = TextEditingController();
TextEditingController _priorityname = TextEditingController();
int _rowrevnum;
bool _vinbool = false;
bool _vdefbool = false;

final _formKey = GlobalKey<FormState>();

class PriorityPage extends StatefulWidget {
  final String mode, title;
  final bool ronly;
  final int priorityid;

  PriorityPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.priorityid})
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
      _loadData(widget.priorityid);
    } else if (vmode == 'add') {
      _loadData();
    }
  }

  Future<void> _loadData([int priid = 0]) async {

    if (priid == 0) {
      _priorityid.text = '';
      _priorityname.text = '';
      _vinbool = false;
      _vdefbool = false;
      vchanged = false;
      setState((){});

    } else {
      Priority pri = await Priority().fetch(priid);
      _priorityid.text = pri.priorityid.toString();
      _priorityname.text = pri.priorityname.toString();
      _vinbool = pri.inactive;
      _vdefbool = pri.defaultoption;
      _rowrevnum = pri.rowrevnum;
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
                  Priority().delete(int.parse(_priorityid.text), context);
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
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _priorityname,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value){
                  vchanged = true;
                },
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Priority needs an name';
                    }
                  } else {
                    if (value == '') {
                      return 'Priority name cannot be blank';
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
          vronly = !vronly;
          vtitle = 'Edit Priority';
          setState(() {});
        },
      )
          : FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            //update mode
            if (vmode == 'edit' && vronly == false) {
              if (_formKey.currentState.validate()) {
                Future(()=>Priority().update(int.parse(_priorityid.text), _priorityname.text.trim(), _vinbool, _vdefbool, _rowrevnum, vchanged, context)).then((v)=> _loadData(int.parse(_priorityid.text)));
                vtitle = 'View Priority';

              }
            } else if (vmode == 'add' && vronly == false) {
              if (_formKey.currentState.validate()) {
                Priority().create(_priorityname.text.trim(),
                    _vinbool, _vdefbool, context);
                vtitle = 'View Priority';
              }
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
    _vinbool = false;
    _vdefbool = false;
    super.dispose();
  }
}