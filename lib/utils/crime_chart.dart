import 'package:charts_flutter/flutter.dart' as charts;
import 'package:map/utils/crime_series.dart';
import 'package:flutter/material.dart';

class SubscriberChart extends StatelessWidget {
  final List<SubscriberSeries> data;

  SubscriberChart({@required this.data});


  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "crime",
          data: data,
          domainFn: (SubscriberSeries series, _) => series.crime,
          measureFn: (SubscriberSeries series, _) => series.value,
          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];
    return charts.BarChart(series, animate: true);
  }
}