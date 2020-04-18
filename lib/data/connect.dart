import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sPrefs = SharedPreferences.getInstance();

class ServerConnectionInfo
{
  String serverip, serverport, serverreqaddress;

  ServerConnectionInfo({this.serverip, this.serverport, this.serverreqaddress});

  Future getServerInfo() async{
    final SharedPreferences prefs = await _sPrefs;
    serverip = prefs.get('serverip') ?? '192.168.5.247';
    serverport = prefs.get('serverport') ?? '8888';
    serverreqaddress = 'http://$serverip:$serverport';
  }

  Future setServerInfo(String ip, String port) async{
    final SharedPreferences prefs = await _sPrefs;
    prefs.setString('serverip', ip);
    prefs.setString('serverport', port);
    serverip = ip.trim();
    serverport = port.trim();
    serverreqaddress = 'http://$serverip:$serverport';
  }

}

class Session
{
  int company;

  Session({this.company});

  Future<int> getCompany() async {
    final SharedPreferences prefs = await _sPrefs;
    company = prefs.getInt('company') ?? 0;
    return company;
  }

  Future setCurCompany(int comp) async {
    final SharedPreferences prefs = await _sPrefs;
    prefs.setInt('company', comp);
  }
}
