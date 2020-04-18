import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/skill.dart';
import 'package:st_two/size_config.dart';

//For screen
bool vronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

//Objects
final session = Session();

//Data
TextEditingController _skillid = TextEditingController();
TextEditingController _skillname = TextEditingController();
TextEditingController _description = TextEditingController();
int _rowrevnum, _company;
bool _vinbool = false;

final _formKey = GlobalKey<FormState>();

class SkillPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final int skillid;

  SkillPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.skillid})
      : super(key: key);

  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vmode = widget.mode;
    vronly = widget.ronly;
    vtitle = widget.title;

    if (vmode == 'edit') {
      _loadData(widget.skillid);
    } else if (vmode == 'add') {
      _loadData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _skillid.text = '';
    _skillname.text = '';
    _description.text = '';
    _vinbool = false;
    super.dispose();
  }

  Future<void> _loadData([int skiid = 0]) async {

    int comp = await session.getCompany();

    if (skiid == 0) {
      _skillid.text = '';
      _skillname.text = '';
      _description.text = '';
      _vinbool = false;
      _company = comp;
      vchanged = false;
      setState((){});

    } else {
      Skill ski = await Skill().fetch(comp, skiid);
      _skillid.text = ski.skillid.toString();
      _skillname.text = ski.skillname.toString();
      _description.text = ski.description.toString();
      _vinbool = ski.inactive;
      _rowrevnum = ski.rowrevnum;
      _company = ski.company;
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
                  Skill().delete(_company, int.parse(_skillid.text), context);
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
                controller: _skillid,
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _skillname,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (v){
                  vchanged = true;
                },
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Skill needs an name';
                    }
                  } else {
                    if (value == '') {
                      return 'Skill name cannot be blank';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: vronly,
                controller: _description,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onChanged: (value){
                  vchanged = true;
                },
                validator: (value) {
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
            ],
          ),
        ),
      ),
      floatingActionButton: (vronly == true)
          ? FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          vronly = !vronly;
          vtitle = 'Edit Skill';
          setState(() {});
        },
      )
          : FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            //update mode
            if (vmode == 'edit' && vronly == false) {
              if (_formKey.currentState.validate()) {
                Future(()=>Skill().update(_company, int.parse(_skillid.text), _skillname.text.trim(), _description.text.trim(), _vinbool, _rowrevnum, vchanged, context)).then((v)=> _loadData(int.parse(_skillid.text)));
                vtitle = 'View Skill';

              }
            } else if (vmode == 'add' && vronly == false) {
              if (_formKey.currentState.validate()) {
                Skill().create(_company, _skillname.text.trim(), _description.text.trim(),
                    _vinbool, context);
                vtitle = 'View Skill';
              }
            }
            vronly = !vronly;
            setState(() {});
          }),
    );
  }
}