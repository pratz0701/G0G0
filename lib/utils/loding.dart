import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:map/utils/constant.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: klightBlue,
      child: Center(
        child: SpinKitChasingDots(
          color: kblue,
          size: 50.0,
        ),
      ),
    );
  }
}