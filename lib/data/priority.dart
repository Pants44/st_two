import 'package:st_two/data/imports.dart';
import 'package:http/http.dart' as http;

class PriorityList {
  final List<Priority> priorities;

  PriorityList({this.priorities});

  factory PriorityList.fromJson(List<dynamic> parsedJson) {
    List<Priority> priorities = new List<Priority>();
    priorities = parsedJson.map((i) => Priority.fromJson(i)).toList();

    return new PriorityList(priorities: priorities);
  }

  Future<PriorityList> fetch() async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    String comp = company.toString();

    http.Response getPriorities =
    await http.get(sci.serverreqaddress + "/priorities/$comp");
    final jsonResponse = json.decode(getPriorities.body.toString());
    PriorityList prioritylist = new PriorityList.fromJson(jsonResponse);

    ParseResponse().parse(getPriorities);

    return prioritylist;
  }
}

class Priority {
  final String priorityname;
  final int priorityid, rowrevnum, company;
  final bool inactive, defaultoption;

  Priority({
    this.priorityid,
    this.priorityname,
    this.inactive,
    this.defaultoption,
    this.rowrevnum,
    this.company,
  });

  factory Priority.fromJson(Map<String, dynamic> parsedJson) {
    return Priority(
      priorityid: int.parse(parsedJson['priorityid']),
      priorityname: parsedJson['priorityname'],
      inactive: parsedJson['inactive'] == 'true',
      defaultoption: parsedJson['defaultoption'] == 'true',
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }

  Future<Priority> fetch(int priorityid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    Priority priority = Priority();

    http.Response getPriority;
    String priid, comp;

    try {
      comp = company.toString();
      priid = priorityid.toString();

      getPriority =
      await http.get(sci.serverreqaddress + '/priorities/$comp,$priid');

      final jsonResponse = json.decode(getPriority.body.toString());
      priority = new Priority.fromJson(jsonResponse[0]);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(getPriority);

    return priority;
  }

  Future<void> create(String priname, bool inactive, bool defaultoption,
      [BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();

    http.Response postPriority;
    String jsonstr, inact, defop, comp;

    try {
      comp = company.toString();
      inact = inactive.toString();
      defop = defaultoption.toString();
      jsonstr =
      '{"priorityname":"$priname", "inactive":"$inact", "defaultoption":"$defop"}';
      postPriority = await http.post(sci.serverreqaddress + '/priorities/$comp',
          headers: {'Content-type': 'application/json'}, body: jsonstr);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(postPriority, context);
  }

  Future<void> update(int priorityid, String priname, bool inactive, bool defaultoption,
      int rowrevisionnum, bool vchanged,
      [BuildContext context]) async {

    if(vchanged){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();
      final int company = await Session().getCompany();

      http.Response putPriority;
      String priid, inact, defop, rowrevnum, comp, jsonstr;

      try {
        comp = company.toString();
        priid = priorityid.toString();
        inact = inactive.toString();
        defop = defaultoption.toString();
        rowrevnum = rowrevisionnum.toString();
        jsonstr =
        '{"priorityname":"$priname", "inactive":"$inact", "defaultoption":"$defop", "rowrevnum":"$rowrevnum"}';

        putPriority = await http.put(
            sci.serverreqaddress + '/priorities/$comp,$priid',
            headers: {'Content-type': 'application/json'},
            body: jsonstr);
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(putPriority, context);
    }
  }

  Future<void> delete(int priorityid,
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
      http.Response deletePriority;
      String priid, comp;

      try {
        comp = company.toString();
        priid = priorityid.toString();
        deletePriority =
        await http.delete(sci.serverreqaddress + '/priorities/$comp,$priid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deletePriority, context);

    }else{
      return null;
    }
  }
}