import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class SubscriberSeries {
  final String crime;
  final int value;
  final charts.Color barColor;

  SubscriberSeries(
      {@required this.crime,
        @required this.value,
        @required this.barColor});
}

