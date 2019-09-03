import 'package:st_two/size_config.dart';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomerconnections.dart';

bool ronly = false;

class ConnectionPage extends StatefulWidget {
  ConnectionPage({Key key, this.title, this.cc, this.readonly})
      : super(key: key);

  final String title;
  final CustomerConnection cc;
  final bool readonly;

  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  TextEditingController tecCustomerID = TextEditingController();
  TextEditingController tecCustomerName = TextEditingController();
  TextEditingController tecNotes = TextEditingController();
  TextEditingController tecVPNName = TextEditingController();
  TextEditingController tecVPNIP = TextEditingController();
  TextEditingController tecVPNServer = TextEditingController();
  TextEditingController tecVPNDownload = TextEditingController();
  TextEditingController tecVPNPSK = TextEditingController();
  TextEditingController tecVPNUser = TextEditingController();
  TextEditingController tecVPNPass = TextEditingController();
  TextEditingController tecConnectionType = TextEditingController();
  TextEditingController tecRDPLink = TextEditingController();
  TextEditingController tecRDPUser = TextEditingController();
  TextEditingController tecRDPPass = TextEditingController();
  TextEditingController tecMiscUser = TextEditingController();
  TextEditingController tecMiscPass = TextEditingController();
  TextEditingController tecWindowsUser = TextEditingController();
  TextEditingController tecWindowsPass = TextEditingController();
  TextEditingController tecDomain = TextEditingController();
  TextEditingController tecConnections = TextEditingController();
  TextEditingController tecERPSystem = TextEditingController();
  TextEditingController tecERPVersion = TextEditingController();
  TextEditingController tecSiteID = TextEditingController();
  TextEditingController tecDevEnv = TextEditingController();
  TextEditingController tecDBType = TextEditingController();
  TextEditingController tecERPUser = TextEditingController();
  TextEditingController tecERPPass = TextEditingController();
  TextEditingController tecCRPath = TextEditingController();
  TextEditingController tecSSRSReportServer = TextEditingController();
  TextEditingController tecMngStudioUser = TextEditingController();
  TextEditingController tecMngStudioPass = TextEditingController();
  TextEditingController tecSQLServer = TextEditingController();
  TextEditingController tecSQLUser = TextEditingController();
  TextEditingController tecSQLPass = TextEditingController();
  TextEditingController tecPEUser = TextEditingController();
  TextEditingController tecPEPass = TextEditingController();
  TextEditingController tecSPUser = TextEditingController();
  TextEditingController tecSPPass = TextEditingController();
  TextEditingController tecOpenEdgeUser = TextEditingController();
  TextEditingController tecOpenEdgePass = TextEditingController();
  TextEditingController tecAPMServer = TextEditingController();
  TextEditingController tecAPMUser = TextEditingController();
  TextEditingController tecAPMPass = TextEditingController();
  TextEditingController tecWDUser = TextEditingController();
  TextEditingController tecWDPass = TextEditingController();
  TextEditingController tecDLUser = TextEditingController();
  TextEditingController tecDLPass = TextEditingController();
  TextEditingController tecEpicWebUser = TextEditingController();
  TextEditingController tecEpicWebPass = TextEditingController();
  TextEditingController tecEpiCareUser = TextEditingController();
  TextEditingController tecEpiCarePass = TextEditingController();
  TextEditingController tecSCConsoleServer = TextEditingController();
  TextEditingController tecSCUser = TextEditingController();
  TextEditingController tecSCPass = TextEditingController();
  TextEditingController tecDSNConnString = TextEditingController();
  TextEditingController tecDSNServerAddress = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._loadData(widget.cc);
    ronly = widget.readonly;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tecCustomerID.dispose();
    tecCustomerName.dispose();
    tecNotes.dispose();
    tecVPNName.dispose();
    tecVPNIP.dispose();
    tecVPNServer.dispose();
    tecVPNDownload.dispose();
    tecVPNPSK.dispose();
    tecVPNUser.dispose();
    tecVPNPass.dispose();
    tecConnectionType.dispose();
    tecRDPLink.dispose();
    tecRDPUser.dispose();
    tecRDPPass.dispose();
    tecMiscUser.dispose();
    tecMiscPass.dispose();
    tecWindowsUser.dispose();
    tecWindowsPass.dispose();
    tecDomain.dispose();
    tecConnections.dispose();
    tecERPSystem.dispose();
    tecERPVersion.dispose();
    tecSiteID.dispose();
    tecDevEnv.dispose();
    tecDBType.dispose();
    tecERPUser.dispose();
    tecERPPass.dispose();
    tecCRPath.dispose();
    tecSSRSReportServer.dispose();
    tecMngStudioUser.dispose();
    tecMngStudioPass.dispose();
    tecSQLServer.dispose();
    tecSQLUser.dispose();
    tecSQLPass.dispose();
    tecPEUser.dispose();
    tecPEPass.dispose();
    tecSPUser.dispose();
    tecSPPass.dispose();
    tecOpenEdgeUser.dispose();
    tecOpenEdgePass.dispose();
    tecAPMServer.dispose();
    tecAPMUser.dispose();
    tecAPMPass.dispose();
    tecWDUser.dispose();
    tecWDPass.dispose();
    tecDLUser.dispose();
    tecDLPass.dispose();
    tecEpicWebUser.dispose();
    tecEpicWebPass.dispose();
    tecEpiCareUser.dispose();
    tecEpiCarePass.dispose();
    tecSCConsoleServer.dispose();
    tecSCUser.dispose();
    tecSCPass.dispose();
    tecDSNConnString.dispose();
    tecDSNServerAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: (){},),
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){},),
        ],
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.all(8),
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockVertical * 100,
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 5,
                child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'General',
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Customer',
                          ),
                          controller: tecCustomerName,
                          readOnly: ronly,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'ERP System',
                          ),
                          controller: tecERPSystem,
                          readOnly: ronly,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Version',
                          ),
                          controller: tecERPVersion,
                          readOnly: ronly,
                        ),
                        TextFormField(
                          minLines: null,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Notes',
                          ),
                          controller: tecNotes,
                          readOnly: ronly,
                        ),
                      ],
                    )),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'VPN',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        controller: tecVPNName,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'IP',
                        ),
                        controller: tecVPNIP,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Server',
                        ),
                        controller: tecVPNServer,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Download',
                        ),
                        controller: tecVPNDownload,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Pre Shared Key',
                        ),
                        controller: tecVPNPSK,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'VPN User',
                        ),
                        controller: tecVPNUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'VPN Pass',
                        ),
                        controller: tecVPNPass,
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Connection',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Connection Type',
                        ),
                        controller: tecConnectionType,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Link',
                        ),
                        controller: tecRDPLink,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Domain',
                        ),
                        controller: tecDomain,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Connections',
                        ),
                        controller: tecConnections,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'RDP User',
                        ),
                        controller: tecRDPUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'RDP Pass',
                        ),
                        controller: tecRDPPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Misc User',
                        ),
                        controller: tecMiscUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Misc Pass',
                        ),
                        controller: tecMiscPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Windows User',
                        ),
                        controller: tecWindowsUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Windows Pass',
                        ),
                        controller: tecWindowsPass,
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'ERP',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'System',
                        ),
                        controller: tecERPSystem,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Version',
                        ),
                        controller: tecERPVersion,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Site ID',
                        ),
                        controller: tecSiteID,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Dev Env',
                        ),
                        controller: tecDevEnv,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'DB Type',
                        ),
                        controller: tecDBType,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'User',
                        ),
                        controller: tecERPUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Pass',
                        ),
                        controller: tecERPPass,
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Reporting',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Crystal Reports Path',
                        ),
                        controller: tecCRPath,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'SSRS Report Path',
                        ),
                        controller: tecSSRSReportServer,
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SQL',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Mng Studio User',
                        ),
                        controller: tecMngStudioUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mng Studio Pass',
                        ),
                        controller: tecMngStudioPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'SQL Server',
                        ),
                        controller: tecSQLServer,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'User',
                        ),
                        controller: tecSQLUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Pass',
                        ),
                        controller: tecSQLPass,
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Misc',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Prog Explorer User',
                        ),
                        controller: tecPEUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Prog Explorer Pass',
                        ),
                        controller: tecPEPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Sys Progress User',
                        ),
                        controller: tecSPUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Sys Progress Pass',
                        ),
                        controller: tecSPPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'OpenEdge User',
                        ),
                        controller: tecOpenEdgeUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'OpenEdge Pass',
                        ),
                        controller: tecOpenEdgePass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'APM Server',
                        ),
                        controller: tecAPMServer,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'APM User',
                        ),
                        controller: tecAPMUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'APM Pass',
                        ),
                        controller: tecAPMPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Workflow Designer User',
                        ),
                        controller: tecWDUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Workflow Designer Pass',
                        ),
                        controller: tecWDPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Doc-Link User',
                        ),
                        controller: tecDLUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Doc-Link Pass',
                        ),
                        controller: tecDLPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Epic Web User',
                        ),
                        controller: tecEpicWebUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Epic Web Pass',
                        ),
                        controller: tecEpicWebPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'EpiCare User',
                        ),
                        controller: tecEpiCareUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'EpiCare Pass',
                        ),
                        controller: tecEpicWebPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Service Connect Console Server',
                        ),
                        controller: tecSCConsoleServer,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Service Connect User',
                        ),
                        controller: tecSCUser,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Service Connect Pass',
                        ),
                        controller: tecSCPass,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'DSN Connection String',
                        ),
                        controller: tecDSNConnString,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'DSN Server Addresses',
                        ),
                        controller: tecDSNServerAddress,
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.edit, color: Colors.white,),
      ),
    );
  }

  void _loadData(CustomerConnection cc) {
    print('void load data');
    tecCustomerID.text = cc.customerid.toString();
    tecCustomerName.text = cc.customername.toString();
    tecNotes.text = cc.notes.toString();
    tecVPNName.text = cc.vpnname.toString();
    tecVPNIP.text = cc.vpnip.toString();
    tecVPNServer.text = cc.vpnserver.toString();
    tecVPNDownload.text = cc.vpndownload.toString();
    tecVPNPSK.text = cc.vpnpsk.toString();
    tecVPNUser.text = cc.vpnuser.toString();
    tecVPNPass.text = cc.vpnpassword.toString();
    tecConnectionType.text = cc.connectiontype.toString();
    tecRDPLink.text = cc.rdplink.toString();
    tecRDPUser.text = cc.rdpuser.toString();
    tecMiscUser.text = cc.miscuser.toString();
    tecMiscPass.text = cc.miscpass.toString();
    tecWindowsUser.text = cc.windowsuser.toString();
    tecWindowsPass.text = cc.windowspass.toString();
    tecDomain.text = cc.domain.toString();
    tecConnections.text = cc.connections.toString();
    tecERPSystem.text = cc.erpsystem.toString();
    tecERPVersion.text = cc.erpversion.toString();
    tecSiteID.text = cc.siteid.toString();
    tecDevEnv.text = cc.devenv.toString();
    tecDBType.text = cc.dbtype.toString();
    tecERPUser.text = cc.erpuser.toString();
    tecERPPass.text = cc.erppass.toString();
    tecCRPath.text = cc.crpath.toString();
    tecSSRSReportServer.text = cc.ssrsreportserver.toString();
    tecMngStudioUser.text = cc.mngstudiouser.toString();
    tecMngStudioPass.text = cc.mngstudiopass.toString();
    tecSQLServer.text = cc.sqlserver.toString();
    tecSQLUser.text = cc.sqluser.toString();
    tecSQLPass.text = cc.sqlpass.toString();
    tecPEUser.text = cc.peuser.toString();
    tecPEPass.text = cc.pepass.toString();
    tecSPUser.text = cc.spuser.toString();
    tecSPPass.text = cc.sppass.toString();
    tecOpenEdgeUser.text = cc.openedgeuser.toString();
    tecOpenEdgePass.text = cc.openedgepass.toString();
    tecAPMServer.text = cc.apmserver.toString();
    tecAPMUser.text = cc.apmuser.toString();
    tecAPMPass.text = cc.apmpass.toString();
    tecWDUser.text = cc.wduser.toString();
    tecWDPass.text = cc.wdpass.toString();
    tecDLUser.text = cc.dluser.toString();
    tecDLPass.text = cc.dlpass.toString();
    tecEpicWebUser.text = cc.epicwebuser.toString();
    tecEpicWebPass.text = cc.epicwebpass.toString();
    tecEpiCareUser.text = cc.epicareuser.toString();
    tecEpiCarePass.text = cc.epicarepass.toString();
    tecSCConsoleServer.text = cc.scconsoleserver.toString();
    tecSCUser.text = cc.scuser.toString();
    tecSCPass.text = cc.scpass.toString();
    tecDSNConnString.text = cc.dsnconnstring.toString();
    tecDSNServerAddress.text = cc.dsnserveraddress.toString();
  }
}
