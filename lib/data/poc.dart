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

  Future<POC> fetch(int customerid, int pointofcontactid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    POC poc = new POC();

    http.Response getPOC;
    String custid, pocid, comp;

    try{
      comp = company.toString();
      custid = customerid.toString();
      pocid = pointofcontactid.toString();

      getPOC =
          await http.get(sci.serverreqaddress + '/pocs/$comp,$custid,$pocid');

      final jsonResponse = json.decode(getPOC.body.toString());
      poc = new POC.fromJson(jsonResponse[0]);

    }catch(e){
      print(e);
    }

    ParseResponse().parse(getPOC);

    return poc;

  }

  Future<void> create(String pocname, String pocemail, String pocphone, bool pocinactive, bool mainpoc, bool connectioncontact, bool mandatorycc, bool defaultoption, int customerid,
      [BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();

    http.Response postPOC;
    String s, inact, comp;

    try {
      comp = company.toString();
      s =
      '{"pocname":"$pocname", "pocemail":"$pocemail", "pocphonenum":"$pocphone", "inactive":"$pocinactive", "mainpoc":"$mainpoc", "connectioncontact":"$connectioncontact", "mandatorycc":"$mandatorycc", "defaultoption":"$defaultoption"}';

      postPOC = await http.post(sci.serverreqaddress + '/pocs/$comp,$customerid',
          headers: {'Content-type': 'application/json'}, body: s);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(postPOC, context);
  }

  Future<void> update(int customerid, int pocid, String pocname, String pocemail, String pocphone, int pocext, bool pocinactive, bool mainpoc, bool connectioncontact, bool mandatorycc, bool defaultoption, int rowrevnum, bool vchanged,
      [BuildContext context, bool noexit]) async {

    if(vchanged){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();
      final int company = await Session().getCompany();

      http.Response putPOC;
      String s;

      try {
        s = '{"pocname":"$pocname", "pocemail":"$pocemail", "pocphonenum":"$pocphone", "pocext":"$pocext", "inactive":"$pocinactive", "mainpoc":"$mainpoc", "connectioncontact":"$connectioncontact", "mandatorycc":"$mandatorycc", "defaultoption":"$defaultoption", "rowrevnum":"$rowrevnum"}';

        putPOC = await http.put(
            sci.serverreqaddress + '/pocs/$company,$customerid,$pocid',
            headers: {'Content-type': 'application/json'},
            body: s);
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(putPOC, context, noexit);
    }
  }

  Future<void> delete(int customerid, int pocid,
      [BuildContext context, bool noexit]) async {
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
      http.Response deletePOC;

      try {
        deletePOC =
        await http.delete(sci.serverreqaddress + '/pocs/$company,$customerid,$pocid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deletePOC, context, noexit);

    }else{
      return null;
    }
  }
}