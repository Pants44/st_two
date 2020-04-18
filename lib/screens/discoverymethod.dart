import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/discoverymethod.dart';

import 'package:st_two/size_config.dart';

//Screen
bool vronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

//Objects

//Data
TextEditingController _dmid = TextEditingController();
TextEditingController _discoverymethod = TextEditingController();
int _rowrevnum;
bool _vinbool = false;
bool _vdefbool = false;

final _formKey = GlobalKey<FormState>();

class DiscoveryMethodPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final int dmid;

  DiscoveryMethodPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.dmid})
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
      _loadData(widget.dmid);
    } else if (vmode == 'add') {
      _loadData();
    }
  }

  Future<void> _loadData([int dmid = 0]) async {

    if (dmid == 0) {
      _dmid.text = '';
      _discoverymethod.text = '';
      _vinbool = false;
      _vdefbool = false;
      vchanged = false;
      setState((){});

    } else {
      DiscoveryMethod dm = await DiscoveryMethod().fetch(dmid);
      _dmid.text = dm.dmid.toString();
      _discoverymethod.text = dm.discoverymethod;
      _vinbool = dm.inactive;
      _vdefbool = dm.defaultoption;
      _rowrevnum = dm.rowrevnum;
      vchanged = false;
      setState((){});

    }
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
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
                  DiscoveryMethod().delete(int.parse(_dmid.text), context);
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
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _discoverymethod,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value){
                  vchanged = true;
                },
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Discovery Method needs an name';
                    }
                  } else {
                    if (value == '') {
                      return 'Discovery Method name cannot be blank';
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
                print(_dmid.text);
                print(_discoverymethod.text);
                print(_vinbool.toString());
                print(_rowrevnum.toString());
                print(vchanged.toString());
                Future(()=>DiscoveryMethod().update(int.parse(_dmid.text), _discoverymethod.text.trim(), _vinbool, _vdefbool, _rowrevnum, vchanged, context)).then((v)=> _loadData(int.parse(_dmid.text)));
                vtitle = 'View Discovery Method';

              }
            } else if (vmode == 'add' && vronly == false) {
              if (_formKey.currentState.validate()) {
                DiscoveryMethod().create(_discoverymethod.text.trim(),
                    _vinbool, _vdefbool, context);
                vtitle = 'View Discovery Method';
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
    _dmid.text = '';
    _discoverymethod.text = '';
    _vinbool = false;
    _vdefbool = false;
    super.dispose();
  }
}