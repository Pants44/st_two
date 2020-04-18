import 'package:st_two/data/imports.dart';
import 'package:http/http.dart' as http;

class IndustryList {
  final List<Industry> industries;

  IndustryList({this.industries});

  factory IndustryList.fromJson(List<dynamic> parsedJson) {
    List<Industry> industries = new List<Industry>();
    industries = parsedJson.map((i) => Industry.fromJson(i)).toList();

    return new IndustryList(industries: industries);
  }

  Future<IndustryList> fetch() async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    String comp = company.toString();

    http.Response getIndustries =
    await http.get(sci.serverreqaddress + "/industries/$comp");
    final jsonResponse = json.decode(getIndustries.body.toString());
    IndustryList industrylist = new IndustryList.fromJson(jsonResponse);

    ParseResponse().parse(getIndustries);

    return industrylist;
  }
}

class Industry {
  final String industryname;
  final int industryid, rowrevnum, company;
  final bool inactive, defaultoption;

  Industry({
    this.industryid,
    this.industryname,
    this.inactive,
    this.defaultoption,
    this.rowrevnum,
    this.company,
  });

  factory Industry.fromJson(Map<String, dynamic> parsedJson) {
    return Industry(
      industryid: int.parse(parsedJson['industryid']),
      industryname: parsedJson['industryname'],
      inactive: parsedJson['inactive'] == 'true',
      defaultoption: parsedJson['defaultoption'] == 'true',
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }

  Future<Industry> fetch(int industryid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    int company = await Session().getCompany();
    Industry industry = Industry();

    http.Response getIndustry;
    String indid, comp;

    try {
      comp = company.toString();
      indid = industryid.toString();

      getIndustry =
      await http.get(sci.serverreqaddress + '/industries/$comp,$indid');

      final jsonResponse = json.decode(getIndustry.body.toString());
      industry = new Industry.fromJson(jsonResponse[0]);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(getIndustry);

    return industry;
  }

  Future<void> create(String indname, bool inactive, bool defaultoption,
      [BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    int company = await Session().getCompany();

    http.Response postIndustry;
    String jsonstr, inact, defop, comp;

    try {
      comp = company.toString();
      inact = inactive.toString();
      defop = defaultoption.toString();
      jsonstr =
      '{"industryname":"$indname", "inactive":"$inact", "defaultoption":"$defop"}';
      postIndustry = await http.post(sci.serverreqaddress + '/industries/$comp',
          headers: {'Content-type': 'application/json'}, body: jsonstr);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(postIndustry, context);
  }

  Future<void> update(int industryid, String indname, bool inactive, bool defaultoption,
      int rowrevisionnum, bool vchanged,
      [BuildContext context]) async {

    if(vchanged){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();
      int company = await Session().getCompany();

      http.Response putIndustry;
      String indid, inact, defop, rowrevnum, comp, jsonstr;

      try {
        comp = company.toString();
        indid = industryid.toString();
        inact = inactive.toString();
        defop = defaultoption.toString();
        rowrevnum = rowrevisionnum.toString();
        jsonstr =
        '{"industryname":"$indname", "inactive":"$inact", "defaultoption":"$defop", "rowrevnum":"$rowrevnum"}';

        putIndustry = await http.put(
            sci.serverreqaddress + '/industries/$comp,$indid',
            headers: {'Content-type': 'application/json'},
            body: jsonstr);
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(putIndustry, context);
    }
  }

  Future<void> delete(int industryid,
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
      int company = await Session().getCompany();

      http.Response deleteIndustry;
      String indid, comp;

      try {
        comp = company.toString();
        indid = industryid.toString();
        deleteIndustry =
        await http.delete(sci.serverreqaddress + '/industries/$comp,$indid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deleteIndustry, context);

    }else{
      return null;
    }
  }
}