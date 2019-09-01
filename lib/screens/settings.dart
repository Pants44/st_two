import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: ListView(
            children: <Widget>[
              Card(
                child: SwitchListTile(
                  isThreeLine: true,
                  title: Text('Push Notifications'),
                  subtitle: Text('Does Nothing'),
                  value: true,
                  onChanged: (value){},
                ),
              ),
              Card(
                child: SwitchListTile(
                  isThreeLine: true,
                  title: Text('Ticket Detail Compression'),
                  subtitle: Text('Does Nothing'),
                  value: true,
                  onChanged: (value){},
                ),
              ),
              Card(
                child: SwitchListTile(
                  isThreeLine: true,
                  title: Text('Chat Notifications'),
                  subtitle: Text('Does Nothing'),
                  value: true,
                  onChanged: (value){},
                ),
              ),
              Card(
                child: SwitchListTile(
                  isThreeLine: true,
                  title: Text('Enable Fingerprint Login'),
                  subtitle: Text('I\'ll never get this working, but it makes me look cooler to have this as an option' ),
                  value: true,
                  onChanged: (value){},
                ),
              ),
              Card(
                child: SwitchListTile(
                  title: Text('Dark Mode'),
                  subtitle: Text('Give your eyes a break'),
                  value: true,
                  onChanged: (value){},
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Theme Selection'),
                  subtitle: Text('Customize your experience'),
                  trailing: SizedBox(
                    height: 48,
                    width: 48,
                    child: Container(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
