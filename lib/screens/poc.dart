import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:st_two/data/poc.dart';

//Screen
bool vronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

//Data
TextEditingController tecpocid = TextEditingController();
TextEditingController tecpocname = TextEditingController();
TextEditingController tecpocemail = TextEditingController();
TextEditingController tecpocphone = TextEditingController();
TextEditingController tecpocext = TextEditingController();

int _custid, _rowrevnum;
bool _vinbool = false;
bool _vmabool = false;
bool _vccbool = false;
bool _vmcbool = false;
bool _vdobool = false;

final _formKey = GlobalKey<FormState>();

class POCPage extends StatefulWidget {
  final String mode, title;
  final bool ronly;
  final int pocid, customerid;

  POCPage({Key key, this.mode, this.ronly, this.title, this.pocid, this.customerid}) : super(key: key);

  @override
  _POCPageState createState() => _POCPageState();
}

class _POCPageState extends State<POCPage> {
  @override
  void initState() {
    super.initState();
    vmode = widget.mode.toString();
    vtitle = widget.title.toString();
    vronly = widget.ronly;
    _custid = widget.customerid;
    tecpocid.text = widget.pocid.toString();
    print(_custid.toString());
    print(tecpocid.text.toString());
    vchanged = false;

    if (vmode == 'edit') {
      _loadData(widget.customerid, widget.pocid);
    } else if (vmode == 'add') {
      _loadData(_custid);
    }
  }

  @override
  void dispose() {
    _custid = null;
    _rowrevnum = null;
    _vinbool = false;
    _vmabool = false;
    _vccbool = false;
    _vmcbool = false;
    _vdobool = false;

    super.dispose();
  }

  Future<void> _loadData(int custid, [int pocid = 0]) async {
    if (pocid == 0) {
      tecpocid.text = '';
      tecpocname.text = '';
      tecpocemail.text = '';
      tecpocphone.text = '';
      tecpocext.text = '';

      _vinbool = false;
      _vmabool = false;
      _vccbool = false;
      _vmcbool = false;
      _vdobool = false;
      vchanged = false;
      setState(() {});
    } else {
      POC p = await POC().fetch(custid, pocid);

      tecpocid.text = p.pocid.toString();
      tecpocname.text = p.pocname.toString();
      tecpocemail.text = p.pocemail.toString();
      tecpocphone.text = p.pocphone.toString();
      tecpocext.text = p.pocext.toString();
      _vinbool = p.inactive;
      _vmabool = p.mainpoc;
      _vccbool = p.connectioncontact;
      _vmcbool = p.mandatorycc;
      _vdobool = p.defaultoption;
      _rowrevnum = p.rowrevnum;
      vchanged = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'POC',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(labelText: 'ID'),
                        controller: tecpocid,
                        onChanged: (v) {
                          vchanged = true;
                        },
                        validator: (v) {
                          return null;
                        },
                      ),
                      TextFormField(
                          readOnly: vronly,
                          decoration: InputDecoration(labelText: 'Name'),
                          controller: tecpocname,
                          onChanged: (v) {
                            vchanged = true;
                          },
                          validator: (v) {
                            if (vmode == 'add') {
                              if (v.isEmpty) {
                                return 'POC needs an name';
                              }
                            } else if(v.isEmpty) {
                                return 'POC name cannot be blank';
                            }
                            return null;
                          }),
                      TextFormField(
                        readOnly: vronly,
                        decoration: InputDecoration(labelText: 'Email'),
                        controller: tecpocemail,
                        onChanged: (v) {
                          vchanged = true;
                        },
                        validator: (v) {
                          if (v.contains('@')) {
                            return null;
                          } else {
                            return 'Email is invalid. No @';
                          }
                        },
                      ),
                      TextFormField(
                          readOnly: vronly,
                          decoration: InputDecoration(labelText: 'Phone'),
                          controller: tecpocphone,
                          onChanged: (v) {
                            vchanged = true;
                          },
                          validator: (v) {
                            return null;
                          }),
                      TextFormField(
                          readOnly: vronly,
                          decoration: InputDecoration(labelText: 'Ext'),
                          controller: tecpocext,
                          onChanged: (v) {
                            vchanged = true;
                          },
                          validator: (v) {
                            return null;
                          }),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
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
                                onChanged: vronly
                                    ? null
                                    : (v) {
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
                              'Main POC',
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
                                value: _vmabool,
                                onChanged: vronly
                                    ? null
                                    : (v) {
                                        setState(() {
                                          _vmabool = v == true;
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
                              'Connection Contact',
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
                                value: _vccbool,
                                onChanged: vronly
                                    ? null
                                    : (v) {
                                        setState(() {
                                          _vccbool = v == true;
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
                              'Mandatory CC',
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
                                value: _vmcbool,
                                onChanged: vronly
                                    ? null
                                    : (v) {
                                        setState(() {
                                          _vmcbool = v == true;
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
                              'Default Option',
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
                                value: _vdobool,
                                onChanged: vronly
                                    ? null
                                    : (v) {
                                        setState(() {
                                          _vdobool = v == true;
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
              Padding(
                padding: EdgeInsets.only(bottom: 72),
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
                vtitle = 'Edit POC';
                setState(() {});
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                //update mode
                if (vmode == 'edit' && vronly == false) {
                  if (_formKey.currentState.validate()) {
                    POC()
                        .update(
                            _custid,
                            int.parse(tecpocid.text),
                            tecpocname.text,
                            tecpocemail.text,
                            tecpocphone.text,
                            int.parse(tecpocext.text),
                            _vinbool,
                            _vmabool,
                            _vccbool,
                            _vmcbool,
                            _vdobool,
                            _rowrevnum,
                            vchanged,
                            context,
                            false,
                    )
                        .then((v) => _loadData(_custid, int.parse(tecpocid.text)));
                    vtitle = 'View POC';
                    vronly = !vronly;
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                } else if (vmode == 'add' && vronly == false) {
                  if (_formKey.currentState.validate()) {
                    POC().create(tecpocname.text, tecpocemail.text, tecpocphone.text, _vinbool, _vmabool, _vccbool, _vmcbool, _vdobool, _custid, context);
                    vtitle = 'View POC';
                    vronly = !vronly;
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                }
              }),

      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          POC().create(tecpocname.text, tecpocemail.text, tecpocphone.text, _vinbool, _vmabool, _vccbool, _vmcbool, _vdobool, _custid, context);
        },
      ),*/
    );
  }
}
