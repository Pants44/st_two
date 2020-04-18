import 'package:st_two/data/imports.dart';
import 'package:http/http.dart' as http;

class StatusList {
  final List<Status> statuslist;

  StatusList({this.statuslist});

  factory StatusList.fromJson(List<dynamic> parsedJson) {
    List<Status> statuses = new List<Status>();
    statuses = parsedJson.map((i) => Status.fromJson(i)).toList();

    return new StatusList(statuslist: statuses);
  }

  Future<StatusList> fetch() async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    String comp = company.toString();

    http.Response getStatuses =
    await http.get(sci.serverreqaddress + "/statuses/$comp");
    final jsonResponse = json.decode(getStatuses.body.toString());
    StatusList statuslist = new StatusList.fromJson(jsonResponse);

    ParseResponse().parse(getStatuses);

    return statuslist;
  }
}

class Status {
  final String statusname;
  final int statusid, rowrevnum, company;
  final bool inactive, defaultoption;

  Status({
    this.statusid,
    this.statusname,
    this.inactive,
    this.defaultoption,
    this.rowrevnum,
    this.company,
  });

  factory Status.fromJson(Map<String, dynamic> parsedJson) {
    return Status(
      statusid: int.parse(parsedJson['statusid']),
      statusname: parsedJson['statusname'],
      inactive: parsedJson['inactive'] == 'true',
      defaultoption: parsedJson['defaultoption'] == 'true',
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }

  Future<Status> fetch(int statusid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    Status status = Status();

    http.Response getStatus;
    String staid, comp;

    try {
      comp = company.toString();
      staid = statusid.toString();

      getStatus =
      await http.get(sci.serverreqaddress + '/statuses/$comp,$staid');

      final jsonResponse = json.decode(getStatus.body.toString());
      status = new Status.fromJson(jsonResponse[0]);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(getStatus);

    return status;
  }

  Future<void> create(String statusname, bool inactive, bool defaultoption,
      [BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();

    http.Response postStatus;
    String jsonstr, inact, defop, comp;

    try {
      comp = company.toString();
      inact = inactive.toString();
      defop = defaultoption.toString();
      jsonstr =
      '{"statusname":"$statusname", "inactive":"$inact", "defaultoption":"$defop"}';
      postStatus = await http.post(sci.serverreqaddress + '/statuses/$comp',
          headers: {'Content-type': 'application/json'}, body: jsonstr);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(postStatus, context);
  }

  Future<void> update(int statusid, String statusname, bool inactive, bool defaultoption,
      int rowrevisionnum, bool vchanged,
      [BuildContext context]) async {

    if(vchanged){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();
      final int company = await Session().getCompany();

      http.Response putStatus;
      String staid, inact, defop, rowrevnum, comp, jsonstr;

      try {
        comp = company.toString();
        staid = statusid.toString();
        inact = inactive.toString();
        defop = defaultoption.toString();
        rowrevnum = rowrevisionnum.toString();
        jsonstr =
        '{"statusname":"$statusname", "inactive":"$inact", "defaultoption":"$defop", "rowrevnum":"$rowrevnum"}';

        putStatus = await http.put(
            sci.serverreqaddress + '/statuses/$comp,$staid',
            headers: {'Content-type': 'application/json'},
            body: jsonstr);
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(putStatus, context);
    }
  }

  Future<void> delete(int statusid,
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

      http.Response deleteStatus;
      String staid, comp;

      try {
        comp = company.toString();
        staid = statusid.toString();
        deleteStatus =
        await http.delete(sci.serverreqaddress + '/statuses/$comp,$staid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deleteStatus, context);

    }else{
      return null;
    }
  }
}