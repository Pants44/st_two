import 'package:flutter/material.dart';
import 'package:st_two/size_config.dart';
import 'package:st_two/charts/piechart.dart';

class AnalyticsPage extends StatefulWidget {
  AnalyticsPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    var orientation = MediaQuery.of(context).orientation;
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
            child: Center(child: Text('Total Workload Breakdon', style: TextStyle(fontSize: 24),)),
          ),
          Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 80,
              child: DonutAutoLabelChartWorkloadBreakdown.withSampleData())
        ],
      )),
    );
  }
}
