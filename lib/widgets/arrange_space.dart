import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({Key? key, this.heightOfWidget, this.widthOfWidget})
      : super(key: key);

  final double? heightOfWidget;
  final double? widthOfWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightOfWidget,
      width: widthOfWidget,
    );
  }
}
