class EverythingList{
  final String everythinglistid;
  final List<Ticket> tickets;
  final List<Customer> customers;
  final List<POC> pocs;

  EverythingList({
    this.everythinglistid,
    this.tickets,
    this.customers,
    this.pocs
  });

  factory EverythingList.fromJson(Map<String, dynamic> parsedJson){

    var tlist = parsedJson['tickets'] as List;
    var clist = parsedJson['customers'] as List;
    var plist = parsedJson['pocs'] as List;
    List<Ticket> ticketList = tlist.map((i) => Ticket.fromJson(i)).toList();
    List<Customer> customerList = clist.map((i) => Customer.fromJson(i)).toList();
    List<POC> pocList = plist.map((i) => POC.fromJson(i)).toList();

    return new EverythingList(
      everythinglistid: parsedJson['everythinglistid'],
      tickets: ticketList,
      customers: customerList,
      pocs: pocList
    );

  }
}

class Ticket{
  final int ticketid;
  final String ticketname, ticketdescription;

  Ticket({
    this.ticketid,
    this.ticketname,
    this.ticketdescription
  });

  factory Ticket.fromJson(Map<String, dynamic> parsedJson){
    return new Ticket(
      ticketid: int.parse(parsedJson['ticketid']),
      ticketname: parsedJson['ticketname'],
      ticketdescription: parsedJson['ticketdescription']
    );
  }

}

class Customer{

  final int customerid;
  final String customername;

  Customer({
    this.customerid,
    this.customername
  });

  factory Customer.fromJson(Map<String, dynamic> parsedJson){
    return new Customer(
      customerid: int.parse(parsedJson['customerid']),
      customername: parsedJson['customername']
    );
  }

}

class POC{

  final int pocid, customerid;
  final pocname, pocphone, pocemail;

  POC({
    this.pocid,
    this.customerid,
    this.pocname,
    this.pocphone,
    this.pocemail
  });

  factory POC.fromJson(Map<String, dynamic> parsedJson){
    return new POC(
      pocid: int.parse(parsedJson['pocid']),
      customerid: int.parse(parsedJson['customerid']),
      pocname: parsedJson['pocname'],
      pocphone: parsedJson['pocphone'],
      pocemail: parsedJson['pocemail']
    );
  }

}