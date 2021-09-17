import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(41, 42, 75, 1),
      child: Center(
        child: SpinKitRipple(
          color: Color.fromRGBO(131, 133, 238, 1),
          size: 50.0,
        ),
      ),
    );
  }
}
