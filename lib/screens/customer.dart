import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:st_two/data/customer.dart';
import 'package:st_two/data/poc.dart';

import 'package:st_two/screens/poc.dart';

//Screen
bool vronly = false;
bool vchanged = false;
bool vaddpoc = false;
String vmode = '';
String vtitle = '';

//Objects

//Data
enum ma {
  favorite,
  email,
  addpoc,
  deletecustomer,
}

TextEditingController _custid = TextEditingController();
TextEditingController _custname = TextEditingController();
TextEditingController _mainpocname = TextEditingController();
TextEditingController _mainpocemail = TextEditingController();
TextEditingController _portallogin = TextEditingController();
TextEditingController _portalpass = TextEditingController();
TextEditingController _sidesc = TextEditingController();
TextEditingController tecDiscoveryDescription = TextEditingController();
TextEditingController _enteredby = TextEditingController();
TextEditingController tecEnteredDate = TextEditingController();

List<TextEditingController> _pocidcontrollers = new List();
List<TextEditingController> _pocnamecontrollers = new List();
List<TextEditingController> _pocemailcontrollers = new List();
List<TextEditingController> _pocphonecontrollers = new List();
List<TextEditingController> _pocextcontrollers = new List();
List<TextEditingController> _pocinactivecontrollers = new List();
List<TextEditingController> _pocmaincontrollers = new List();
List<TextEditingController> _poccccontrollers = new List();
List<TextEditingController> _pocmandcontrollers = new List();
List<TextEditingController> _pocdefcontrollers = new List();
List<TextEditingController> _poccustcontrollers = new List();
List<TextEditingController> _pocrrncontrollers = new List();
List<TextEditingController> _poccompcontrollers = new List();

int _industry, _discoverymethod, _referredby, _rowrevnum;
bool _vinbool = false;
bool _vsibool = false;
bool _vengagebool = false;
bool _vquotereqbool = false;
bool _vconnsetupbool = false;
bool _vonholdbool = false;
bool _vblacklistbool = false;
bool _vautoemailbool = false;
bool _vmonthsupportbool = false;

List<DropdownMenuItem<String>> inddd, dmdd, refdd, pocdd;

final _formKey = GlobalKey<FormState>();

class CustomerPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final int customerid;

  CustomerPage({Key key, this.mode, this.ronly, this.title, this.customerid})
      : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Tab> myTabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    vmode = widget.mode.toString();
    vtitle = widget.title.toString();
    vronly = widget.ronly;
    myTabs = [
      Tab(text: 'Customer'),
      Tab(text: 'POCs'),
    ];
    _tabController =
        TabController(initialIndex: 0, length: myTabs.length, vsync: this);
    /*_tabController.addListener(_handleTabController);*/
    if (vmode == 'edit') {
      _loadData(widget.customerid);
    } else if (vmode == 'add') {
      _loadData();
    }
  }

  @override
  void dispose() {
    _custid.text = '';
    _custname.text = '';
    _mainpocname.text = '';
    _mainpocemail.text = '';
    _portallogin.text = '';
    _portalpass.text = '';
    _sidesc.text = '';
    tecDiscoveryDescription.text = '';
    _enteredby.text = '';
    tecEnteredDate.text = '';
    _vinbool = false;
    _vsibool = false;
    _vengagebool = false;
    _vquotereqbool = false;
    _vconnsetupbool = false;
    _vonholdbool = false;
    _vblacklistbool = false;
    _vautoemailbool = false;
    _vmonthsupportbool = false;
    _industry = null;
    _discoverymethod = null;
    _referredby = null;
    _rowrevnum = null;
    inddd = null;
    dmdd = null;
    refdd = null;
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData([int custid = 0]) async {
    if (custid == 0) {
      LinkedHashMap<int, List<DropdownMenuItem<String>>> dds =
          await Customer().prep(inddd, dmdd, refdd);
      if (dds != null) {
        inddd = dds[1];
        dmdd = dds[2];
        refdd = dds[3];
      }
      _custid.text = '';
      _custname.text = '';
      _mainpocname.text = '';
      _mainpocemail.text = '';
      _portallogin.text = '';
      _portalpass.text = '';
      _sidesc.text = '';
      tecDiscoveryDescription.text = '';
      _enteredby.text = '';
      tecEnteredDate.text = '';
      _vinbool = false;
      _vsibool = false;
      _vengagebool = false;
      _vquotereqbool = false;
      _vconnsetupbool = false;
      _vonholdbool = false;
      _vblacklistbool = false;
      _vautoemailbool = false;
      _vmonthsupportbool = false;
      vchanged = false;
      setState(() {});
    } else {
      Customer c = await Customer().fetch(custid);
      LinkedHashMap<int, List<DropdownMenuItem<String>>> dds =
          await Customer().prep(inddd, dmdd, refdd);
      if (dds != null) {
        print('dds called');
        inddd = dds[1];
        dmdd = dds[2];
        refdd = dds[3];
        print(refdd.toString());
      }
      _custid.text = c.customerid.toString();
      _custname.text = c.customername.toString();
      _mainpocname.text = c.mainpocname.toString();
      _mainpocemail.text = c.mainpocemail.toString();
      _portallogin.text = c.portallogin.toString();
      _portalpass.text = c.portalpassword.toString();
      _sidesc.text = c.sidescription.toString();
      tecDiscoveryDescription.text = c.dmdescription.toString();
      _enteredby.text = c.enteredby.toString();
      tecEnteredDate.text = c.entereddate.toString();
      _vinbool = c.inactive;
      _vsibool = c.specialinstructions;
      _vengagebool = c.engagementreceived;
      _vquotereqbool = c.quotesrequired;
      _vconnsetupbool = c.connectionsetup;
      _vonholdbool = c.onhold;
      _vblacklistbool = c.blacklisted;
      _vautoemailbool = c.autoemail;
      _vmonthsupportbool = c.monthlysupport;

      _industry = c.industryid;
      _discoverymethod = c.discoverymethodid;
      _referredby = c.referredbyid;
      _rowrevnum = c.rowrevnum;
      vchanged = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
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
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: ma.addpoc,
                child: Text('Add POC'),
              ),
              const PopupMenuItem(
                value: ma.deletecustomer,
                child: Text('Delete Customer'),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case ma.addpoc:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => POCPage(
                        title: 'Add POC',
                        customerid: int.parse(_custid.text),
                        mode: 'add',
                        ronly: false,
                      ),
                    ),
                  );
                  break;
                case ma.deletecustomer:
                  Customer().delete(int.parse(_custid.text), context);
                  break;
                default:
                  print('nothing defined for menu selection');
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.contacts)),
            Tab(icon: Icon(Icons.import_contacts)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
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
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'General',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _custid,
                            decoration: InputDecoration(
                              labelText: 'ID',
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                          TextFormField(
                              readOnly: vronly,
                              controller: _custname,
                              decoration: InputDecoration(
                                labelText: 'Name',
                              ),
                              onChanged: (v) {
                                vchanged = true;
                              },
                              validator: (v) {
                                if (vmode == 'add') {
                                  if (v.isEmpty) {
                                    return 'Customer needs an name';
                                  }
                                } else {
                                  if (v.isEmpty) {
                                    return 'Customer name cannot be blank';
                                  }
                                }
                                return null;
                              }),
                          TextFormField(
                            readOnly: vronly,
                            controller: _mainpocname,
                            decoration: InputDecoration(
                              labelText: 'Main POC Name',
                            ),
                            validator: (v) {
                              return null;
                            },
                          ),
                          TextFormField(
                            readOnly: vronly,
                            controller: _mainpocemail,
                            decoration: InputDecoration(
                              labelText: 'Main POC Email',
                            ),
                            validator: (v) {
                              return null;
                            },
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Special Instructions',
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
                                    value: _vsibool,
                                    onChanged: vronly
                                        ? null
                                        : (v) {
                                            setState(() {
                                              _vsibool = v == true;
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
                            controller: _sidesc,
                            minLines: null,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: 'Special Intstructions Description',
                            ),
                            onChanged: _vsibool
                                ? (v) {
                                    vchanged = true;
                                  }
                                : null,
                            validator: (v) {
                              return v.length > 0 && _vsibool == false
                                  ? 'Special Instructions is set to false.'
                                  : null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
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
                                  'Engagement Received',
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
                                    value: _vengagebool,
                                    onChanged: vronly
                                        ? null
                                        : (v) {
                                            setState(() {
                                              _vengagebool = v == true;
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
                                  'Quotes Required',
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
                                    value: _vquotereqbool,
                                    onChanged: vronly
                                        ? null
                                        : (v) {
                                            setState(() {
                                              _vquotereqbool = v == true;
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
                                  'Connection Setup',
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
                                    value: _vconnsetupbool,
                                    onChanged: vronly
                                        ? null
                                        : (v) {
                                            setState(() {
                                              _vconnsetupbool = v == true;
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
                                  'On Hold',
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
                                    value: _vonholdbool,
                                    onChanged: vronly
                                        ? null
                                        : (v) {
                                            setState(() {
                                              _vonholdbool = v == true;
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
                                  'Blacklisted',
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
                                    value: _vblacklistbool,
                                    onChanged: vronly
                                        ? null
                                        : (v) {
                                            setState(() {
                                              _vblacklistbool = v == true;
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
                                  'Auto Email',
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
                                    value: _vautoemailbool,
                                    onChanged: vronly
                                        ? null
                                        : (v) {
                                            setState(() {
                                              _vautoemailbool = v == true;
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
                                  'Monthly Support',
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
                                    value: _vmonthsupportbool,
                                    onChanged: vronly
                                        ? null
                                        : (v) {
                                            setState(() {
                                              _vmonthsupportbool = v == true;
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
                  Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Industry',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          IgnorePointer(
                            ignoring: vronly,
                            child: DropdownButton(
                                items: inddd,
                                isExpanded: true,
                                hint: Text('Industry Name'),
                                value: _industry == null
                                    ? "0"
                                    : _industry.toString(),
                                onChanged: (v) {
                                  _industry = int.parse(v);
                                  vchanged = true;
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Discovery',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          IgnorePointer(
                            ignoring: vronly,
                            child: DropdownButton(
                                items: dmdd,
                                isExpanded: true,
                                value: _discoverymethod == null
                                    ? "0"
                                    : _discoverymethod.toString(),
                                hint: Text('Discovery Method'),
                                onChanged: (v) {
                                  setState(() {
                                    _discoverymethod = int.parse(v);
                                  });
                                  vchanged = true;
                                }),
                          ),
                          IgnorePointer(
                            ignoring: vronly,
                            child: DropdownButton(
                                items: refdd,
                                isExpanded: true,
                                value: _referredby == null
                                    ? "0"
                                    : _referredby.toString(),
                                hint: Text('Referred By'),
                                onChanged: (v) {
                                  setState(() {
                                    _referredby = int.parse(v);
                                  });
                                  vchanged = true;
                                }),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Other',
                            ),
                            readOnly: vronly,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'ST Portal',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          TextFormField(
                            readOnly: vronly,
                            controller: _portallogin,
                            decoration: InputDecoration(
                              labelText: 'Login',
                            ),
                            onChanged: (v) {
                              vchanged = true;
                            },
                          ),
                          TextFormField(
                            readOnly: vronly,
                            controller: _portalpass,
                            decoration: InputDecoration(
                              labelText: 'Pass',
                            ),
                            onChanged: (v) {
                              vchanged = true;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Misc',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          TextFormField(
                            readOnly: vronly,
                            controller: _enteredby,
                            decoration: InputDecoration(
                              labelText: 'Entered By',
                            ),
                            validator: (v) {
                              if (v.isEmpty) {
                                //This is simply a safety net. this should not happen
                                return "Entered By cannot be empty. Record keeping is important";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: tecEnteredDate,
                            decoration: InputDecoration(
                              labelText: 'Entered Date',
                            ),
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
          Container(
            padding: EdgeInsets.all(8),
            child: Form(
              child: FutureBuilder<POCList>(
                future: POCList().fetch(int.parse(_custid.text.toString())),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.pocs.length,
                            itemBuilder: (BuildContext cntext, int index) {
                              _pocidcontrollers
                                  .add(new TextEditingController());
                              _pocnamecontrollers
                                  .add(new TextEditingController());
                              _pocemailcontrollers
                                  .add(new TextEditingController());
                              _pocphonecontrollers
                                  .add(new TextEditingController());
                              _pocextcontrollers
                                  .add(new TextEditingController());
                              _pocinactivecontrollers
                                  .add(new TextEditingController());
                              _pocmaincontrollers
                                  .add(new TextEditingController());
                              _poccccontrollers
                                  .add(new TextEditingController());
                              _pocmandcontrollers
                                  .add(new TextEditingController());
                              _pocdefcontrollers
                                  .add(new TextEditingController());
                              _poccustcontrollers
                                  .add(new TextEditingController());
                              _pocrrncontrollers
                                  .add(new TextEditingController());
                              _poccompcontrollers
                                  .add(new TextEditingController());

                              _pocidcontrollers[index].text =
                                  snapshot.data.pocs[index].pocid.toString();
                              _pocnamecontrollers[index].text =
                                  snapshot.data.pocs[index].pocname;
                              _pocemailcontrollers[index].text =
                                  snapshot.data.pocs[index].pocemail;
                              _pocphonecontrollers[index].text =
                                  snapshot.data.pocs[index].pocphone;
                              _pocextcontrollers[index].text =
                                  snapshot.data.pocs[index].pocext;
                              _pocinactivecontrollers[index].text =
                                  snapshot.data.pocs[index].inactive.toString();
                              _pocmaincontrollers[index].text =
                                  snapshot.data.pocs[index].mainpoc.toString();
                              _poccccontrollers[index].text = snapshot
                                  .data.pocs[index].connectioncontact
                                  .toString();
                              _pocmandcontrollers[index].text = snapshot
                                  .data.pocs[index].mandatorycc
                                  .toString();
                              _pocdefcontrollers[index].text = snapshot
                                  .data.pocs[index].defaultoption
                                  .toString();
                              _poccustcontrollers[index].text = snapshot
                                  .data.pocs[index].customerid
                                  .toString();
                              _pocrrncontrollers[index].text = snapshot
                                  .data.pocs[index].rowrevnum
                                  .toString();
                              _poccompcontrollers[index].text =
                                  snapshot.data.pocs[index].company.toString();

                              final Alignment al = Alignment.centerLeft;

                              return Card(
                                elevation: 5,
                                child: GestureDetector(
                                  onLongPressEnd: (v) {},
                                  child: ExpansionTile(
                                    leading: _pocmaincontrollers[index].text ==
                                            'true'
                                        ? Checkbox(
                                            value: true,
                                            onChanged: null,
                                          )
                                        : null,
                                    title:
                                        Text(_pocnamecontrollers[index].text),
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('ID: ' +
                                                      _pocidcontrollers[index]
                                                          .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('Name: ' +
                                                      _pocnamecontrollers[index]
                                                          .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('Phone: ' +
                                                      _pocphonecontrollers[
                                                              index]
                                                          .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('Ext: ' +
                                                      _pocextcontrollers[index]
                                                          .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('Email: ' +
                                                      _pocemailcontrollers[
                                                              index]
                                                          .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text('Inactive: '),
                                                      Checkbox(
                                                        value:
                                                            _pocinactivecontrollers[
                                                                        index]
                                                                    .text ==
                                                                'true',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('MainPOC?: ' +
                                                      _pocmaincontrollers[index]
                                                          .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text(
                                                      'Connection Contact: ' +
                                                          _poccccontrollers[
                                                                  index]
                                                              .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('Mandatory CC: ' +
                                                      _pocmandcontrollers[index]
                                                          .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text(
                                                      'DefaultOption: ' +
                                                          _pocdefcontrollers[
                                                                  index]
                                                              .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('Customer: ' +
                                                      _poccustcontrollers[index]
                                                          .text),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Align(
                                                  alignment: al,
                                                  child: Text('Company: ' +
                                                      _poccompcontrollers[index]
                                                          .text),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    icon: Icon(Icons.edit),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              POCPage(
                                                            title: 'View POC',
                                                            customerid: int.parse(
                                                                _poccustcontrollers[
                                                                        index]
                                                                    .text),
                                                            pocid: int.parse(
                                                                _pocidcontrollers[
                                                                        index]
                                                                    .text),
                                                            mode: 'edit',
                                                            ronly: true,
                                                          ),
                                                        ),
                                                      );
                                                      /*POC().update(
                                                          int.parse(
                                                              _poccustcontrollers[index]
                                                                  .text),
                                                          int.parse(
                                                              _pocidcontrollers[index]
                                                                  .text),
                                                          _pocnamecontrollers[index]
                                                              .text,
                                                          _pocemailcontrollers[index]
                                                              .text,
                                                          _pocphonecontrollers[index]
                                                              .text,
                                                          _pocinactivecontrollers[
                                                          index]
                                                              .text ==
                                                              'true',
                                                          _pocmaincontrollers[index].text ==
                                                              'true',
                                                          _poccccontrollers[index]
                                                              .text ==
                                                              'true',
                                                          _pocmandcontrollers[
                                                          index]
                                                              .text ==
                                                              'true',
                                                          _pocdefcontrollers[index]
                                                              .text ==
                                                              'true',
                                                          int.parse(
                                                              _pocrrncontrollers[
                                                              index]
                                                                  .text),
                                                          vchanged).whenComplete((){
                                                        setState((){});
                                                      });*/
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    icon: Icon(Icons.delete),
                                                    onPressed: () {
                                                      POC()
                                                          .delete(
                                                              int.parse(
                                                                  _poccustcontrollers[
                                                                          index]
                                                                      .text),
                                                              int.parse(
                                                                  _pocidcontrollers[
                                                                          index]
                                                                      .text),
                                                              context,
                                                              true)
                                                          .whenComplete(() {
                                                        setState(() {});
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: (vronly == true)
          ? FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () {
                vronly = !vronly;
                vtitle = 'Edit Customer';
                setState(() {});
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                //update mode
                if (vmode == 'edit' && vronly == false) {
                  if (_formKey.currentState.validate()) {
                    Future(() => Customer().update(
                          int.parse(_custid.text),
                          _custname.text,
                          _vinbool,
                          _vengagebool,
                          _vquotereqbool,
                          _vconnsetupbool,
                          _vonholdbool,
                          _vblacklistbool,
                          _vautoemailbool,
                          _vmonthsupportbool,
                          _vsibool,
                          _enteredby.text,
                          _industry,
                          _rowrevnum,
                          vchanged,
                          _discoverymethod,
                          _sidesc.text,
                          _portallogin.text,
                          _portalpass.text,
                          _referredby,
                          context,
                        )).then((v) => _loadData(int.parse(_custid.text)));
                    vtitle = 'View Customer';
                    vronly = !vronly;
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                } else if (vmode == 'add' && vronly == false) {
                  if (_formKey.currentState.validate()) {
                    Customer().create(
                        _custname.text.trim(),
                        _vinbool,
                        _vengagebool,
                        _vquotereqbool,
                        _vconnsetupbool,
                        _vonholdbool,
                        _vblacklistbool,
                        _vautoemailbool,
                        _vmonthsupportbool,
                        _vsibool,
                        _enteredby.text.trim(),
                        _industry,
                        _discoverymethod,
                        _sidesc.text.trim(),
                        _portallogin.text.trim(),
                        _portalpass.text.trim(),
                        _referredby,
                        context);
                    vtitle = 'View Customer';
                    vronly = !vronly;
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                }
              }),
    );
  }
}

/*void _handleTabController() {
  print('tab changed');
  vronly = true;
  vmode = 'add';
}*/
