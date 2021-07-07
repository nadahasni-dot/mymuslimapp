import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class DateItem extends StatelessWidget {
  final String? day;
  final String? date;
  final bool selected;
  // final Function(int index) onTap;

  const DateItem({
    Key? key,
    required this.day,
    required this.date,
    required this.selected,
    // @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            day!,
            style: TextStyle(color: TEXT_COLOR_LIGHT),
          ),
          SizedBox(height: 8),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: selected ? PRIMARY_COLOR : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                date!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : TEXT_COLOR_DARK,
                    fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
