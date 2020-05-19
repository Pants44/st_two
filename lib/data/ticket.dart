import 'dart:collection';

import 'package:st_two/data/imports.dart';
import 'package:st_two/data/processdropdowns.dart';
import 'package:http/http.dart' as http;

import 'package:st_two/data/resource.dart';
import 'package:st_two/data/poc.dart';
import 'package:st_two/data/skill.dart';


class TicketList{
  final List<Ticket> tickets;

  TicketList({
    this.tickets,
  });

  factory TicketList.fromJson(List<dynamic> parsedJson) {
    List<Ticket> tickets = new List<Ticket>();
    tickets = parsedJson.map((i)=>Ticket.fromJson(i)).toList();

    return new TicketList(
        tickets: tickets
    );
  }

  Future<TicketList> fetch() async {
    final sci = ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    String comp = company.toString();

    var jsonString = await http.get(sci.serverreqaddress + '/tickets/$comp');
    final jsonResponse = json.decode(jsonString.body.toString());
    TicketList ticketlist = new TicketList.fromJson(jsonResponse);

    return ticketlist;
  }

}

class Ticket {
  final String ticketname,
      ticketdescription,
      customername,
      priorityname,
      status,
      developerlog,
      entrydate,
      enteredby,
      folderpath,
      specialinstructionsdesc,
      deadlinedate,
      erpsystem;
  final int ticketid, customerid, priorityid, statusid, rowrevnum, company;
  final double min, max, projected, totalbilled;
  final bool quoterequired, premium, stopbilling, deadline, specialinstructions;
  final List<Resource> resources;
  final List<POC> pocs;
  final List<Skill> skills;

  Ticket({
    this.ticketid,
    this.ticketname,
    this.ticketdescription,
    this.customerid,
    this.customername,
    this.priorityid,
    this.priorityname,
    this.statusid,
    this.status,
    this.resources,
    this.quoterequired,
    this.min,
    this.max,
    this.projected,
    this.developerlog,
    this.pocs,
    this.premium,
    this.entrydate,
    this.enteredby,
    this.folderpath,
    this.specialinstructionsdesc,
    this.specialinstructions,
    this.stopbilling,
    this.totalbilled,
    this.deadlinedate,
    this.deadline,
    this.erpsystem,
    this.skills,
    this.rowrevnum,
    this.company,
  });

  factory Ticket.fromJson(Map<String, dynamic> parsedJson) {
    var rlist = parsedJson['resources'] as List;
    var plist = parsedJson['pocs'] as List;
    var slist = parsedJson['skills'] as List;
    List<Resource> resourceList =
    rlist.map((i) => Resource.fromJson(i)).toList();
    List<POC> pocList = plist.map((i) => POC.fromJson(i)).toList();
    List<Skill> skillList = slist.map((i) => Skill.fromJson(i)).toList();

    var qrbool, prbool, sbbool, dlbool, sibool;
    if (parsedJson['quoterequired'] == 'true') {
      qrbool = true;
    } else {
      qrbool = false;
    }
    if (parsedJson['premium'] == 'true') {
      prbool = true;
    } else {
      prbool = false;
    }
    if (parsedJson['stopbilling'] == 'true') {
      sbbool = true;
    } else {
      sbbool = false;
    }
    if (parsedJson['deadline'] == 'true') {
      dlbool = true;
    } else {
      dlbool = false;
    }
    if (parsedJson['specialinstructions'] == 'true') {
      sibool = true;
    } else {
      sibool = false;
    }

    return Ticket(
      ticketid: int.parse(parsedJson['ticketid']),
      ticketname: parsedJson['ticketname'],
      ticketdescription: parsedJson['ticketdescription'],
      customerid: int.parse(parsedJson['customerid']),
      customername: parsedJson['customername'],
      resources: resourceList,
      priorityid: int.parse(parsedJson['priorityid']),
      priorityname: parsedJson['priorityname'],
      statusid: int.parse(parsedJson['statusid']),
      status: parsedJson['status'],
      quoterequired: qrbool,
      min: double.parse(parsedJson['minhrs']),
      max: double.parse(parsedJson['maxhrs']),
      projected: double.parse(parsedJson['projectedhrs']),
      developerlog: parsedJson['ticketlog'],
      //This one needs changed
      pocs: pocList,
      premium: prbool,
      entrydate: parsedJson['entrydate'],
      enteredby: parsedJson['enteredby'],
      folderpath: parsedJson['folderpath'],
      specialinstructionsdesc: parsedJson['specialinstructionsdesc'],
      specialinstructions: sibool,
      stopbilling: sbbool,
      totalbilled: double.parse(parsedJson['totalbilled']),
      deadlinedate: parsedJson['deadlinedate'],
      deadline: dlbool,
      erpsystem: parsedJson['erpsystem'],
      //this one needs changed
      skills: skillList,
      rowrevnum: int.parse(parsedJson['rowrevnum']),
    );
  }

  Future<Ticket> fetch(int ticketid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    Ticket ticket = Ticket();

    http.Response getTicket;
    String tickid, comp;

    try {
      comp = company.toString();
      tickid = ticketid.toString();

      getTicket =
      await http.get(sci.serverreqaddress + '/tickets/$comp,$tickid');

      final jsonResponse = json.decode(getTicket.body.toString());
      ticket = new Ticket.fromJson(jsonResponse[0]);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(getTicket);

    return ticket;
  }

  Future<void> create(String ticketname, String ticketdescription, bool quoterequired, double minhrs, double maxhrs, double projectedhrs, String ticketlog, bool premium, String enteredby, String folderpath, bool stopbilling, double totalbilled, bool deadline, String erpsystem, int customerid, int priorityid, int statusid, List<POC> pocs, List<Resource> resources, List<Skill> skills,
      [DateTime deadlinedate, BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();

    http.Response postTicket;
    String s, comp;

    try{
      comp = company.toString();
      s= '{"ticketname":"$ticketname", "ticketdescription":"$ticketdescription", "quoterequired":"$quoterequired", "minhrs":"$minhrs", "maxhrs":"$maxhrs", "projectedhrs":"$projectedhrs", "ticketlog":"$ticketlog", "premium":"$premium", "enteredby":"$enteredby", "folderpath":"$folderpath", "stopbilling":"$stopbilling", "totalbilled":"$totalbilled", "deadline":"$deadline", "erpsystem":"$erpsystem", "customerid":"$customerid", "priorityid":"$priorityid", "statusid":"$statusid", ';

      s += '"ticketpocsticket: [{"';
        pocs.forEach((p){
          s += '{"poc":{"pocid":"' + p.pocid.toString() + '"}},';
        });
      s.substring(0, s.length -1);
      s += '}],';

      s += '"ticketresourceticket: [{"';
      resources.forEach((r){
        s += '{"resource":{"resourceid":"' + r.resourceid.toString() + '"}},';
      });
      s.substring(0, s.length -1);
      s += '}],';

      s += '"ticketskillsticket: [{"';
      skills.forEach((ss){
        s += '{"skill":{"skillid":"' + ss.skillid.toString() + '"}},';
      });
      s.substring(0, s.length -1);
      s += '}]';

      postTicket = await http.post(sci.serverreqaddress + '/tickets/$comp',
          headers: {'Content-type': 'application/json'}, body: s);

    }catch(e){
      print(e);
    }

    ParseResponse().parse(postTicket, context);

  }



  Future<void> update(int ticketid, String ticketname, String ticketdescription, bool quoterequired, double minhrs, double maxhrs, double projectedhrs, String ticketlog, bool premium, String enteredby, String folderpath, bool stopbilling, double totalbilled, bool deadline, String erpsystem, int customerid, int priorityid, int statusid, List<POC> pocs, List<Resource> resource, List<Skill> skills,
      [DateTime deadlinedate, BuildContext context]) async {

    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();

    http.Response putTicket;
    String s;

    try{
      s= '{"ticketname":"$ticketname", "ticketdescription":"$ticketdescription", "quoterequired":"$quoterequired", "minhrs":"$minhrs", "maxhrs":"$maxhrs", "projectedhrs":"$projectedhrs", "ticketlog":"$ticketlog", "premium":"$premium", "enteredby":"$enteredby", "folderpath":"$folderpath", "stopbilling":"$stopbilling", "totalbilled":"$totalbilled", "deadline":"$deadline", "erpsystem":"$erpsystem", "customerid":"$customerid", "priorityid":"$priorityid", "statusid":"$statusid", ';

      s += '"ticketpocsticket: [{"';
      pocs.forEach((p){
        s += '{"poc":{"pocid":"' + p.pocid.toString() + '"}},';
      });
      s.substring(0, s.length -1);
      s += '}],';

      s += '"ticketresourceticket: [{"';
      resources.forEach((r){
        s += '{"resource":{"resourceid":"' + r.resourceid.toString() + '"}},';
      });
      s.substring(0, s.length -1);
      s += '}],';

      s += '"ticketskillsticket: [{"';
      skills.forEach((ss){
        s += '{"skill":{"skillid":"' + ss.skillid.toString() + '"}},';
      });
      s.substring(0, s.length -1);
      s += '}]';

      putTicket = await http.post(sci.serverreqaddress + '/tickets/$company,$ticketid',
          headers: {'Content-type': 'application/json'}, body: s);

    }catch(e){
      print(e);
    }

    ParseResponse().parse(putTicket, context);

  }

  Future<void> delete(int ticketid,
      [BuildContext context]) async {
    bool shouldDelete = await showDialog(
      context: context,
      child: Center(
        child: Container(
          child: AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure that you would like to delete?'),
            actions: <Widget>[
              FlatButton(child: Text('Yes'),onPressed: (){Navigator.of(context).pop(true);},),
              FlatButton(child: Text('Cancel'),onPressed: (){Navigator.of(context).pop(false);},),
            ],),
        ),
      ),
    );
    if(shouldDelete){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();
      final int company = await Session().getCompany();
      http.Response deleteCustomer;

      try {
        deleteCustomer =
        await http.delete(sci.serverreqaddress + '/tickets/$company,$ticketid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deleteCustomer, context);

    }else{
      return null;
    }
  }
}