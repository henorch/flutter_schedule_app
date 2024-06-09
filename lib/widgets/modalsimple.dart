import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final String error;
  const CustomWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      insetAnimationCurve: Curves.ease,
      insetAnimationDuration: Duration(milliseconds: 200),
      child: ColoredBox(
        color: Colors.red,
        child: Text("Error Pad"),
      ),
    );
  }
}
