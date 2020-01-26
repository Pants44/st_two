import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/data/processcustomers.dart';
import 'package:st_two/size_config.dart';

import 'package:http/http.dart' as http;

TextEditingController _skillid = TextEditingController();
TextEditingController _skillname = TextEditingController();
TextEditingController _description = TextEditingController();
bool vinbool = false;
bool vronly = false;
String vmode = '';
String vtitle = '';

final _formKey = GlobalKey<FormState>();

class SkillPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final Skill skill;

  SkillPage(
      {Key key,
      @required this.mode,
      @required this.ronly,
      this.title,
      this.skill})
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
      _loadData(widget.skill);
    } else if (vmode == 'add') {
      _skillid.text = '';
      _skillname.text = '';
      _description.text = '';
      vinbool = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _skillid.text = '';
    _skillname.text = '';
    _description.text = '';
    vinbool = false;
    super.dispose();
  }

  void _loadData(Skill skill) async {
    _skillid.text = skill.skillid.toString();
    _skillname.text = skill.skillname.toString();
    _description.text = skill.description.toString();
    vinbool = skill.inactive;
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
                  deleteSkill(widget.skill.skillid, context);
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
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Skill needs an ID';
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
                controller: _skillname,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Skill needs an Name';
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
                validator: (value) {
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
                if (vmode == 'edit' && vronly == false){

                  updateSkill(context);
                  vtitle = 'View Skill';
                }
                vronly = !vronly;
                setState(() {});
              }),
    );
  }
}

Future<String> createSkill(BuildContext context) async {
  bool skillcreated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final skillid = _skillid.text.toString() ?? '';
    final skillname = _skillname.text.toString() ?? '';
    final description = _description.text.toString() ?? '';
    final skillinactive = vinbool.toString();
    final skillrowrevnum = 1.toString();
    final skillcompany = 1.toString();

    final str = '{"skillid":"' +
        skillid.trim() +
        '",' +
        '"skillname":"' +
        skillname.trim() +
        '",' +
        '"description":"' +
        description.trim() +
        '",' +
        '"inactive":"' +
        skillinactive +
        '",' +
        '"rowrevnum":"' +
        skillrowrevnum +
        '",' +
        '"company":"' +
        skillcompany +
        '"}';

    print(str);

    var postskill;
    try {
      postskill = await http.post(
        sci.serverreqaddress + '/skills',
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (postskill?.statusCode == 200) {
      print('Skill: ' + _skillname.text.toString() + ', created');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Skill: ' + _skillname.text.toString() + ', created.'),
        duration: Duration(seconds: 3),
      ),);
      skillcreated = true;
    }
  }

  if (skillcreated ?? false) {
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

Future<String> updateSkill(BuildContext context) async {
  bool skillupdated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final skillid = _skillid.text.toString();
    final skillname = _skillname.text.toString();
    final description = _description.text.toString();
    final skillinactive = vinbool.toString();
    final skillrowrevnum = 1.toString();

    ///staid cannot be updated through here

    final str = '{"skillname":"' +
        skillname.trim() +
        '",' +
        '"description":"' +
        description.trim() +
        '",' +
        '"inactive":"' +
        skillinactive +
        '",' +
        '"rowrevnum":"' +
        skillrowrevnum +
        '"}';

    print(str);

    var putskill;
    try {
      putskill = await http.put(
        sci.serverreqaddress + '/skills/' + skillid,
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (putskill?.statusCode == 200) {
      print('Skill: ' + _skillname.text.toString() + ', updated.');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Skill' + _skillname.text.toString() + ', updated.'),
        duration: Duration(seconds: 3),
      ),);
      skillupdated = true;
    }
  }

  if (skillupdated ?? false) {
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

Future<void> deleteSkill(int skillid, BuildContext context) async {
  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  final url = sci.serverreqaddress + '/skills/' + skillid.toString();

  var postskill = await http.delete(url);
  print(postskill.statusCode);
  if (postskill.statusCode == 200) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Skill deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}