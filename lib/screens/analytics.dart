import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';
import 'dart:async';
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

  String _graphSelection = 'Yield';
  String _graphRangeSelection = '1 Month';
  List<DropdownMenuItem<String>> graphdropdown = [];
  List<DropdownMenuItem<String>> graphrangedropdown = [];

  @override
  void initState() {
    super.initState();
    loadFilterDropdowns();
  }

  @override
  void dispose() {
    // TODO: implement dispose

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
        title: Text(widget.title),
        actions: <Widget>[
          Hero(
            tag: 'logoappbar',
            child: Padding(
              padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
              child: Image(
                image: AssetImage('assets/st22000.png'),
              ),
            ),
          )
        ],
      ),
      body: Center(
          child: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                  isDense: true,
                  value: _graphSelection,
                  onChanged: (String newValue) {
                    setState(() {
                      _graphSelection = newValue;
                    });

                    print(_graphSelection);
                  },
                  items: graphdropdown,
                ),
              ),
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                  isDense: true,
                  value: _graphRangeSelection,
                  onChanged: (String newValue) {
                    setState(() {
                      _graphRangeSelection = newValue;
                    });

                    print(_graphRangeSelection);
                  },
                  items: graphrangedropdown,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top:32),
            child: Center(child: Text('Total Yield Breakdown', style: TextStyle(fontSize: 24),)),
          ),
          Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 80,
              child: DonutAutoLabelChartTotalYieldBreakdown.withSampleData()),
          Container(
            padding: EdgeInsets.only(top:32),
            child: Center(child: Text('Total Workload Breakdown', style: TextStyle(fontSize: 24),)),
          ),
          Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 80,
              child: DonutAutoLabelChartWorkloadBreakdown.withSampleData())
        ],
      )),
    );
  }

  void loadFilterDropdowns() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/graphdropdowndata.json");
    final jsonResponse = json.decode(jsonString);
    GraphSelectionListdd graphslist = new GraphSelectionListdd.fromJson(jsonResponse);

    String jsonString2 = await DefaultAssetBundle.of(context)
        .loadString("assets/graphrangedropdowndata.json");
    final jsonResponse2 = json.decode(jsonString2);
    GraphRangeSelectionListdd graphrangelist = new GraphRangeSelectionListdd.fromJson(jsonResponse2);

    for (var i = 0; i < graphslist.graphs.length; i++) {
      graphdropdown.add(DropdownMenuItem(
        value: graphslist.graphs[i].id,
        child: Text(graphslist.graphs[i].id.toString()),
      ));
    }

    for (var i = 0; i < graphrangelist.graphselections.length; i++) {
      graphrangedropdown.add(DropdownMenuItem(
        value: graphrangelist.graphselections[i].id,
        child: Text(graphrangelist.graphselections[i].id.toString()),
      ));
    }

    setState((){});

  }
}
