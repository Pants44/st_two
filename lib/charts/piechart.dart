/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData() {
    return new PieOutsideLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<YieldResource, int>> _createSampleData() {
    final data = [
      new YieldResource(2, 'Jim', 5),
      new YieldResource(3, 'Dena', 5),
      new YieldResource(4, 'Jeremy', 20),
      new YieldResource(5, 'Jarrad', 15),
      new YieldResource(6, 'Brandon', 1),
      new YieldResource(7, 'Sam', 10),
      new YieldResource(8, 'Chance', 15),
      new YieldResource(9, 'Josh', 19),
      new YieldResource(10, 'Luke', 10)
    ];

    return [
      new charts.Series<YieldResource, int>(
        id: 'Yields',
        domainFn: (YieldResource yres, _) => yres.resourceid,
        measureFn: (YieldResource yres, _) => yres.percentoftotal,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (YieldResource row, _) =>
            '${row.resourcename}: ${row.percentoftotal}',
      )
    ];
  }
}

class DonutAutoLabelChartTotalYieldBreakdown extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChartTotalYieldBreakdown(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutAutoLabelChartTotalYieldBreakdown.withSampleData() {
    return new DonutAutoLabelChartTotalYieldBreakdown(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        //
        // [ArcLabelDecorator] will automatically position the label inside the
        // arc if the label will fit. If the label will not fit, it will draw
        // outside of the arc with a leader line. Labels can always display
        // inside or outside using [LabelPosition].
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 200,
            arcRendererDecorators: [charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<YieldResource, int>> _createSampleData() {
    final data = [
      new YieldResource(2, 'Jim', 5),
      new YieldResource(3, 'Dena', 5),
      new YieldResource(4, 'Jeremy', 20),
      new YieldResource(5, 'Jarrad', 15),
      new YieldResource(6, 'Brandon', 1),
      new YieldResource(7, 'Sam', 10),
      new YieldResource(8, 'Chance', 15),
      new YieldResource(9, 'Josh', 19),
      new YieldResource(10, 'Luke', 10)
    ];

    return [
      new charts.Series<YieldResource, int>(
        id: 'Yields',
        domainFn: (YieldResource yres, _) => yres.resourceid,
        measureFn: (YieldResource yres, _) => yres.percentoftotal,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (YieldResource row, _) =>
            '${row.resourcename}: ${row.percentoftotal}',
      )
    ];
  }
}

class YieldResource {
  final int resourceid;
  final String resourcename;
  final double percentoftotal;

  YieldResource(
    this.resourceid,
    this.resourcename,
    this.percentoftotal,
  );
}

class DonutAutoLabelChartWorkloadBreakdown extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChartWorkloadBreakdown(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutAutoLabelChartWorkloadBreakdown.withSampleData() {
    return new DonutAutoLabelChartWorkloadBreakdown(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      behaviors: [

        charts.ChartTitle('Total: 2005 hrs',
            titleStyleSpec: charts.TextStyleSpec(
                color: charts.Color(r: 255, g: 255, b: 255), fontSize: 24),
            subTitle: '2005 / 100 = 4.98%',
            subTitleStyleSpec: charts.TextStyleSpec(
                color: charts.Color(r: 255, g: 255, b: 255), fontSize: 16)),
        charts.DatumLegend(
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: charts.BehaviorPosition.top,
          // For a legend that is positioned on the left or right of the chart,
          // setting the justification for [endDrawArea] is aligned to the
          // bottom of the chart draw area.
          outsideJustification: charts.OutsideJustification.middleDrawArea,

          // By default, if the position of the chart is on the left or right of
          // the chart, [horizontalFirst] is set to false. This means that the
          // legend entries will grow as new rows first instead of a new column.
          horizontalFirst: false,
          // By setting this value to 2, the legend entries will grow up to two
          // rows before adding a new column.
          desiredMaxRows: 3,
          // This defines the padding around each legend entry.
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          // Render the legend entry text with custom styles.
          entryTextStyle: charts.TextStyleSpec(
              color: charts.Color(r: 255, g: 255, b: 255), fontSize: 16),
        )
      ],
      // Configure the width of the pie slices to 60px. The remaining space in
      // the chart will be left as a hole in the center.
      //
      // [ArcLabelDecorator] will automatically position the label inside the
      // arc if the label will fit. If the label will not fit, it will draw
      // outside of the arc with a leader line. Labels can always display
      // inside or outside using [LabelPosition].
      //
      // Text style for inside / outside can be controlled independently by
      // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
      //
      // Example configuring different styles for inside/outside:
      //       new charts.ArcLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 200,
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.auto,
            outsideLabelStyleSpec: charts.TextStyleSpec(
              color: charts.Color(r: 255, g: 255, b: 255, a: 255),
              fontSize: 16,
            ),
            insideLabelStyleSpec: charts.TextStyleSpec(
              color: charts.Color(r: 0, g: 0, b: 0, a: 255),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<WorkloadResource, String>> _createSampleData() {
    final data = [
      new WorkloadResource(2, 'Jim', 5, 100),
      new WorkloadResource(3, 'Dena', 5, 100),
      new WorkloadResource(4, 'Jeremy', 20, 400),
      new WorkloadResource(5, 'Jarrad', 15, 300),
      new WorkloadResource(6, 'Brandon', 1, 10),
      new WorkloadResource(7, 'Sam', 10, 200),
      new WorkloadResource(8, 'Chance', 15, 300),
      new WorkloadResource(9, 'Josh', 19, 395),
      new WorkloadResource(10, 'Luke', 10, 200)
    ];

    return [
      new charts.Series<WorkloadResource, String>(
        id: 'Yields',
        domainFn: (WorkloadResource yres, _) => yres.resourcename,
        measureFn: (WorkloadResource yres, _) => yres.percentoftotal,
        data: data,
        // Set a label accessor to control the text of the arc label.

        labelAccessorFn: (WorkloadResource row, _) => '${row.hrs}',
      )
    ];
  }
}

class WorkloadResource {
  final int resourceid;
  final String resourcename;
  final double percentoftotal, hrs;

  WorkloadResource(
      this.resourceid, this.resourcename, this.percentoftotal, this.hrs);
}
