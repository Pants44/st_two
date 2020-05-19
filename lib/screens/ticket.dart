import 'package:flutter/material.dart';
import 'package:st_two/data/ticket.dart';
import 'package:st_two/data/resource.dart';
import 'package:st_two/data/poc.dart';
import 'package:st_two/data/skill.dart';
import 'package:st_two/screens/ticketpoc.dart';
import 'package:st_two/size_config.dart';

enum ma {
  favorite,
  email,
  editresources,
  editpocs,
  editskills,
}

bool ronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

TextEditingController tecTicketID = TextEditingController();
TextEditingController tecTicketName = TextEditingController();
TextEditingController tecTicketDescription = TextEditingController();
TextEditingController tecCustomerID = TextEditingController();
TextEditingController tecCustomerName = TextEditingController();
TextEditingController tecPOCs = TextEditingController();
TextEditingController tecPriorityID = TextEditingController();
TextEditingController tecPriority = TextEditingController();
TextEditingController tecStatusID = TextEditingController();
TextEditingController tecStatus = TextEditingController();
TextEditingController tecResources = TextEditingController();
TextEditingController tecQuoteRequired = TextEditingController();
TextEditingController tecMin = TextEditingController();
TextEditingController tecMax = TextEditingController();
TextEditingController tecProjected = TextEditingController();
TextEditingController tecDeveloperLog = TextEditingController();
TextEditingController tecPremium = TextEditingController();
TextEditingController tecEntryDate = TextEditingController();
TextEditingController tecEnteredBy = TextEditingController();
TextEditingController tecFolderPath = TextEditingController();
TextEditingController tecSpecialInstructionsDesc = TextEditingController();
TextEditingController tecStopBilling = TextEditingController();
TextEditingController tecTotalBilled = TextEditingController();
TextEditingController tecDeadlineDate = TextEditingController();
TextEditingController tecErpSystem = TextEditingController();
TextEditingController tecSkills = TextEditingController();

List lstResources;
List lstPOCs;
List lstSkills;
int countofpocs = 0;
int _rowrevnum;
bool _premium, _quoterequired, _stopbilling, _deadline;

final _formKey = GlobalKey<FormState>();

class TicketPage extends StatefulWidget {
  TicketPage({Key key, this.mode, this.title, this.ticketid, this.readonly})
      : super(key: key);

  final String mode;
  final String title;
  final int ticketid;
  final bool readonly;

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._loadData(widget.ticketid);
    vmode = widget.mode.toString();
    vtitle = widget.title.toString();
    ronly = widget.readonly;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                value: ma.editresources,
                child: Text('Edit Resources'),
              ),
              const PopupMenuItem(
                value: ma.editpocs,
                child: Text('Edit POCs'),
              ),
              const PopupMenuItem(
                value: ma.editskills,
                child: Text('Edit Skills'),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case ma.editresources:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketPOCPage(
                        title: 'Edit POCs',
                        customerid: int.parse(tecCustomerID.text),
                        mode: 'edit',
                        ronly: false,
                      ),
                    ),
                  );
                  break;
                case ma.editpocs:
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketResourcePage(
                        title: 'Edit POCs',
                        customerid: int.parse(tecCustomerID.text),
                        mode: 'edit',
                        ronly: false,
                      ),
                    ),
                  );*/
                  break;
                case ma.editskills:
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketSkillPage(
                        title: 'Edit POCs',
                        customerid: int.parse(tecCustomerID.text),
                        mode: 'edit',
                        ronly: false,
                      ),
                    ),
                  );*/
                  break;
                default:
                  print('nothing defined for menu selection');
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(8),
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'General',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Ticket ID',
                        ),
                        controller: tecTicketID,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Ticket Name',
                        ),
                        controller: tecTicketName,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        maxLines: countofpocs,
                        decoration: InputDecoration(
                          labelText: 'POCs',
                        ),
                        controller: tecPOCs,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                        controller: tecTicketDescription,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ERP System',
                        ),
                        controller: tecErpSystem,
                        readOnly: ronly,
                      )
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
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Info',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Resource(s)',
                                ),
                                controller: tecResources,
                                readOnly: ronly,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Status',
                                ),
                                controller: tecStatus,
                                readOnly: ronly,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Priority',
                                ),
                                controller: tecPriority,
                                readOnly: ronly,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            CheckboxListTile(
                              value: _premium,
                              title: Text('Premium?'),
                              onChanged: (value) {},
                            ),
                            CheckboxListTile(
                              value: _quoterequired,
                              title: Text('Quote Required?'),
                              onChanged: (value) {},
                            ),
                            CheckboxListTile(
                              value: _stopbilling,
                              title: Text('Stop Billing?'),
                              onChanged: (value) {},
                            ),
                            CheckboxListTile(
                              value: _deadline,
                              title: Text('Deadline?'),
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      )
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
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Misc',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Folder Path',
                        ),
                        controller: tecFolderPath,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Skill',
                        ),
                        controller: tecSkills,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Entered By',
                        ),
                        controller: tecEnteredBy,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Entry Date',
                        ),
                        controller: tecEntryDate,
                        readOnly: ronly,
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
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Log',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Log',
                        ),
                        minLines: null,
                        maxLines: null,
                        controller: tecDeveloperLog,
                        readOnly: ronly,
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
      floatingActionButton: (ronly == true)
          ? FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () {
                ronly = !ronly;
                vtitle = 'Edit Ticket';
                setState(() {});
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                //update mode
                if (vmode == 'edit' && ronly == false) {
                  if (_formKey.currentState.validate()) {
                    //Future(() => Ticket().update(int.parse(tecTicketID.text), tecTicketName.text, tecTicketDescription.text, _quoterequired, double.parse(tecMin.text), double.parse(tecMax.text), double.parse(tecProjected.text), tecDeveloperLog.text, _premium, tecEnteredBy.text, tecFolderPath.text, _stopbilling, double.parse(tecTotalBilled.text), _deadline, tecErpSystem.text, int.parse(tecCustomerID.text), int.parse(tecPriorityID.text), int.parse(tecStatusID.text), pocs, resource, skills, DateTime.parse(tecDeadlineDate.text), context)).then((v) => _loadData(int.parse(tecTicketID.text)));
                    /*              

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
              )).then((v) => _loadData(int.parse(_custid.text)));*/
                    vtitle = 'View Ticket';
                    ronly = !ronly;
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                } else if (vmode == 'add' && ronly == false) {
                  if (_formKey.currentState.validate()) {
                    //Ticket().create(tecTicketName.text, tecTicketDescription.text, _quoterequired, double.parse(tecMin.text), double.parse(tecMax.text), double.parse(tecProjected.text), tecDeveloperLog.text, _premium, tecEnteredBy.text, tecFolderPath.text, _stopbilling, double.parse(tecTotalBilled.text), _deadline, tecErpSystem.text, int.parse(tecCustomerID.text), int.parse(tecPriorityID.text), int.parse(tecStatusID.text), pocs, resources, skills, DateTime.parse(tecDeadlineDate.text), context);
/*              Customer().create(
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
                  context);*/
                    vtitle = 'View Customer';
                    ronly = !ronly;
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                }
              }),
    );
  }

  Future<void> _loadData([int ticketid = 0]) async {
    if (ticketid == 0) {
      tecTicketID.text = '';
      tecTicketName.text = '';
      tecTicketDescription.text = '';
      tecCustomerID.text = '';
      tecCustomerName.text = '';
      tecPOCs.text = '';
      tecPriorityID.text = '';
      tecPriority.text = '';
      tecStatusID.text = '';
      tecStatus.text = '';
      tecResources.text = '';
      tecQuoteRequired.text = '';
      tecMin.text = '';
      tecMax.text = '';
      tecProjected.text = '';
      tecDeveloperLog.text = '';
      tecPremium.text = '';
      tecEntryDate.text = '';
      tecEnteredBy.text = '';
      tecFolderPath.text = '';
      tecSpecialInstructionsDesc.text = '';
      tecStopBilling.text = '';
      tecTotalBilled.text = '';
      tecDeadlineDate.text = '';
      tecErpSystem.text = '';
      tecSkills.text = '';
      lstPOCs.clear();
      lstResources.clear();
      lstSkills.clear();
      _premium = false;
      _quoterequired = false;
      _stopbilling = false;
      _deadline = false;
      _rowrevnum = 0;
      vchanged = false;
      setState(() {});
    } else {
      Ticket t = await Ticket().fetch(ticketid);
      tecTicketID.text = t.ticketid.toString();
      tecTicketName.text = t.ticketname.toString();
      tecTicketDescription.text = t.ticketdescription.toString();
      tecCustomerID.text = t.customerid.toString();
      tecCustomerName.text = t.customername.toString();
      tecPOCs.text = _whosThePOCs(t.pocs);
      tecPriorityID.text = t.priorityid.toString();
      tecPriority.text = t.priorityname.toString();
      tecStatusID.text = t.statusid.toString();
      tecStatus.text = t.status.toString();
      tecResources.text = _whosAssigned(t.resources);
      tecQuoteRequired.text = t.quoterequired.toString();
      tecMin.text = t.min.toString();
      tecMax.text = t.max.toString();
      tecProjected.text = t.projected.toString();
      tecDeveloperLog.text = t.developerlog.toString();
      tecPremium.text = t.premium.toString();
      tecEntryDate.text = t.entrydate.toString();
      tecEnteredBy.text = t.enteredby.toString();
      tecFolderPath.text = t.folderpath.toString();
      tecSpecialInstructionsDesc.text = t.specialinstructionsdesc.toString();
      tecStopBilling.text = t.stopbilling.toString();
      tecTotalBilled.text = t.totalbilled.toString();
      tecDeadlineDate.text = t.deadlinedate.toString();
      tecErpSystem.text = t.erpsystem.toString();
      tecSkills.text = _whatSkills(t.skills);
      lstSkills = t.skills;
      lstResources = t.resources;
      lstPOCs = t.pocs;
      _premium = t.premium;
      _quoterequired = t.quoterequired;
      _stopbilling = t.stopbilling;
      _deadline = t.deadline;
      _rowrevnum = t.rowrevnum;
      vchanged = false;
      setState(() {});
    }
  }

  String _whosAssigned(List resourcelist) {
    String resources = "";
    for (var i = 0; i < resourcelist.length; i++) {
      if (i == resourcelist.length - 1) {
        resources = resources + resourcelist[i].resourcename.toString();
      } else {
        resources = resources + resourcelist[i].resourcename.toString() + ", ";
      }
    }
    return resources;
  }

  String _whosThePOCs(List poclist) {
    String pocs = "";
    countofpocs = poclist.length;
    for (var i = 0; i < poclist.length; i++) {
      if (i == poclist.length - 1) {
        pocs = pocs +
            poclist[i].pocname.toString() +
            ' ' +
            poclist[i].pocemail.toString();
      } else {
        pocs = pocs +
            poclist[i].pocname.toString() +
            ' ' +
            poclist[i].pocemail.toString() +
            '\n';
      }
    }
    return pocs;
  }

  String _whatSkills(List<Skill> skilllist) {
    String skills = "";
    for (var i = 0; i < skilllist.length; i++) {
      if (i == skilllist.length - 1) {
        skills = skills + ' ' + skilllist[i].skillname.toString();
      } else {
        skills = skills + skilllist[i].skillname.toString() + ', ';
      }
    }
    return skills;
  }

  Widget _specialInstructions(bool sibool) {
    return sibool
        ? Stack(
            alignment: Alignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer'),
                controller: tecCustomerName,
                readOnly: ronly,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.warning),
                  onPressed: () {},
                ),
              ),
            ],
          )
        : Stack(
            alignment: Alignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer'),
                controller: tecCustomerName,
                readOnly: ronly,
              )
            ],
          );
  }

  void _editTicketState(bool readonly) {
    ronly = readonly;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tecTicketID.text = '';
    tecTicketName.text = '';
    tecTicketDescription.text = '';
    tecCustomerID.text = '';
    tecCustomerName.text = '';
    tecPOCs.text = '';
    tecPriorityID.text = '';
    tecPriority.text = '';
    tecStatusID.text = '';
    tecStatus.text = '';
    tecResources.text = '';
    tecQuoteRequired.text = '';
    tecMin.text = '';
    tecMax.text = '';
    tecProjected.text = '';
    tecDeveloperLog.text = '';
    tecPremium.text = '';
    tecEntryDate.text = '';
    tecEnteredBy.text = '';
    tecFolderPath.text = '';
    tecSpecialInstructionsDesc.text = '';
    tecStopBilling.text = '';
    tecTotalBilled.text = '';
    tecDeadlineDate.text = '';
    tecErpSystem.text = '';
    tecSkills.text = '';
    lstPOCs.clear();
    lstResources.clear();
    lstSkills.clear();
    _premium = false;
    _quoterequired = false;
    _stopbilling = false;
    _deadline = false;
    _rowrevnum = 0;
    vchanged = false;
    super.dispose();
  }
}
