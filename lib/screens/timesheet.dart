import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:st_two/data/processbilling.dart';
import 'package:st_two/size_config.dart';

bool detailview = false;

class TimesheetPage extends StatefulWidget {
  TimesheetPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _TimesheetPageState createState() => _TimesheetPageState();
}

class _TimesheetPageState extends State<TimesheetPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Week of Aug 19th'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
            child: Image(
              image: AssetImage('assets/st22000.png'),
            ),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<BillingWeek>(
          future: _loadBillingEntries(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                print(snapshot.data.toString());
              }

              return snapshot.hasData ?
                  Container(
                    padding: EdgeInsets.all(2),
                    width: SizeConfig.safeBlockHorizontal * 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SwitchListTile(
                          title: Align(alignment: Alignment.centerRight, child: Text('QB Detail View'),),
                          value: detailview,
                          onChanged:(value){
                            setState((){
                              detailview = value;
                            });
                          }
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.billingdayslist.length,
                          itemBuilder: (_, int index){
                            var item = snapshot.data.billingdayslist[index];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(child:Align(alignment: Alignment.topLeft, child: Padding(padding: EdgeInsets.all(8), child: Text(item.billdate.toString(), style: TextStyle(fontSize: 36),),),),),
                                    Expanded(child:Align(alignment: Alignment.topRight, child: Padding(padding: EdgeInsets.all(8), child: Text(item.billingtotalday.toString(), style: TextStyle(fontSize: 36),))))
                                  ],
                                ),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: item.billingentries.length,
                                  itemBuilder: (_, int index2){
                                    var item2 = item.billingentries[index2];
                                    return detailview ? Card(
                                      child: ListTile(
                                          title: Text(item.billdate.toString() + ', ' +
                                              item2.customer.toString() + ', ' +
                                              item2.resource.toString() + ', ' +
                                              item2.poc.toString() + ', ' +
                                              'ID#'+ item2.ticket.toString() + ', ' +
                                              '( ' + item2.notes.toString() + ' )')
                                      ),
                                    )
                                        : Card(
                                      child: ListTile(
                                        title: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(flex:3,child:Align(alignment: Alignment.centerLeft, child:Text(item2.ticket.toString()))),
                                            Expanded(flex:1,child:Align(alignment: Alignment.centerRight, child:Text(item2.billedtime.toString())))
                                          ],
                                        ),
                                        subtitle: Text(item2.customer.toString()),
                                      )
                                    );
                                  },
                                ),
                              ],
                            );
                          },

                        )
                      ],
                    ),
                  )
                  : Container();

            }
            return Container();
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Icon(Icons.add),
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {},
      ),
    );
  }

  Future<BillingWeek> _loadBillingEntries() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/billingentrydata.json");
    final jsonResponse = json.decode(jsonString);
    BillingWeek belist = new BillingWeek.fromJson(jsonResponse);
    return belist;
  }

}
