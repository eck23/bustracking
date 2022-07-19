import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

loading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    builder: (ctx) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.blue.shade700,
          strokeWidth: 5,
        ),
      );
    },
    context: context,
  );
}

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton()
      ],
    );
  }
}
