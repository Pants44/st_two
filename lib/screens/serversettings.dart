import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_two/data/connect.dart';

class ServerSettingsPage extends StatefulWidget {
  ServerSettingsPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _ServerSettingsPageState createState() => _ServerSettingsPageState();
}

class _ServerSettingsPageState extends State<ServerSettingsPage> {
  TextEditingController _tecIP = TextEditingController();
  TextEditingController _tecPort = TextEditingController();

  final sci = new ServerConnectionInfo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServerSettings();
  }

  void getServerSettings() async {
    await sci.getServerInfo();

    _tecIP.text = sci.serverip;
    _tecPort.text = sci.serverport;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
        actions: <Widget>[
          Hero(
            tag: 'logoappbar',
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image(
                image: AssetImage('assets/st22000.png'),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        height: SizeConfig.safeBlockVertical * 100,
        width: SizeConfig.safeBlockHorizontal * 100,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _tecIP,
                decoration: InputDecoration(
                  labelText: 'IP',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'IP cannot be blank. No Default';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tecPort,
                decoration: InputDecoration(
                  labelText: 'Port',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Port cannot be blank. No Default';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          sci.setServerInfo(_tecIP.text, _tecPort.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}
