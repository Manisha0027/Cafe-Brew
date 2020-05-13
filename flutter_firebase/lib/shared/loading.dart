import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[900],
      child: Center(
        child: SpinKitWanderingCubes (
          color: Colors.yellow[700],
          size: 50.0,
        ),),
      
    );
  }
}