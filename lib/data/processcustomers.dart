class CustomerList{
  final List<Customer> customers;

  CustomerList({
    this.customers,
   });

  factory CustomerList.fromJson(List<dynamic> parsedJson) {
    List<Customer> customers = new List<Customer>();
    customers = parsedJson.map((i)=>Customer.fromJson(i)).toList();

    return new CustomerList(
      customers: customers
    );
  }
}

class Customer {
  final String customername, mainpocname, mainpocemail, industryname, portallogin, portalpassword, sidescription, dmdescription, referredby, referredbyid, enteredby, entereddate;
  final int customerid, industryid, discoverymethodid, rowrevnum, company;
  final bool inactive, specialinstructions, engagementreceived, quotesrequired, connectionsetup, onhold, blacklisted, autoemail, monthlysupport;

  Customer({
    this.customerid,
    this.mainpocname,
    this.mainpocemail,
    this.industryid,
    this.industryname,
    this.discoverymethodid,
    this.referredbyid,
    this.referredby,
    this.customername,
    this.portallogin,
    this.portalpassword,
    this.sidescription,
    this.specialinstructions,
    this.dmdescription,
    this.inactive,
    this.engagementreceived,
    this.quotesrequired,
    this.connectionsetup,
    this.onhold,
    this.blacklisted,
    this.autoemail,
    this.monthlysupport,
    this.enteredby,
    this.entereddate,
    this.rowrevnum,
    this.company,
  });

  factory Customer.fromJson(Map<String, dynamic> parsedJson){

    var sibool, inbool, erbool, qrbool, csbool, ohbool, blbool, aebool, msbool;
    if(parsedJson['specialinstructions'] == 'true'){sibool = true;}else{sibool = false;}
    if(parsedJson['inactive'] == 'true'){inbool = true;}else{inbool = false;}
    if(parsedJson['engagementreceived'] == 'true'){erbool = true;}else{erbool = false;}
    if(parsedJson['quotesrequired'] == 'true'){qrbool = true;}else{qrbool = false;}
    if(parsedJson['connectionsetup'] == 'true'){csbool = true;}else{csbool = false;}
    if(parsedJson['onhold'] == 'true'){ohbool = true;}else{ohbool = false;}
    if(parsedJson['blacklisted'] == 'true'){blbool = true;}else{blbool = false;}
    if(parsedJson['autoemail'] == 'true'){aebool = true;}else{aebool = false;}
    if(parsedJson['monthlysupport'] == 'true'){msbool = true;}else{msbool = false;}

    return Customer(
      customerid: int.parse(parsedJson['customerid']),
      mainpocname: parsedJson['mainpocname'],
      mainpocemail: parsedJson['mainpocemail'],
      industryid: int.parse(parsedJson['industryid']),
      industryname: parsedJson['industryname'],
      referredbyid: parsedJson['referredbyid'],
      referredby: parsedJson['referredby'],
      customername: parsedJson['customername'],
      portallogin: parsedJson['portallogin'],
      portalpassword: parsedJson['portalpassword'],
      specialinstructions: sibool,
      sidescription: parsedJson['sidescription'],
      discoverymethodid: int.tryParse(parsedJson['dmid']),
      dmdescription: parsedJson['dmdescription'],
      inactive: inbool,
      engagementreceived: erbool,
      quotesrequired: qrbool,
      connectionsetup: csbool,
      onhold: ohbool,
      blacklisted: blbool,
      autoemail: aebool,
      monthlysupport: msbool,
      enteredby: parsedJson['enteredby'],
      entereddate: parsedJson['entereddate'],
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }
}

class DiscoveryMethodList {
  final List<DiscoveryMethod> discoverymethods;

  DiscoveryMethodList({
    this.discoverymethods,
  });

  factory DiscoveryMethodList.fromJson(List<dynamic> parsedJson) {
    List<DiscoveryMethod> discoverymethods = new List<DiscoveryMethod>();
    discoverymethods = parsedJson.map((i)=>DiscoveryMethod.fromJson(i)).toList();

    return new DiscoveryMethodList(
        discoverymethods: discoverymethods
    );
  }
}

class IndustryList {
  final List<Industry> industries;

  IndustryList({
    this.industries
  });

  factory IndustryList.fromJson(List<dynamic> parsedJson) {
    List<Industry> industries = new List<Industry>();
    industries = parsedJson.map((i)=>Industry.fromJson(i)).toList();

    return new IndustryList(
        industries: industries
    );
  }

}

class Industry {
  final String industryname;
  final int industryid, rowrevnum, company;
  final bool inactive;

  Industry({
    this.industryid,
    this.inactive,
    this.industryname,
    this.rowrevnum,
    this.company,
  });

  factory Industry.fromJson(Map<String, dynamic> parsedJson){

    return Industry(
      industryid: int.tryParse(parsedJson['industryid']),
      inactive: bool.fromEnvironment(parsedJson['inactive']),
      industryname: parsedJson['industryname'],
      rowrevnum: int.tryParse(parsedJson['rowrevnum']),
      company: int.tryParse(parsedJson['company']),
    );
  }
}

class DiscoveryMethod {
  final String discoverymethod;
  final int dmid, rowrevnum, company;
  final bool inactive;

  DiscoveryMethod({
    this.dmid,
    this.inactive,
    this.discoverymethod,
    this.rowrevnum,
    this.company
  });

  factory DiscoveryMethod.fromJson(Map<String, dynamic> parsedJson){

    return DiscoveryMethod(
      dmid: int.parse(parsedJson['dmid']),
      inactive: bool.fromEnvironment(parsedJson['inactive']),
      discoverymethod: parsedJson['discoverymethod'],
    );
  }

}