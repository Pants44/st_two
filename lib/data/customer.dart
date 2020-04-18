import 'dart:collection';

import 'package:st_two/data/imports.dart';
import 'package:st_two/data/processdropdowns.dart';
import 'package:http/http.dart' as http;

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

  Future<CustomerList> fetch() async {
    final sci = ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    String comp = company.toString();

    var jsonString = await http.get(sci.serverreqaddress + '/customers/$comp');
    final jsonResponse = json.decode(jsonString.body.toString());
    CustomerList customerlist = new CustomerList.fromJson(jsonResponse);

    // TODO Complicated because you chose a weird way to look at a bunch of booleans

    /*if(statusfilter != null){
      customerlist.customers.removeWhere((item) => item.erpversion != versionfilter);
    }*/

    print('Customers list loaded for Customer List Screen');
    return customerlist;
  }

}

class Customer {
  final String customername, mainpocname, mainpocemail, industryname, portallogin, portalpassword, sidescription, dmdescription, referredby, enteredby, entereddate;
  final int customerid, industryid, discoverymethodid, referredbyid, rowrevnum, company;
  final bool inactive, specialinstructions, engagementreceived, quotesrequired, connectionsetup, onhold, blacklisted, autoemail, monthlysupport;

  Customer({
    this.customerid,
    this.mainpocname,
    this.mainpocemail,
    this.industryid,
    this.industryname,
    this.discoverymethodid,
    this.dmdescription,
    this.referredbyid,
    this.referredby,
    this.customername,
    this.portallogin,
    this.portalpassword,
    this.sidescription,
    this.specialinstructions,
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

    return Customer(
      customerid: int.parse(parsedJson['customerid']),
      mainpocname: parsedJson['mainpocname'],
      mainpocemail: parsedJson['mainpocemail'],
      industryid: int.parse(parsedJson['industryid']),
      industryname: parsedJson['industryname'],
      referredbyid: int.tryParse(parsedJson['referredbyid']),
      referredby: parsedJson['referredby'],
      customername: parsedJson['customername'],
      portallogin: parsedJson['portallogin'],
      portalpassword: parsedJson['portalpassword'],
      specialinstructions: parsedJson['specialinstructions'] == 'true',
      sidescription: parsedJson['sidescription'],
      discoverymethodid: int.tryParse(parsedJson['dmid']),
      dmdescription: parsedJson['dmdescription'],
      inactive: parsedJson['inactive'] == 'true',
      engagementreceived: parsedJson['engagementreceived'] == 'true',
      quotesrequired: parsedJson['quotesrequired'] == 'true',
      connectionsetup: parsedJson['connectionsetup'] == 'true',
      onhold: parsedJson['onhold'] == 'true',
      blacklisted: parsedJson['blacklisted'] == 'true',
      autoemail: parsedJson['autoemail'] == 'true',
      monthlysupport: parsedJson['monthlysupport'] == 'true',
      enteredby: parsedJson['enteredby'],
      entereddate: parsedJson['entereddate'],
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }

  Future<Customer> fetch(int customerid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    Customer customer = Customer();

    http.Response getCustomer;
    String custid, comp;

    try {
      comp = company.toString();
      custid = customerid.toString();

      getCustomer =
      await http.get(sci.serverreqaddress + '/customers/$comp,$custid');

      final jsonResponse = json.decode(getCustomer.body.toString());
      customer = new Customer.fromJson(jsonResponse[0]);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(getCustomer);

    return customer;
  }

  Future<void> create(String custname, bool inactive, bool engagementreceived, bool quotesrequired, bool connectionsetup, bool onhold, bool blacklisted, bool autoemail, bool monthlysupport, bool specialinstructions, String enteredby, int industryid,
      [int dmid, String sidescription = "", String portallogin = "", String portalpass = "", int referredbyid, BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();

    http.Response postCustomer;
    String s, inact, comp;

    try {
      comp = company.toString();
      inact = inactive.toString();
      s =
      '{"customername":"$custname", "inactive":"$inact", "engagementreceived":"$engagementreceived", "quotesrequired":"$quotesrequired", "connectionsetup":"$connectionsetup", "onhold":"$onhold", "blacklisted":"$blacklisted", "autoemail":"$autoemail", "monthlysupport":"$monthlysupport", "specialinstructions":"$specialinstructions", "enteredby":"$enteredby", "industryid":"$industryid", ';
      if(dmid != null){
        s = s + '"dmid":"$dmid", ';
      }
      if(sidescription != null){
        s = s + '"sidescription":"$sidescription", ';
      }
      if(portallogin != null){
        s = s + '"portallogin":"$portallogin", ';
      }
      if(portalpass != null){
        s = s + '"portalpass":"$portalpass", ';
      }
      if(referredbyid != null){
        s = s + '"referredbyid":"$referredbyid", ';
      }
      if(s.endsWith(', ')){
        s = s.substring(0, s.length-2);
      }
      s = s + '}';
      print(s);
      /*if(dmid != null && sidescription != null && portallogin != null && portalpass != null && referredbyid != null){
        s = s + '}';
      }else{

      }*/

      postCustomer = await http.post(sci.serverreqaddress + '/customers/$comp',
          headers: {'Content-type': 'application/json'}, body: s);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(postCustomer, context);
  }

  Future<LinkedHashMap<int, List<DropdownMenuItem<String>>>> prep(List<DropdownMenuItem<String>> inddd, List<DropdownMenuItem<String>> dmdd, List<DropdownMenuItem<String>> refdd, [String indsel, String dmsel, String rfsel, String pocsel]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    int comp = await Session().getCompany();

    if(inddd==null){
      inddd = List<DropdownMenuItem<String>>();
    }
    if(dmdd==null){
      dmdd = List<DropdownMenuItem<String>>();
    }
    if(refdd==null){
      refdd = List<DropdownMenuItem<String>>();
    }

    LinkedHashMap mymap = LinkedHashMap<int, List<DropdownMenuItem<String>>>();
    //mymap.clear();
    if (inddd.length < 1) {
      //inddd = [];
      var jsonString = await http.get(sci.serverreqaddress + '/industrydrop/$comp');
      final jsonResponse = json.decode(jsonString.body.toString());
      DDList dd = new DDList.fromJson(jsonResponse);

      for (var i = 0; i < dd.list.length; i++) {
        inddd.add(
          DropdownMenuItem(
            value: dd.list[i].id,
            child: Text(dd.list[i].selection.toString()),
          ),
        );
      }
      mymap.putIfAbsent(1, ()=>inddd);
    }
    print(inddd.length);

    if (dmdd.length < 1) {
      dmdd = [];
      var jsonString = await http.get(sci.serverreqaddress + '/discoverymethoddrop/$comp');
      final jsonResponse = json.decode(jsonString.body.toString());
      DDList dd = new DDList.fromJson(jsonResponse);

      for (var i = 0; i < dd.list.length; i++) {
        dmdd.add(
          DropdownMenuItem(
            value: dd.list[i].id,
            child: Text(dd.list[i].selection.toString()),
          ),
        );
      }
      mymap.putIfAbsent(2, ()=>dmdd);
    }
    print(dmdd.length);

    if (refdd.length < 1) {
      refdd = [];
      var jsonString = await http.get(sci.serverreqaddress + '/referredbydrop/$comp');
      final jsonResponse = json.decode(jsonString.body.toString());
      DDList dd = new DDList.fromJson(jsonResponse);

      for (var i = 0; i < dd.list.length; i++) {
        refdd.add(
          DropdownMenuItem(
            value: dd.list[i].id,
            child: Text(dd.list[i].selection.toString()),
          ),
        );
      }
      mymap.putIfAbsent(3, ()=>refdd);
    }
    print(refdd.length);

    return mymap;
  }

  Future<void> update(int customerid, String custname, bool inactive, bool engagementreceived, bool quotesrequired, bool connectionsetup, bool onhold, bool blacklisted, bool autoemail, bool monthlysupport, bool specialinstructions, String enteredby, int industryid, int rowrevisionnum, bool vchanged,
      [int dmid, String sidescription = "", String portallogin = "", String portalpass = "", int referredbyid, BuildContext context]) async {

    if(vchanged){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();
      final int company = await Session().getCompany();

      http.Response putCustomer;
      String s;

      try {
        s = '{"customername":"$custname", "inactive":"$inactive", "engagmentreceived":"$engagementreceived", "quotesrequired":"$quotesrequired", "connectionsetup":"$connectionsetup", "onhold":"$onhold", "blacklisted":"$blacklisted", "autoemail":"$autoemail", "monthlysupport":"$monthlysupport", "specialinstructions":"$specialinstructions", "enteredby":"$enteredby", "industryid":"$industryid", "rowrevnum":"$rowrevisionnum", ';

        if(dmid != null){
          s = s + '"dmid":"$dmid", ';
        }
        if(sidescription.isNotEmpty){
          s = s + '"sidescription":"$sidescription", ';
        }
        if(portallogin.isNotEmpty){
          s = s + '"portallogin":"$portallogin", ';
        }
        if(portalpass.isNotEmpty){
          s = s + '"portalpass":"$portalpass", ';
        }
        if(referredbyid != null){
          s = s + '"referredbyid":"$referredbyid", ';
        }
        if(s.endsWith(', ')){
          s = s.substring(0, s.length-2);
        }
        s = s + '}';
        print(s);

        putCustomer = await http.put(
            sci.serverreqaddress + '/customers/$company,$customerid',
            headers: {'Content-type': 'application/json'},
            body: s);
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(putCustomer, context);
    }
  }

  Future<void> delete(int customerid,
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
      String custid, comp;

      try {
        comp = company.toString();
        custid = customerid.toString();
        deleteCustomer =
        await http.delete(sci.serverreqaddress + '/customers/$comp,$custid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deleteCustomer, context);

    }else{
      return null;
    }
  }

}