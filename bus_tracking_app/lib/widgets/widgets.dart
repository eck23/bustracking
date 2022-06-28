import 'package:flutter/material.dart';

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