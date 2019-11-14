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
  final String ticketname, ticketdescription, customername, status, developerlog, entrydate, enteredby, folderpath, specialinstructionsdesc, deadlinedate, erpsystem;
  final int ticketid, customerid, priorityid, priority, statusid;
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
    this.priority,
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
  });

  factory Ticket.fromJson(Map<String, dynamic> parsedJson){

    var rlist = parsedJson['resources'] as List;
    var plist = parsedJson['pocs'] as List;
    var slist = parsedJson['skills'] as List;
    List<Resource> resourceList = rlist.map((i) => Resource.fromJson(i)).toList();
    List<POC> pocList = plist.map((i) => POC.fromJson(i)).toList();
    List<Skill> skillList = slist.map((i) => Skill.fromJson(i)).toList();

    var qrbool, prbool, sbbool, dlbool, sibool;
    if(parsedJson['quoterequired'] == 'true'){qrbool = true;}else{qrbool = false;}
    if(parsedJson['premium'] == 'true'){prbool = true;}else{prbool = false;}
    if(parsedJson['stopbilling'] == 'true'){sbbool = true;}else{sbbool = false;}
    if(parsedJson['deadline'] == 'true'){dlbool = true;}else{dlbool = false;}
    if(parsedJson['specialinstructions'] == 'true'){sibool = true;}else{sibool = false;}


    return Ticket(
      ticketid: int.parse(parsedJson['ticketid']),
      ticketname: parsedJson['ticketname'],
      ticketdescription: parsedJson['ticketdescription'],
      customerid: int.parse(parsedJson['customerid']),
      customername: parsedJson['customername'],
      priorityid: int.parse(parsedJson['priorityid']),
      priority: int.parse(parsedJson['priority']),
      statusid: int.parse(parsedJson['statusid']),
      status: parsedJson['status'],
      resources: resourceList,
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

class POC {
  final String pocname, pocphone, pocemail;
  final int pocid;

  POC({
    this.pocid,
    this.pocname,
    this.pocphone,
    this.pocemail
  });

  factory POC.fromJson(Map<String, dynamic> parsedJson){

    return new POC(
        pocid: int.parse(parsedJson['pocid']),
        pocname: parsedJson['pocname'],
        pocphone: parsedJson['pocphone'],
        pocemail: parsedJson['pocemail']
    );
  }

}

class Skill {
  final String skill;
  final int skillid;

  Skill({
    this.skillid,
    this.skill
  });

  factory Skill.fromJson(Map<String, dynamic> parsedJson){

    return new Skill(
        skillid: int.parse(parsedJson['skillid']),
        skill: parsedJson['skillname']
    );
  }
}
