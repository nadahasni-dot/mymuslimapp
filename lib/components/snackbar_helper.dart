import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static displaySnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
