import 'package:flutter/material.dart';
import 'package:my_muslim_app/constants.dart';

class PengaturanListItem extends StatelessWidget {
  final Function onTap;
  final Widget icon;
  final String text;
  const PengaturanListItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap as void Function(),
      leading: icon,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      title: Text(text,
          style: TextStyle(
            color: TEXT_COLOR_DARK,
            fontWeight: FontWeight.w600,
          )),
    );
  }
}
