import 'dart:async';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/data.dart';
import 'package:st_two/size_config.dart';

import 'package:http/http.dart' as http;

bool vronly = false;
String vmode = '';
String vtitle = '';

TextEditingController _industryid = TextEditingController();
TextEditingController _industryname = TextEditingController();
int _rowrevnum, _company;
bool vinbool = false;

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

      _industryid.text = '';
      _industryname.text = '';
      _vinbool = false;
      _rowrevnum = 1;
      _company =
    }
  }

  void _loadData([int indid = 0]) async {
    final session = Session();
    await session.getCompany();

    if(indid == 0){
      _industryid.text = '';
      _industryname.text = '';
      _vinbool = false;
      _rowrevnum = 1;
      _company = session.company;
    } else{
      Industry ind = await Industry().fetch(industryid, session.company);
      _industryid.text = ind.industryid.toString();
      _industryname.text = ind.industryname.toString();
      _vinbool = ind.inactive;
      _rowrevnum = ind.rowrevnum;
      _company = ind.company;
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
                  deleteIndustry(widget.industry.industryid, context);
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
                validator: (value) {
                  if (vmode == 'add') {
                    if (value.isEmpty) {
                      return 'Industry needs an Name';
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
                      child: vronly
                          ? Switch(
                              value: _vinbool,
                              onChanged: null,
                            )
                          : Switch(
                              value: _vinbool,
                              onChanged: (value) {
                                setState(() {
                                  _vinbool = value;
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
                  updateIndustry(context);
                  vtitle = 'View Industry';
                } else if (vmode == 'add' && vronly == false) {
                  if (_formKey.currentState.validate()) {
                    final str = '{"industryname":"' +
                        industryname.trim() +
                        '",' +
                        '"inactive":"' +
                        ininactive +
                        '",' +
                        '"company":"' +
                        incompany +
                        '"}';
                  }
                  createIndustry(context);
                  vtitle = 'View Industry';
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
    super.dispose();
  }
}

Future<String> createIndustry(BuildContext context) async {
  if (_formKey.currentState.validate()) {
    // If the form is valid, display a Snackbar.
    final industryname = _industryname.text.toString() ?? '';
    final ininactive = vinbool.toString();
    final incompany = 1.toString();

    final str = '{"industryname":"' +
        industryname.trim() +
        '",' +
        '"inactive":"' +
        ininactive +
        '",' +
        '"company":"' +
        incompany +
        '"}';

    print(str);

    var postindustry;
    try {
      postindustry = await http.post(
        sci.serverreqaddress + '/industries',
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (postindustry?.statusCode == 200) {
      print('Industry: ' + _industryname.text.toString() + ', created');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Industry' + _industryname.text.toString() + ', created.'),
          duration: Duration(seconds: 3),
        ),
      );
      industrycreated = true;
    }
  }

  if (industrycreated ?? false) {
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

Future<String> updateIndustry(BuildContext context) async {
  bool industryupdated;

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  if (_formKey.currentState.validate()) {
    final industryid = _industryid.text.toString();
    final industryname = _industryname.text.toString();
    final ininactive = vinbool.toString();
    final inrowrevnum = _rowrevnum.toString();
    final incompany = 1.toString();

    final str = '{"industryid":"' +
        industryid +
        '",' +
        '"industryname":"' +
        industryname.trim() +
        '",' +
        '"inactive":"' +
        ininactive +
        '",' +
        '"rowrevnum":"' +
        inrowrevnum +
        '",' +
        '"company":"' +
        incompany +
        '"}';

    var putindustry;
    try {
      putindustry = await http.put(
        sci.serverreqaddress + '/industries/' + industryid,
        headers: {'Content-type': 'application/json'},
        body: str,
      );
    } catch (e) {
      print(e);
    }

    if (putindustry?.statusCode == 200) {
      print('Industry: ' + _industryname.text.toString() + ', updated.');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Industry' + _industryname.text.toString() + ', updated.'),
          duration: Duration(seconds: 3),
        ),
      );
      industryupdated = true;
    }
  }

  if (industryupdated ?? false) {
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

Future<void> deleteIndustry(int industryid, BuildContext context) async {

  final sci = ServerConnectionInfo();
  await sci.getServerInfo();

  final url = sci.serverreqaddress + '/industries/' + industryid.toString();

  var postindustry = await http.delete(url);
  print(postindustry.statusCode);
  if (postindustry.statusCode == 200) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Industry deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}
