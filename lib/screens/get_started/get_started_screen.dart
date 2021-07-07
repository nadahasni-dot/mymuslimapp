import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/page_view_area.dart';

class GetStarted extends StatelessWidget {
  static String routeName = "/get_started";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageViewArea(),
      ),
    );
  }
}
