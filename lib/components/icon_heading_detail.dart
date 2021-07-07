import 'package:flutter/material.dart';

import '../constants.dart';

class IconHeadingDetail extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const IconHeadingDetail({
    Key? key,
    required this.icon,
    required this.title,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: SECONDARY_COLOR,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: TEXT_COLOR_LIGHT),
                ),
                SizedBox(height: 4),
                Text(
                  detail,
                  style: TextStyle(
                    color: TEXT_COLOR_DARK,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
