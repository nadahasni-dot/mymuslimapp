import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class TopSummaryMenu extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function onTap;

  const TopSummaryMenu(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: PRIMARY_COLOR,
                  width: 2,
                ),
              ),
              child: Center(
                child: icon,
              ),
            ),
            SizedBox(height: 8),
            Text(
              text,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
