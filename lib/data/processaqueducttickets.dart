class TicketsList {
  final List<Ticket> tickets;

  TicketsList({
    this.tickets,
  });

  factory TicketsList.fromJson(List<dynamic> parsedJson) {
    List<Ticket> tickets = new List<Ticket>();
    tickets = parsedJson.map((i)=>Ticket.fromJson(i)).toList();

    return new TicketsList(
        tickets: tickets
    );
  }
}

class Ticket {
  final String ticketname, description, ticketlog, enteredby, folderpath, erpsystem;
  final int ticketid, rowid, rowrevnum;
  final bool quoterequired, premium, stopbilling, deadline;
  final double minhrs, maxhrs, projectedhrs, totalbilled;
  final DateTime entrydate, deadlinedate;

  final List<Resource> resources;


  Ticket({
    this.ticketid,
    this.rowid,
    this.ticketname,
    this.description,
    this.quoterequired,
    this.minhrs,
    this.maxhrs,
    this.projectedhrs,
    this.ticketlog,
    this.premium,
    this.entrydate,
    this.enteredby,
    this.folderpath,
    this.stopbilling,
    this.totalbilled,
    this.deadline,
    this.deadlinedate,
    this.erpsystem,
    this.rowrevnum,
    this.resources,
  });

  factory Ticket.fromJson(Map<String, dynamic> parsedJson){

    var rlist = parsedJson['ticketresourcesticket '] as List;
    //var plist = parsedJson['pocs'] as List;
    //var slist = parsedJson['skills'] as List;
    List<Resource> resourceList = rlist.map((i) => Resource.fromJson(i)).toList();
    //List<POC> pocList = plist.map((i) => POC.fromJson(i)).toList();
    //List<Skill> skillList = slist.map((i) => Skill.fromJson(i)).toList();

    var qrbool, prbool, sbbool, dlbool;
    if(parsedJson['quoterequired'] == 'true'){qrbool = true;}else{qrbool = false;}
    if(parsedJson['premium'] == 'true'){prbool = true;}else{prbool = false;}
    if(parsedJson['stopbilling'] == 'true'){sbbool = true;}else{sbbool = false;}
    if(parsedJson['deadline'] == 'true'){dlbool = true;}else{dlbool = false;}
    //if(parsedJson['specialinstructions'] == 'true'){sibool = true;}else{sibool = false;}


    return Ticket(
      ticketid: int.parse(parsedJson['ticketid']),
      rowid: int.parse(parsedJson["rowid"]),
      ticketname: parsedJson["ticketname"],
      description: parsedJson["description"],
      quoterequired: qrbool,
      minhrs: double.parse(parsedJson["minhrs"]),
      maxhrs: double.parse(parsedJson["maxhrs"]),
      projectedhrs: double.parse(parsedJson["projectedhrs"]),
      ticketlog: parsedJson["ticketlog"],
      premium: prbool,
      entrydate: DateTime.parse(parsedJson["entrydate"]),
      enteredby: parsedJson["enteredby"],
      folderpath: parsedJson["folderpath"],
      stopbilling: sbbool,
      totalbilled: double.parse(parsedJson["totalbilled"]),
      deadline: dlbool,
      deadlinedate: DateTime.parse(parsedJson["deadlinedate"]),
      erpsystem: parsedJson["erpsystem"],
      rowrevnum: int.parse(parsedJson["rowrevnum"]),
    );
  }

}

class Resource {
  final String resourcename, email, extension;
  final int resourceid;
  final bool inactive;

  Resource({
    this.resourceid,
    this.inactive,
    this.resourcename,
    this.email,
    this.extension
  });

  factory Resource.fromJson(Map<String, dynamic> parsedJson){

    var inbool;
    if(parsedJson['inactive'] == 'true'){inbool = true;}else{inbool = false;}

    return Resource(
        resourceid: int.parse(parsedJson['resourceid']),
        inactive: inbool,
        resourcename: parsedJson['resourcename'],
        email: parsedJson['email'],
        extension: parsedJson['extension']
    );
  }

}

//
//class POC {
//  final String pocname, pocphone, pocemail;
//  final int pocid;
//
//  POC({
//    this.pocid,
//    this.pocname,
//    this.pocphone,
//    this.pocemail
//  });
//
//  factory POC.fromJson(Map<String, dynamic> parsedJson){
//
//    return new POC(
//        pocid: int.parse(parsedJson['pocid']),
//        pocname: parsedJson['pocname'],
//        pocphone: parsedJson['pocphone'],
//        pocemail: parsedJson['pocemail']
//    );
//  }
//
//}
//
//class Skill {
//  final String skill;
//  final int skillid;
//
//  Skill({
//    this.skillid,
//    this.skill
//  });
//
//  factory Skill.fromJson(Map<String, dynamic> parsedJson){
//
//    return new Skill(
//        skillid: int.parse(parsedJson['skillid']),
//        skill: parsedJson['skill']
//    );
//  }
//}
