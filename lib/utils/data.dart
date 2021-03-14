import 'package:charts_flutter/flutter.dart' as charts;
import 'crime_chart.dart';
import 'package:map/utils/crime_series.dart';
import 'package:flutter/material.dart';
import 'package:map/utils/constant.dart';

class HomePage extends StatelessWidget {
  final int drugs;
  final int molestation;
  final int other;
  final int murder;
  final int robbery;
  const HomePage(
      {Key key,
      this.drugs,
      this.molestation,
      this.other,
      this.murder,
      this.robbery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SubscriberSeries> data = [
      SubscriberSeries(
        crime: "Drugs",
        value: drugs,
        barColor: charts.ColorUtil.fromDartColor(klightBlue),
      ),
      SubscriberSeries(
        crime: "Murder",
        value: murder,
        barColor: charts.ColorUtil.fromDartColor(klightBlue),
      ),
      SubscriberSeries(
        crime: "Robbery",
        value: robbery,
        barColor: charts.ColorUtil.fromDartColor(klightBlue),
      ),
      SubscriberSeries(
        crime: "Molestation",
        value: molestation,
        barColor: charts.ColorUtil.fromDartColor(klightBlue),
      ),
      SubscriberSeries(
        crime: "Others",
        value: other,
        barColor: charts.ColorUtil.fromDartColor(klightBlue),
      ),
    ];
    return Scaffold(
      body: Center(child: SubscriberChart(data: data)),
    );
  }
}
