class TicketsList {
  final List<Ticket> tickets;

  TicketsList({
    this.tickets,
  });

  factory TicketsList.fromJson(List<dynamic> parsedJson) {
    List<Ticket> tickets = new List<Ticket>();
    tickets = parsedJson.map((i) => Ticket.fromJson(i)).toList();

    return new TicketsList(tickets: tickets);
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
  final int ticketid, customerid, priorityid, statusid;
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
    );
  }
}

class PriorityList {
  final List<Priority> priorities;

  PriorityList({
    this.priorities,
  });

  factory PriorityList.fromJson(List<dynamic> parsedJson) {
    List<Priority> priorities = new List<Priority>();
    priorities = parsedJson.map((i) => Priority.fromJson(i)).toList();

    return new PriorityList(priorities: priorities);
  }
}

class Priority {
  final int priorityid, rowrevnum, company;
  final bool inactive;
  final String priorityname;

  Priority(
      {this.priorityid,
      this.inactive,
      this.priorityname,
      this.rowrevnum,
      this.company});

  factory Priority.fromJson(Map<String, dynamic> parsedJson) {
    var inbool;
    if (parsedJson['inactive'] == 'true') {
      inbool = true;
    } else {
      inbool = false;
    }

    return Priority(
        priorityid: int.parse(parsedJson['priorityid']),
        inactive: inbool,
        priorityname: parsedJson['priorityname'],
        rowrevnum: int.parse(parsedJson['rowrevnum']),
        company: int.parse(parsedJson['company']));
  }
}

class ResourcesList {
  final List<Resource> resources;

  ResourcesList({
    this.resources,
  });

  factory ResourcesList.fromJson(List<dynamic> parsedJson) {
    List<Resource> resources = new List<Resource>();
    resources = parsedJson.map((i) => Resource.fromJson(i)).toList();

    return new ResourcesList(resources: resources);
  }
}

class Resource {
  final String resourcename, email, extension;
  final int resourceid, rowrevnum, company;
  final bool inactive;

  Resource({
    this.resourceid,
    this.inactive,
    this.resourcename,
    this.email,
    this.extension,
    this.rowrevnum,
    this.company,
  });

  factory Resource.fromJson(Map<String, dynamic> parsedJson) {
    var inbool;
    if (parsedJson['inactive'] == 'true') {
      inbool = true;
    } else {
      inbool = false;
    }

    return Resource(
      resourceid: int.parse(parsedJson['resourceid']),
      inactive: inbool,
      resourcename: parsedJson['resourcename'],
      email: parsedJson['email'],
      extension: parsedJson['extension'],
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }
}

class SkillList {
  final List<Skill> skills;

  SkillList({
    this.skills,
  });

  factory SkillList.fromJson(List<dynamic> parsedJson) {
    List<Skill> skills = new List<Skill>();
    skills = parsedJson.map((i) => Skill.fromJson(i)).toList();

    return new SkillList(skills: skills);
  }
}

class Skill {
  final String skillname, description;
  final int skillid, rowrevnum, company;
  final bool inactive;

  Skill({
    this.skillid,
    this.skillname,
    this.description,
    this.inactive,
    this.rowrevnum,
    this.company,
  });

  factory Skill.fromJson(Map<String, dynamic> parsedJson) {
    var inbool;
    if (parsedJson['inactive'] == 'true') {
      inbool = true;
    } else {
      inbool = false;
    }

    return Skill(
      skillid: int.parse(parsedJson['skillid']),
      skillname: parsedJson['skillname'],
      description: parsedJson['description'],
      inactive: inbool,
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }
}

class StatusList {
  final List<Status> statuslist;

  StatusList({this.statuslist});

  factory StatusList.fromJson(List<dynamic> parsedJson) {
    List<Status> statuslist = new List<Status>();
    statuslist = parsedJson.map((i) => Status.fromJson(i)).toList();

    return new StatusList(statuslist: statuslist);
  }
}

class Status {
  final String statusname;
  final int statusid, rowrevnum, company;
  final bool inactive;

  Status(
      {this.statusid,
      this.inactive,
      this.statusname,
      this.rowrevnum,
      this.company});

  factory Status.fromJson(Map<String, dynamic> parsedJson) {
    var inbool;
    if (parsedJson['inactive'] == 'true') {
      inbool = true;
    } else {
      inbool = false;
    }

    return Status(
      statusid: int.parse(parsedJson['statusid']),
      inactive: inbool,
      statusname: parsedJson['statusname'],
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }
}

class POC {
  final String pocname, pocphone, pocemail;
  final int pocid, rowrevnum, company;

  POC(
      {this.pocid,
      this.pocname,
      this.pocphone,
      this.pocemail,
      this.rowrevnum,
      this.company});

  factory POC.fromJson(Map<String, dynamic> parsedJson) {
    return new POC(
      pocid: int.parse(parsedJson['pocid']),
      pocname: parsedJson['pocname'],
      pocphone: parsedJson['pocphone'],
      pocemail: parsedJson['pocemail'],
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }
}
