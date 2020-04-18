import 'package:st_two/data/imports.dart';
import 'package:http/http.dart' as http;

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

  Future<DiscoveryMethodList> fetch() async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    String comp = company.toString();

    http.Response getDiscMethods =
    await http.get(sci.serverreqaddress + "/discoverymethods/$comp");
    final jsonResponse = json.decode(getDiscMethods.body.toString());
    DiscoveryMethodList discmethodlist = new DiscoveryMethodList.fromJson(jsonResponse);

    ParseResponse().parse(getDiscMethods);

    return discmethodlist;
  }
}

class DiscoveryMethod {
  final String discoverymethod;
  final int dmid, rowrevnum, company;
  final bool inactive, defaultoption;

  DiscoveryMethod(
      {this.dmid,
        this.discoverymethod,
        this.inactive,
        this.defaultoption,
        this.rowrevnum,
        this.company});

  factory DiscoveryMethod.fromJson(Map<String, dynamic> parsedJson) {
    return DiscoveryMethod(
        dmid: int.parse(parsedJson['dmid']),
        discoverymethod: parsedJson['discoverymethod'],
        inactive: parsedJson['inactive'] == 'true',
        defaultoption: parsedJson['defaultoption'] == 'true',
        rowrevnum: int.parse(parsedJson['rowrevnum']),
        company: int.parse(parsedJson['company']));
  }

  Future<DiscoveryMethod> fetch(int discmethodid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    DiscoveryMethod discoverymethod = DiscoveryMethod();

    http.Response getDiscMethod;
    String dmid, comp;

    try {
      comp = company.toString();
      dmid = discmethodid.toString();

      getDiscMethod =
      await http.get(sci.serverreqaddress + '/discoverymethods/$comp,$dmid');

      final jsonResponse = json.decode(getDiscMethod.body.toString());
      discoverymethod = new DiscoveryMethod.fromJson(jsonResponse[0]);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(getDiscMethod);

    return discoverymethod;
  }

  Future<void> create(String dmname, bool inactive, bool defaultoption,
      [BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();

    http.Response postDiscMethod;
    String jsonstr, inact, defop, comp;

    try {
      comp = company.toString();
      inact = inactive.toString();
      defop = defaultoption.toString();
      jsonstr =
      '{"discoverymethod":"$dmname", "inactive":"$inact", "defaultoption":"$defop"}';
      postDiscMethod = await http.post(sci.serverreqaddress + '/discoverymethods/$comp',
          headers: {'Content-type': 'application/json'}, body: jsonstr);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(postDiscMethod, context);
  }

  Future<void> update(int discmethodid, String dmname, bool inactive, bool defaultoption,
      int rowrevisionnum, bool vchanged,
      [BuildContext context]) async {

    if(vchanged){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();
      final int company = await Session().getCompany();

      http.Response putDiscMethod;
      String dmid, inact, defop, rowrevnum, comp, jsonstr;

      try {
        comp = company.toString();
        dmid = discmethodid.toString();
        inact = inactive.toString();
        defop = defaultoption.toString();
        rowrevnum = rowrevisionnum.toString();
        jsonstr =
        '{"discoverymethod":"$dmname", "inactive":"$inact", "defaultoption":"$defop", "rowrevnum":"$rowrevnum"}';

        putDiscMethod = await http.put(
            sci.serverreqaddress + '/discoverymethods/$comp,$dmid',
            headers: {'Content-type': 'application/json'},
            body: jsonstr);
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(putDiscMethod, context);
    }
  }

  Future<void> delete(int discmethodid,
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
      final company = await Session().getCompany();

      http.Response deleteDiscMethod;
      String comp, dmid;

      try {
        comp = company.toString();
        dmid = discmethodid.toString();
        deleteDiscMethod =
        await http.delete(sci.serverreqaddress + '/discoverymethods/$comp,$dmid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deleteDiscMethod, context);

    }else{
      return null;
    }


  }
}