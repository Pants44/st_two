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
  final String quoterequired, premium, ticketname, ticketdescription, customername, status, developerlog, entrydate, enteredby, folderpath, specialinstructions, stopbilling, deadlinedate, erpsystem;
  final int ticketid, customerid, priorityid, priority, statusid, min, max, projected, totalbilled;

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
    this.specialinstructions,
    this.stopbilling,
    this.totalbilled,
    this.deadlinedate,
    this.erpsystem,
    this.skills,
  });

  factory Ticket.fromJson(Map<String, dynamic> parsedJson){

    var rlist = parsedJson['resources'] as List;
    //print(list.runtimeType);
    List<Resource> resourceList = rlist.map((i) => Resource.fromJson(i)).toList();

    var plist = parsedJson['pocs'] as List;
    //print(list.runtimeType);
    List<POC> pocList = plist.map((i) => POC.fromJson(i)).toList();

    var slist = parsedJson['skills'] as List;
    //print(list.runtimeType);
    List<Skill> skillList = slist.map((i) => Skill.fromJson(i)).toList();

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
      quoterequired: parsedJson['quoterequired'],
      min: int.parse(parsedJson['min']),
      max: int.parse(parsedJson['max']),
      projected: int.parse(parsedJson['projected']),
      developerlog: parsedJson['developerlog'],
      //This one needs changed
      pocs: pocList,
      premium: parsedJson['premium'],
      entrydate: parsedJson['entrydate'],
      enteredby: parsedJson['enteredby'],
      folderpath: parsedJson['folderpath'],
      specialinstructions: parsedJson['specialinstructions'],
      stopbilling: parsedJson['stopbilling'],
      totalbilled: int.parse(parsedJson['totalbilled']),
      deadlinedate: parsedJson['deadlinedate'],
      erpsystem: parsedJson['erpsystem'],
      //this one needs changed
      skills: skillList,
    );
  }

}

class Resource {
  final String resourceid, resourcename, email, extension, inactive;

  Resource({
    this.resourceid,
    this.inactive,
    this.resourcename,
    this.email,
    this.extension
  });

  factory Resource.fromJson(Map<String, dynamic> parsedJson){

    return Resource(
        resourceid: parsedJson['resourceid'],
        inactive: parsedJson['inactive'],
        resourcename: parsedJson['resourcename'],
        email: parsedJson['email'],
        extension: parsedJson['extension']
    );
  }

}

class POC {
  final int pocid;
  final String pocname, phone, email;

  POC({
    this.pocid,
    this.pocname,
    this.phone,
    this.email
  });

  factory POC.fromJson(Map<String, dynamic> parsedJson){

    return new POC(
        pocid: int.parse(parsedJson['pocid']),
        pocname: parsedJson['pocname'],
        phone: parsedJson['phone'],
        email: parsedJson['email']
    );
  }

}

class Skill {
  final int skillid;
  final String skill;

  Skill({
    this.skillid,
    this.skill
  });

  factory Skill.fromJson(Map<String, dynamic> parsedJson){

    return new Skill(
        skillid: int.parse(parsedJson['skillid']),
        skill: parsedJson['skill']
    );
  }
}
