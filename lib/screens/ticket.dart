import 'package:flutter/material.dart';
import 'package:st_two/data/processtickets.dart';
import 'package:st_two/size_config.dart';

bool ronly = false;

class TicketPage extends StatefulWidget {
  TicketPage({Key key, this.title, this.ticket, this.readonly})
      : super(key: key);

  final String title;
  final Ticket ticket;
  final bool readonly;

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._loadData(widget.ticket);
    this._editTicketState(widget.readonly);
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
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.all(8),
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: ListView(
            children: <Widget>[
              Card(
                  elevation: 10,
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
                        Container(
                          child: _specialInstructions(
                              widget.ticket.specialinstructions),
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
                  )),
              Card(
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
                              value: widget.ticket.premium,
                              title: Text('Premium?'),
                              onChanged: (value) {},
                            ),
                            CheckboxListTile(
                              value: widget.ticket.quoterequired,
                              title: Text('Quote Required?'),
                              onChanged: (value) {},
                            ),
                            CheckboxListTile(
                              value: widget.ticket.stopbilling,
                              title: Text('Stop Billing?'),
                              onChanged: (value) {},
                            ),
                            CheckboxListTile(
                              value: widget.ticket.deadline,
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
                              onPressed: () {
                                
                              },
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.edit, color: Colors.white,),
      ),
    );
  }

  void _loadData(Ticket ticket) async {
    tecTicketID.text = ticket.ticketid.toString();
    tecTicketName.text = ticket.ticketname.toString();
    tecTicketDescription.text = ticket.ticketdescription.toString();
    tecCustomerID.text = ticket.customerid.toString();
    tecCustomerName.text = ticket.customername.toString();
    tecPOCs.text = _whosThePOCs(ticket.pocs);
    tecPriorityID.text = ticket.priorityid.toString();
    tecPriority.text = ticket.priority.toString();
    tecStatusID.text = ticket.statusid.toString();
    tecStatus.text = ticket.status.toString();
    lstResources = ticket.resources;
    tecResources.text = _whosAssigned(ticket.resources);
    tecQuoteRequired.text = ticket.quoterequired.toString();
    tecMin.text = ticket.min.toString();
    tecMax.text = ticket.max.toString();
    tecProjected.text = ticket.projected.toString();
    tecDeveloperLog.text = ticket.developerlog.toString();
    tecPremium.text = ticket.premium.toString();
    tecEntryDate.text = ticket.entrydate.toString();
    tecEnteredBy.text = ticket.enteredby.toString();
    tecFolderPath.text = ticket.folderpath.toString();
    tecSpecialInstructionsDesc.text = ticket.specialinstructionsdesc.toString();
    tecStopBilling.text = ticket.stopbilling.toString();
    tecTotalBilled.text = ticket.totalbilled.toString();
    tecDeadlineDate.text = ticket.deadlinedate.toString();
    tecErpSystem.text = ticket.erpsystem.toString();
    tecSkills.text = _whatSkills(ticket.skills);
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

  String _whatSkills(List skilllist) {
    String skills = "";
    for (var i = 0; i < skilllist.length; i++) {
      if (i == skilllist.length - 1) {
        skills = skills + ' ' + skilllist[i].skill.toString();
      } else {
        skills = skills + skilllist[i].skill.toString() + ', ';
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
    tecTicketID.dispose();
    tecTicketName.dispose();
    tecTicketDescription.dispose();
    tecCustomerID.dispose();
    tecCustomerName.dispose();
    tecPriorityID.dispose();
    tecPriority.dispose();
    tecStatusID.dispose();
    tecStatus.dispose();
    tecResources.dispose();
    tecQuoteRequired.dispose();
    tecMin.dispose();
    tecMax.dispose();
    tecProjected.dispose();
    tecDeveloperLog.dispose();
    tecPremium.dispose();
    tecEntryDate.dispose();
    tecEnteredBy.dispose();
    tecFolderPath.dispose();
    tecSpecialInstructionsDesc.dispose();
    tecStopBilling.dispose();
    tecTotalBilled.dispose();
    tecDeadlineDate.dispose();
    tecErpSystem.dispose();
    tecSkills.dispose();
    super.dispose();
  }
}
