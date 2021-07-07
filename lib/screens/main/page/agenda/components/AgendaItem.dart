import 'package:flutter/material.dart';
import 'package:my_muslim_app/constants.dart';

class AgendaItem extends StatefulWidget {
  final String sholat;
  final String waktu;
  final bool isCompleted;
  final Function(bool? isClicked) onClick;

  AgendaItem({
    Key? key,
    required this.sholat,
    required this.waktu,
    required this.isCompleted,
    required this.onClick,
  }) : super(key: key);

  @override
  _AgendaItemState createState() => _AgendaItemState();
}

class _AgendaItemState extends State<AgendaItem> {
  bool? _isCompleted;

  @override
  void initState() {
    _isCompleted = widget.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sholat,
                  style: TextStyle(
                    color: TEXT_COLOR_DARK,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: TEXT_COLOR_LIGHT,
                      size: 16,
                    ),
                    SizedBox(width: 10),
                    Text(widget.waktu),
                  ],
                )
              ],
            ),
          ),          
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 28,
            icon: Icon(
                _isCompleted! ? Icons.check_circle : Icons.check_circle_outline),
            onPressed: () {
              setState(() {
                _isCompleted = !_isCompleted!;
              });

              widget.onClick(_isCompleted);
            },
            color: _isCompleted! ? PRIMARY_COLOR : TEXT_COLOR_LIGHT,
          )
        ],
      ),
    );
  }
}
