import 'dart:async';
import 'package:flutter/material.dart';
import 'package:st_two/data/poc.dart';

//For screen
bool vronly = false;
bool vchanged = false;
String vmode = '';
String vtitle = '';

//Objects

//Data
List<TextEditingController> tecPOCIDs = new List();
List<TextEditingController> tecPOCNames = new List();
List<DropdownMenuItem<String>> pocdd = new List();


final _formKey = GlobalKey<FormState>();

class TicketPOCPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final int customerid;
  final List<POC> poclist;

  TicketPOCPage(
      {Key key,
        @required this.mode,
        @required this.ronly,
        this.title,
        this.customerid,
        this.poclist})
      : super(key: key);


  @override
  _TicketPOCPageState createState() => _TicketPOCPageState();
}

class _TicketPOCPageState extends State<TicketPOCPage> {

  List<POC> poclist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vmode = widget.mode;
    vronly = widget.ronly;
    vtitle = widget.title;
    if (vmode == 'edit') {
      _loadData(widget.customerid, widget.poclist);
    } else if (vmode == 'add') {
      _loadData(widget.customerid);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  Future<void> _loadData(int customerid, [List<POC> cpl]) async {

    POCList pocs = await POC().fetchall(customerid);

    pocdd.clear();

    pocs.pocs.forEach((p){
      pocdd?.add(DropdownMenuItem(
        value: p.customerid.toString() + p.pocid.toString(),
        child: Text(p.pocname),
      ));
    });

    if (cpl != null) {
      poclist = cpl;
      setState((){});
    } else {
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(vtitle),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('NOT DONE CUZ IM LAZY OKAY'),
            DropdownButton(
              items: pocdd,
              value: "2020",
              onChanged: (c){

              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

        },
      ),
    );
  }
}