import 'package:flutter/material.dart';
import 'package:st_two/screens/home.dart';
import 'package:st_two/data/processtickets.dart';

class TicketPage extends StatefulWidget {
  TicketPage({Key key, this.title, this.ticket}) : super(key: key);

  final String title;
  final Ticket ticket;

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  TextEditingController tecTicketID = TextEditingController();
  TextEditingController tecTicketName = TextEditingController();
  TextEditingController tecTicketDescription = TextEditingController();
  TextEditingController tecCustomerID = TextEditingController();
  TextEditingController tecCustomerName = TextEditingController();
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
  TextEditingController tecSpecialInstructions = TextEditingController();
  TextEditingController tecStopBilling = TextEditingController();
  TextEditingController tecTotalBilled = TextEditingController();
  TextEditingController tecDeadlineDate = TextEditingController();
  TextEditingController tecErpSystem = TextEditingController();

  List lstResources;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._loadData(widget.ticket);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text(widget.title),
          actions: <Widget>[
            Hero(
              tag: 'logoappbar',
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
                child: Image(
                  image: AssetImage('assets/st22000.png'),
                ),
              ),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: tecTicketID,
            ),
            TextField(
              controller: tecTicketName,
            ),
            TextField(
              controller: tecCustomerID,
            ),
            TextField(
              controller: tecCustomerName,
            ),
            TextField(
              controller: tecPriorityID,
            ),
            TextField(
              controller: tecPriority,
            ),
            TextField(
              controller: tecStatusID,
            ),
            TextField(
              controller: tecStatus,
            ),
            TextField(
              controller: tecResources,
              readOnly: true,
              onTap: (){

              },
            ),
            TextField(
              controller: tecQuoteRequired,
            ),
            TextField(
              controller: tecMin,
            ),
            TextField(
              controller: tecMax,
            ),
            TextField(
              controller: tecProjected,
            ),
            TextField(
              controller: tecDeveloperLog,
            ),
            TextField(
              controller: tecPremium,
            ),
            TextField(
              controller: tecEntryDate,
            ),
            TextField(
              controller: tecEnteredBy,
            ),
            TextField(
              controller: tecFolderPath,
            ),
            TextField(
              controller: tecSpecialInstructions,
            ),
            TextField(
              controller: tecStopBilling,
            ),
            TextField(
              controller: tecTotalBilled,
            ),
            TextField(
              controller: tecDeadlineDate,
            ),
            TextField(
              controller: tecErpSystem,
            )
          ],
        ),
    );
  }

  void _loadData(Ticket ticket) async {
    tecTicketID.text = ticket.ticketid.toString();
    tecTicketName.text = ticket.ticketname.toString();
    tecTicketDescription.text = ticket.ticketdescription.toString();
    tecCustomerID.text = ticket.customerid.toString();
    tecCustomerName.text = ticket.customername.toString();
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
    tecSpecialInstructions.text = ticket.specialinstructions.toString();
    tecStopBilling.text = ticket.stopbilling.toString();
    tecTotalBilled.text = ticket.totalbilled.toString();
    tecDeadlineDate.text = ticket.deadlinedate.toString();
    tecErpSystem.text = ticket.erpsystem.toString();
  }

  String _whosAssigned(List resourcelist){
    String resources="";
    for(var i = 0; i < resourcelist.length; i++){
      if(i == resourcelist.length-1){
        resources = resources + resourcelist[i].resourcename.toString();
      }else{
        resources = resources + resourcelist[i].resourcename.toString() + ", ";
      }

    }
    print('__Ticket__whosAssigned__' + resources + '__');
    return resources;
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
    tecSpecialInstructions.dispose();
    tecStopBilling.dispose();
    tecTotalBilled.dispose();
    tecDeadlineDate.dispose();
    tecErpSystem.dispose();
    super.dispose();
  }
}
