class TicketsList {
  final List<Ticket> tickets;

  TicketsList({
    this.tickets,
  });

  factory TicketsList.fromJson(List<dynamic> parsedJson) {
    List<Ticket> ticketsList = new List<Ticket>();
    ticketsList = parsedJson.map((i)=>Ticket.fromJson(i)).toList();

    return new TicketsList(
        tickets: ticketsList
    );
  }
}

class Ticket {

  final int ticketid;
  final String ticketname;
  //final String ticketname, customername, priority, status, developerlog, entrydate, enteredby, folderpath, specialinstructrions, stopbilling, deadlinedate, erpsystem;
  //final int ticketid, customerid, priorityid, statusid, min, max, projected, totalbilled;
  //final bool quoterequired, premium;

  //final List<Resource> resource;
  //final List<POC> poc;
  //final List<Skill> skill;

  Ticket({
    this.ticketid,
    this.ticketname
    //this.customerid,
    //this.customername,
    //this.priorityid,
    //this.priority,
    //this.status,
    //this.statusid,
    //this.resource,
    //this.quoterequired,
    //this.min,
    //this.max,
    //this.projected,
    //this.developerlog,
    //this.poc,
    //this.premium,
    //this.entrydate,
    //this.enteredby,
    //this.folderpath,
    //this.specialinstructrions,
    //this.stopbilling,
    //this.totalbilled,
    //this.deadlinedate,
    //this.erpsystem,
    //this.skill,
  });

  factory Ticket.fromJson(Map<String, dynamic> parsedJson){

/*    var rlist = parsedJson['resource'] as List;
    print(rlist.runtimeType); //returns List<dynamic>
    List<Resource> resourceList = rlist.map((i) => Resource.fromJson(i)).toList();

    var plist = parsedJson['poc'] as List;
    print(plist.runtimeType); //returns List<dynamic>
    List<POC> pocList = plist.map((i) => POC.fromJson(i)).toList();

    var slist = parsedJson['skill'] as List;
    print(slist.runtimeType); //returns List<dynamic>
    List<Skill> skillList = slist.map((i) => Skill.fromJson(i)).toList();*/

    return new Ticket(
      ticketid: int.parse(parsedJson['ticketid']),
      ticketname: parsedJson['ticketname']
      //customerid: int.parse(parsedJson['customerid']),
      //customername: parsedJson['customername'],
      //priorityid: int.parse(parsedJson['priorityid']),
      //priority: parsedJson['priority'],
      //statusid: int.parse(parsedJson['statusid']),
      //status: parsedJson['status'],
      //this one needs changed
      //resource: resourceList,
      //quoterequired: parsedJson['quoterequired'],
      //min: int.parse(parsedJson['min']),
      //max: int.parse(parsedJson['max']),
      //projected: int.parse(parsedJson['projected']),
      //developerlog: parsedJson['developerlog'],
      //This one needs changed
      //poc: pocList,
      //premium: parsedJson['premium'],
      //entrydate: parsedJson['entrydate'],
      //enteredby: parsedJson['enteredby'],
      //folderpath: parsedJson['folderpath'],
      //specialinstructrions: parsedJson['specialinstructrions'],
      //stopbilling: parsedJson['stopbilling'],
      //totalbilled: int.parse(parsedJson['totalbilled']),
      //deadlinedate: parsedJson['deadlinedate'],
      //erpsystem: parsedJson['erpsystem'],
      //this one needs changed
      //skill: skillList,
    );
  }

}
/*

class Resource {
  final String resourceid, resourcename, email, extension;
  final bool inactive;

  Resource({
    this.resourceid,
    this.inactive,
    this.resourcename,
    this.email,
    this.extension
  });

  factory Resource.fromJson(Map<String, dynamic> parsedJson){

    return new Resource(
        resourceid: parsedJson['resourceid'],
        inactive: parsedJson['inactive'],
        resourcename: parsedJson['resourcename'],
        email: parsedJson['email'],
        extension: parsedJson['extension']
    );
  }
}
*/