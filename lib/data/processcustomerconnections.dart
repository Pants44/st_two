class ConnectionList{
  final List<CustomerConnection> ccon;

  ConnectionList({
    this.ccon,
  });

  factory ConnectionList.fromJson(List<dynamic> parsedJson){
    List<CustomerConnection> ccon = new List<CustomerConnection>();
    ccon = parsedJson.map((i)=>CustomerConnection.fromJson(i)).toList();

    return new ConnectionList(
      ccon: ccon
    );
  }
}

class CustomerConnection {
  final String customerid, customername, notes, vpnname, vpnip, vpnserver,
      vpndownload, vpnpsk, vpnuser, vpnpassword, connectiontype, rdplink,
      rdpuser, rdppass, domain, connections, erpsystem, version, siteid, devenv,
      dbtype, erpuser, erppass, crpath, ssrsreportserver, mngstudiouser,
      mngstudiopass, sqlserver, sqluser, sqlpass, peuser, pepass, spuser,
      sppass, openedgeuser, openedgepass, apmserver, apmuser, apmpass, wduser,
      wdpass, dluser, dlpass, epicwebuser, epicwebpass, epicareuser,
      epicarepass, scconsoleserver, scuser, scpass, dsnconnstring,
      dsnserveraddress;

  CustomerConnection({
    this.customerid,
    this.customername,
    this.notes,
    this.vpnname,
    this.vpnip,
    this.vpnserver,
    this.vpndownload,
    this.vpnpsk,
    this.vpnuser,
    this.vpnpassword,
    this.connectiontype,
    this.rdplink,
    this.rdpuser,
    this.rdppass,
    this.domain,
    this.connections,
    this.erpsystem,
    this.version,
    this.siteid,
    this.devenv,
    this.dbtype,
    this.erpuser,
    this.erppass,
    this.crpath,
    this.ssrsreportserver,
    this.mngstudiouser,
    this.mngstudiopass,
    this.sqlserver,
    this.sqluser,
    this.sqlpass,
    this.peuser,
    this.pepass,
    this.spuser,
    this.sppass,
    this.openedgeuser,
    this.openedgepass,
    this.apmserver,
    this.apmuser,
    this.apmpass,
    this.wduser,
    this.wdpass,
    this.dluser,
    this.dlpass,
    this.epicwebuser,
    this.epicwebpass,
    this.epicareuser,
    this.epicarepass,
    this.scconsoleserver,
    this.scuser,
    this.scpass,
    this.dsnconnstring,
    this.dsnserveraddress,
  });

  factory CustomerConnection.fromJson(Map<String, dynamic> parsedJson){

    return CustomerConnection(
      customerid: parsedJson['customerid'],
      customername: parsedJson['customername'],
      notes: parsedJson['notes'],
      vpnname: parsedJson['vpnname'],
      vpnip: parsedJson['vpnip'],
      vpnserver: parsedJson['vpnserver'],
      vpndownload: parsedJson['vpndownload'],
      vpnpsk: parsedJson['vpnpsk'],
      vpnuser: parsedJson['vpnuser'],
      vpnpassword: parsedJson['vpnpassword'],
      connectiontype: parsedJson['connectiontype'],
      rdplink: parsedJson['rdplink'],
      rdpuser: parsedJson['rdpuser'],
      rdppass: parsedJson['rdppass'],
      domain: parsedJson['domain'],
      connections: parsedJson['connections'],
      erpsystem: parsedJson['erpsystem'],
      version: parsedJson['version'],
      siteid: parsedJson['siteid'],
      devenv: parsedJson['devenv'],
      dbtype: parsedJson['dbtype'],
      erpuser: parsedJson['erpuser'],
      erppass: parsedJson['erppass'],
      crpath: parsedJson['crpath'],
      ssrsreportserver: parsedJson['ssrsreportserver'],
      mngstudiouser: parsedJson['mngstuiouser'],
      mngstudiopass: parsedJson['ngdstudiopass'],
      sqlserver: parsedJson['sqlserver'],
      sqluser: parsedJson['sqluser'],
      sqlpass: parsedJson['sqlpass'],
      peuser: parsedJson['peuser'],
      pepass: parsedJson['pepass'],
      spuser: parsedJson['spuser'],
      sppass: parsedJson['sppass'],
      openedgeuser: parsedJson['openedgeuser'],
      openedgepass: parsedJson['openedgepass'],
      apmserver: parsedJson['apmserver'],
      apmuser: parsedJson['apmuser'],
      apmpass: parsedJson['apmpass'],
      wduser: parsedJson['wduser'],
      wdpass: parsedJson['wdpass'],
      dluser: parsedJson['dluser'],
      dlpass: parsedJson['dlpass'],
      epicwebuser: parsedJson['epicwebuser'],
      epicwebpass: parsedJson['epicwebpass'],
      epicareuser: parsedJson['epicareuser'],
      epicarepass: parsedJson['epicaerpass'],
      scconsoleserver: parsedJson['scconsoleserver'],
      scuser: parsedJson['scsuer'],
      scpass: parsedJson['scpass'],
      dsnconnstring: parsedJson['dsnconnstring'],
      dsnserveraddress: parsedJson['dsnserveraddress'],
    );
  }
}