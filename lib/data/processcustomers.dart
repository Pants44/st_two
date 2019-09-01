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
  final String customername, mainpocname, mainpocemail, portallogin, portalpassword, specialinstructionsdesc, discoverydescription, referredby, referredbyid, enteredby, entereddate;
  final int customerid, industryid, discoverymethodid;
  final bool inactive, specialinstructions, engagementreceived, quotesrequired, connectionsetup, onhold, blacklisted, autoemail, monthlysupport;

  Customer({
    this.customerid,
    this.mainpocname,
    this.mainpocemail,
    this.industryid,
    this.discoverymethodid,
    this.referredbyid,
    this.referredby,
    this.customername,
    this.portallogin,
    this.portalpassword,
    this.specialinstructionsdesc,
    this.specialinstructions,
    this.discoverydescription,
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
  });

  factory Customer.fromJson(Map<String, dynamic> parsedJson){

    var sibool, inbool, erbool, qrbool, csbool, ohbool, blbool, aebool, msbool;
    if(parsedJson['specialinstructions'] == 'true'){sibool = true;}else{sibool = false;}
    if(parsedJson['inactive'] == 'true'){inbool = true;}else{inbool = false;}
    if(parsedJson['engagementreceived'] == 'true'){erbool = true;}else{erbool = false;}
    if(parsedJson['quoterequired'] == 'true'){qrbool = true;}else{qrbool = false;}
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
      discoverymethodid: int.parse(parsedJson['discoverymethodid']),
      referredbyid: parsedJson['referredbyid'],
      referredby: parsedJson['referredby'],
      customername: parsedJson['customername'],
      portallogin: parsedJson['portallogin'],
      portalpassword: parsedJson['portalpassword'],
      specialinstructions: sibool,
      specialinstructionsdesc: parsedJson['specialinstructionsdesc'],
      discoverydescription: parsedJson['discoverydescription'],
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
    );
  }
}