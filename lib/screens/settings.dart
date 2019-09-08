import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';

bool dm=true, pn=true, tdc=true, cn=true, efl=true;

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
              Card(
                child: SwitchListTile(
                  title: Text('Dark Mode'),
                  subtitle: Text('Give your eyes a break.'),
                  value: dm,
                  onChanged: (value){dm=value;setState((){});},
                ),
              ),
              Card(
                child: SwitchListTile(
                  isThreeLine: true,
                  title: Text('Push Notifications'),
                  subtitle: Text('Enable the ability to receive live notifications about Tickets, and other important updates.'),
                  value: pn,
                  onChanged: (value){pn=value;setState((){});},
                ),
              ),
              Card(
                child: SwitchListTile(
                  isThreeLine: true,
                  title: Text('Ticket Detail Compression'),
                  subtitle: Text('Allows for a more compact initial viewing of ticket information.'),
                  value: tdc,
                  onChanged: (value){tdc=value;setState((){});},
                ),
              ),
              Card(
                child: SwitchListTile(
                  isThreeLine: true,
                  title: Text('Chat Notifications'),
                  subtitle: Text('Enable notifcations from the PracticalTek Chat'),
                  value: cn,
                  onChanged: (value){cn=value;setState((){});},
                ),
              ),
              Card(
                child: SwitchListTile(
                  isThreeLine: true,
                  title: Text('Enable Fingerprint Login'),
                  subtitle: Text('Remove the need to enter in a password. Just use your fingerprint' ),
                  value: efl,
                  onChanged: (value){efl=value;setState((){});},
                ),
              ),
            ],
          )),
    );
  }
}
