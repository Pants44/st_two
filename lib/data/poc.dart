import 'package:st_two/data/imports.dart';
import 'package:http/http.dart' as http;

class POCList{
  final List<POC> pocs;

  POCList({
    this.pocs
  });

  factory POCList.fromJson(List<dynamic> parsedJson){
    List<POC> pocs = new List<POC>();
    pocs = parsedJson.map((i)=>POC.fromJson(i)).toList();

    return new POCList(
      pocs: pocs
    );
  }

  Future<POCList> fetch(int customerid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    POCList poclist = POCList();

    http.Response getPOCS;
    String custid, comp;

    try{
      comp = company.toString();
      custid = customerid.toString();
      print('partner'+custid);

      getPOCS =
      await http.get(sci.serverreqaddress + '/pocs/$comp,$custid');

      final jsonResponse = json.decode(getPOCS.body.toString());
      poclist = new POCList.fromJson(jsonResponse);

    }catch(e){
      print(e);
    }

    ParseResponse().parse(getPOCS);

    return poclist;

  }

}

class POC{
  final String pocname, pocemail, pocphone, pocext;
  final int pocid, customerid, rowrevnum, company;
  final bool inactive, mainpoc, connectioncontact, mandatorycc, defaultoption;

  POC({
    this.pocid,
    this.pocname,
    this.pocemail,
    this.pocphone,
    this.pocext,
    this.inactive,
    this.mainpoc,
    this.connectioncontact,
    this.mandatorycc,
    this.defaultoption,
    this.rowrevnum,
    this.customerid,
    this.company,
  });

  factory POC.fromJson(Map<String, dynamic> parsedJson){
    return POC(
      pocid: int.parse(parsedJson['pocid']),
      pocname: parsedJson['pocname'],
      pocemail: parsedJson['pocemail'],
      pocphone: parsedJson['pocphonenum'],
      pocext: parsedJson['pocext'],
      inactive: parsedJson['inactive'] == 'true',
      mainpoc: parsedJson['mainpoc'] == 'true',
      connectioncontact: parsedJson['connectioncontact'] == 'true',
      mandatorycc: parsedJson['mandatorycc'] == 'true',
      defaultoption: parsedJson['defaultoption'] == 'true',
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      customerid: int.parse(parsedJson['customerid']),
      company: int.parse(parsedJson['company']),
    );
  }
}