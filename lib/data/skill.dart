import 'package:st_two/data/imports.dart';
import 'package:http/http.dart' as http;

class SkillList {
  final List<Skill> skills;

  SkillList({this.skills});

  factory SkillList.fromJson(List<dynamic> parsedJson) {
    List<Skill> skills = new List<Skill>();
    skills = parsedJson.map((i) => Skill.fromJson(i)).toList();

    return new SkillList(skills: skills);
  }

  Future<SkillList> fetch(int company) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    String comp = company.toString();

    http.Response getSkills =
    await http.get(sci.serverreqaddress + "/skills/$comp");
    final jsonResponse = json.decode(getSkills.body.toString());
    SkillList skilllist = new SkillList.fromJson(jsonResponse);

    ParseResponse().parse(getSkills);

    return skilllist;
  }
}

class Skill {
  final String skillname, description;
  final int skillid, rowrevnum, company;
  final bool inactive;

  Skill({
    this.skillid,
    this.skillname,
    this.description,
    this.inactive,
    this.rowrevnum,
    this.company,
  });

  factory Skill.fromJson(Map<String, dynamic> parsedJson) {
    return Skill(
      skillid: int.parse(parsedJson['skillid']),
      skillname: parsedJson['skillname'],
      description: parsedJson['description'],
      inactive: parsedJson['inactive'] == 'true',
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }

  Future<Skill> fetch(int company, int skillid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    Skill skill = Skill();

    http.Response getSkill;
    String skiid, comp;

    try {
      comp = company.toString();
      skiid = skillid.toString();

      getSkill =
      await http.get(sci.serverreqaddress + '/skills/$comp,$skiid');

      final jsonResponse = json.decode(getSkill.body.toString());
      skill = new Skill.fromJson(jsonResponse[0]);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(getSkill);

    return skill;
  }

  Future<void> create(int company, String skillname, String description, bool inactive,
      [BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();

    http.Response postSkill;
    String jsonstr,inact, comp;

    try {
      comp = company.toString();
      inact = inactive.toString();
      jsonstr =
      '{"skillname":"$skillname","description":"$description", "inactive":"$inact"}';
      postSkill = await http.post(sci.serverreqaddress + '/skills/$comp',
          headers: {'Content-type': 'application/json'}, body: jsonstr);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(postSkill, context);
  }

  Future<void> update(int company, int skillid, String skillname, String description, bool inactive,
      int rowrevisionnum, bool vchanged,
      [BuildContext context]) async {

    if(vchanged){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();

      http.Response putSkill;
      String skiid, inact, rowrevnum, comp, jsonstr;

      try {
        comp = company.toString();
        skiid = skillid.toString();
        inact = inactive.toString();
        rowrevnum = rowrevisionnum.toString();
        jsonstr =
        '{"skillname":"$skillname","description":"$description", "inactive":"$inact", "rowrevnum":"$rowrevnum"}';

        putSkill = await http.put(
            sci.serverreqaddress + '/skills/$comp,$skiid',
            headers: {'Content-type': 'application/json'},
            body: jsonstr);
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(putSkill, context);
    }
  }

  Future<void> delete(int company, int skillid,
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

      http.Response deleteSkill;
      String skiid, comp;

      try {
        comp = company.toString();
        skiid = skillid.toString();
        deleteSkill =
        await http.delete(sci.serverreqaddress + '/skills/$comp,$skiid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deleteSkill, context);

    }else{
      return null;
    }


  }
}