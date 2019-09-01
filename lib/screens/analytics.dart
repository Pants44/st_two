import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:st_two/data/processdropdowns.dart';
import 'package:st_two/charts/piechart.dart';

class AnalyticsPage extends StatefulWidget {
  AnalyticsPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  DateTime selectedDate = DateTime.now();

  TextEditingController _tecStartDate = TextEditingController();

  TextEditingController _tecEndDate = TextEditingController();
  bool g = false, s = false, e = false;
  String gtype;

  String _graphSelection = 'Select Graph';
  String _graphRangeSelection = '1 Month';
  List<DropdownMenuItem<String>> graphdropdown = [];
  List<DropdownMenuItem<String>> graphrangedropdown = [];

  @override
  void initState() {
    super.initState();
    loadFilterDropdowns();
    _tecStartDate.text = 'Start Date';
    _tecStartDate.addListener(() {
      setState(() {
        s = true;
      });
    });
    _tecEndDate.text = 'End Date';
    _tecEndDate.addListener(() {
      setState(() {
        e = true;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tecEndDate.dispose();
    _tecStartDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    //var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Container(
          padding: EdgeInsets.all(10),
          color: Theme.of(context).accentColor,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              style: TextStyle(fontSize: 20),
              isExpanded: true,
              isDense: true,
              value: _graphSelection,
              onChanged: (String newValue) {
                setState(() {
                  _graphSelection = newValue;
                  newValue == 'Select Graph' ? g = false : g = true;
                });

                print(_graphSelection);
              },
              items: graphdropdown,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right:4),
              child: IconButton(icon: Icon(Icons.share), onPressed: (){}),
            )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: RaisedButton(
                          onPressed: () => _selectDate(context, 'start'),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  controller: _tecStartDate,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Icon(Icons.keyboard_arrow_down),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: RaisedButton(
                          onPressed: () => _selectDate(context, 'end'),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  controller: _tecEndDate,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Icon(Icons.keyboard_arrow_down),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                      future: _completeGraphSelections(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          return snapshot.hasData
                              ? snapshot.data
                                  ? Container(
                                      width:
                                          SizeConfig.safeBlockHorizontal * 100,
                                      height: SizeConfig.safeBlockVertical * 80,
                                      child: whichgraph(),
                                    )
                                  : Center(
                                      child: Container(
                                        child: Text(
                                            'Please select a graph and some dates'),
                                      ),
                                    )
                              : Center(
                                  child: Container(
                                    child: Text(
                                        'Please select a graph and some dates'),
                                  ),
                                );
                        } else {
                          print('no future connection for graph');
                          return Center(
                            child: Container(
                              child:
                                  Text('Please select a graph and some dates'),
                            ),
                          );
                        }
                      },
                    ),
                    /*Container(
                      width: SizeConfig.safeBlockHorizontal * 100,
                      height: SizeConfig.safeBlockVertical * 80,
                      child: DonutAutoLabelChartTotalYieldBreakdown
                          .withSampleData(),
                    ),*/
                    /*Container(
                      padding: EdgeInsets.only(top: 32),
                      child: Center(
                        child: Text(
                          'Total Workload Breakdown',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.safeBlockHorizontal * 100,
                      height: SizeConfig.safeBlockVertical * 80,
                      child:
                          DonutAutoLabelChartWorkloadBreakdown.withSampleData(),
                    ),*/
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget whichgraph() {
    if (_graphSelection == 'Yield Breakdown') {
      return DonutAutoLabelChartTotalYieldBreakdown.withSampleData();
    } else if (_graphSelection == 'PTS Workload') {
      return DonutAutoLabelChartWorkloadBreakdown.withSampleData();
    } else if (_graphSelection == 'Completed Metrics') {
      return Container(
        child: Center(
          child: Text(
            'Developer is lazy',
            style: TextStyle(fontSize: 69),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Future<bool> _completeGraphSelections() async {
    print('graph:' +
        g.toString() +
        '  start:' +
        s.toString() +
        '  end:' +
        e.toString());
    return g & s & e ? true : false;
  }

  Future<Null> _selectDate(BuildContext context, String btn) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        btn == 'start'
            ? _tecStartDate.text =
                DateFormat("MM-dd-yyyy").format(picked).toString()
            : _tecEndDate.text =
                DateFormat("MM-dd-yyyy").format(picked).toString();
      });
  }

  void loadFilterDropdowns() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/graphdropdowndata.json");
    final jsonResponse = json.decode(jsonString);
    GraphSelectionListdd graphslist =
        new GraphSelectionListdd.fromJson(jsonResponse);

    String jsonString2 = await DefaultAssetBundle.of(context)
        .loadString("assets/graphrangedropdowndata.json");
    final jsonResponse2 = json.decode(jsonString2);
    GraphRangeSelectionListdd graphrangelist =
        new GraphRangeSelectionListdd.fromJson(jsonResponse2);

    for (var i = 0; i < graphslist.graphs.length; i++) {
      graphdropdown.add(
        DropdownMenuItem(
          value: graphslist.graphs[i].id,
          child: Text(graphslist.graphs[i].id.toString()),
        ),
      );
    }

    for (var i = 0; i < graphrangelist.graphselections.length; i++) {
      graphrangedropdown.add(
        DropdownMenuItem(
          value: graphrangelist.graphselections[i].id,
          child: Text(
            graphrangelist.graphselections[i].id.toString(),
          ),
        ),
      );
    }

    setState(() {});
  }
}
