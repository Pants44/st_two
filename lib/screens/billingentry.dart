import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';

bool detailview = false;

class BillingEntryPage extends StatefulWidget {
  BillingEntryPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _BillingEntryPageState createState() => _BillingEntryPageState();
}

class _BillingEntryPageState extends State<BillingEntryPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
        actions: <Widget>[
          CloseButton(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Ticket Entry'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a ticket/entry to bill against';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Customer'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a customer';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'POC'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a point of contact';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Start and End Times need to go here'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a ticket/entry to bill against';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Service Level'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a service level';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Extra time'
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Notes'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a what you did';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Internal Notes'
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 64),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                )
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Icon(Icons.search),
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BillingEntryPage(
                    title: "Add Entry")),);
        },
      ),
    );
  }
}
