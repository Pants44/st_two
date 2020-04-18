import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/industry.dart';
import 'package:st_two/size_config.dart';

enum ConfirmAction { CANCEL, ACCEPT }

//For screen
bool vronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

//Objects

//Data
TextEditingController _industryid = TextEditingController();
TextEditingController _industryname = TextEditingController();
int _rowrevnum;
bool _vinbool = false;
bool _vdefbool = false;

final _formKey = GlobalKey<FormState>();

class IndustryPage extends StatefulWidget {
  final String mode, title;
  final bool ronly;
  final int industryid;

  IndustryPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.industryid})
      : super(key: key);

  @override
  _IndustryPageState createState() => _IndustryPageState();
}

class _IndustryPageState extends State<IndustryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vmode = widget.mode;
    vronly = widget.ronly;
    vtitle = widget.title;

    if (vmode == 'edit') {
      _loadData(widget.industryid);
    } else if (vmode == 'add') {
      _loadData();
    }
  }

  Future<void> _loadData([int indid = 0]) async {

    if (indid == 0) {
      _industryid.text = '';
      _industryname.text = '';
      _vinbool = false;
      _vdefbool = false;
      vchanged = false;
      setState((){});

    } else {
      Industry ind = await Industry().fetch(indid);
      _industryid.text = ind.industryid.toString();
      _industryname.text = ind.industryname.toString();
      _vinbool = ind.inactive;
      _vdefbool = ind.defaultoption;
      _rowrevnum = ind.rowrevnum;
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
                  Industry().delete(int.parse(_industryid.text), context);
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
                      controller: _industryid,
                      decoration: InputDecoration(
                        labelText: 'ID',
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    TextFormField(
                      readOnly: vronly,
                      controller: _industryname,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      onChanged: (value){
                        vchanged = true;
                      },
                      validator: (value) {
                        if (vmode == 'add') {
                          if (value.isEmpty) {
                            return 'Industry needs an name';
                          }
                        } else {
                          if (value == '') {
                            return 'Industry Name cannot be blank';
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
                vtitle = 'Edit Industry';
                setState(() {});
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                //update mode
                if (vmode == 'edit' && vronly == false) {
                  if (_formKey.currentState.validate()) {
                    Future(()=>Industry().update(int.parse(_industryid.text), _industryname.text.trim(), _vinbool, _vdefbool, _rowrevnum, vchanged, context)).then((v)=> _loadData(int.parse(_industryid.text)));
                    vtitle = 'View Industry';

                  }
                } else if (vmode == 'add' && vronly == false) {
                  if (_formKey.currentState.validate()) {
                    Industry().create(_industryname.text.trim(),
                        _vinbool, _vdefbool, context);
                    vtitle = 'View Industry';
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
    _industryid.text = '';
    _industryname.text = '';
    _vinbool = false;
    _vdefbool = false;
    super.dispose();
  }
}