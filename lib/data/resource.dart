import 'package:st_two/data/imports.dart';
import 'package:http/http.dart' as http;

class ResourceList {
  final List<Resource> resources;

  ResourceList({this.resources});

  factory ResourceList.fromJson(List<dynamic> parsedJson) {
    List<Resource> resources = new List<Resource>();
    resources = parsedJson.map((i) => Resource.fromJson(i)).toList();

    return new ResourceList(resources: resources);
  }

  Future<ResourceList> fetch() async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();
    String comp = company.toString();

    http.Response getResources =
    await http.get(sci.serverreqaddress + "/resources/$comp");
    final jsonResponse = json.decode(getResources.body.toString());
    ResourceList resourcelist = new ResourceList.fromJson(jsonResponse);

    ParseResponse().parse(getResources);

    return resourcelist;
  }
}

class Resource {
  final String resourcename, email, phoneext;
  final int resourceid, rowrevnum, company;
  final bool inactive, defaultoption;

  Resource({
    this.resourceid,
    this.resourcename,
    this.inactive,
    this.defaultoption,
    this.email,
    this.phoneext,
    this.rowrevnum,
    this.company,
  });

  factory Resource.fromJson(Map<String, dynamic> parsedJson) {
    return Resource(
      resourceid: int.parse(parsedJson['resourceid']),
      resourcename: parsedJson['resourcename'],
      inactive: parsedJson['inactive'] == 'true',
      defaultoption: parsedJson['defaultoption'] == 'true',
      email: parsedJson['email'],
      phoneext: parsedJson['phoneext'],
      rowrevnum: int.parse(parsedJson['rowrevnum']),
      company: int.parse(parsedJson['company']),
    );
  }

  Future<Resource> fetch(int resourceid) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    Resource resource = Resource();
    final int company = await Session().getCompany();

    http.Response getResource;
    String resid, comp;

    try {
      comp = company.toString();
      resid = resourceid.toString();

      getResource =
      await http.get(sci.serverreqaddress + '/resources/$comp,$resid');

      final jsonResponse = json.decode(getResource.body.toString());
      resource = new Resource.fromJson(jsonResponse[0]);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(getResource);

    return resource;
  }

  Future<void> create(String resname, bool inactive, bool defaultoption, String email, String phoneext,
      [BuildContext context]) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();
    final int company = await Session().getCompany();

    http.Response postResource;
    String jsonstr, inact, defop, comp;

    try {
      comp = company.toString();
      inact = inactive.toString();
      defop = defaultoption.toString();
      jsonstr =
      '{"resourcename":"$resname", "inactive":"$inact", "defaultoption":"$defop", "email":"$email", "phoneexy":"$phoneext"}';
      postResource = await http.post(sci.serverreqaddress + '/resources/$comp',
          headers: {'Content-type': 'application/json'}, body: jsonstr);
    } catch (e) {
      print(e);
    }

    ParseResponse().parse(postResource, context);
  }

  Future<void> update(int resourceid, String resname, bool inactive, bool defaultoption, String email, String phoneext,
      int rowrevisionnum, bool vchanged,
      [BuildContext context]) async {

    if(vchanged){
      final sci = new ServerConnectionInfo();
      await sci.getServerInfo();
      final int company = await Session().getCompany();

      http.Response putResource;
      String resid, inact, defop, rowrevnum, comp, jsonstr;

      try {
        comp = company.toString();
        resid = resourceid.toString();
        inact = inactive.toString();
        defop = defaultoption.toString();
        rowrevnum = rowrevisionnum.toString();
        jsonstr =
        '{"resourcename":"$resname", "inactive":"$inact", "defaultoption":"$defop", "email":"$email", "phoneext":"$phoneext", "rowrevnum":"$rowrevnum"}';

        putResource = await http.put(
            sci.serverreqaddress + '/resources/$comp,$resid',
            headers: {'Content-type': 'application/json'},
            body: jsonstr);
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(putResource, context);
    }
  }

  Future<void> delete(int resourceid,
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

      http.Response deleteResource;
      String resid, comp;

      try {
        comp = company.toString();
        resid = resourceid.toString();
        deleteResource =
        await http.delete(sci.serverreqaddress + '/resources/$comp,$resid');
      } catch (e) {
        print(e);
      }

      ParseResponse().parse(deleteResource, context);

    }else{
      return null;
    }


  }
}