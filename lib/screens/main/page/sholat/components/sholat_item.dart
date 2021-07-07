import 'package:flutter/material.dart';
import 'package:my_muslim_app/constants.dart';

class SholatItem extends StatefulWidget {
  final bool? selected;
  final bool? isMuted;
  final String? sholat;
  final String? time;

  const SholatItem({
    Key? key,
    required this.selected,
    required this.isMuted,
    required this.sholat,
    required this.time,
  }) : super(key: key);

  @override
  _SholatItemState createState() => _SholatItemState();
}

class _SholatItemState extends State<SholatItem> {
  bool? _isMuted;

  @override
  void initState() {
    _isMuted = widget.isMuted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 14.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 80,
        decoration: BoxDecoration(
          color: widget.selected! ? PRIMARY_LIGHT_COLOR : Colors.white,
          border: Border.all(
            color: widget.selected! ? PRIMARY_COLOR : Colors.grey.shade200,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.sholat!,
                  style: TextStyle(
                    color: TEXT_COLOR_DARK,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(widget.time!),
              SizedBox(width: 8),
              IconButton(
                icon: _isMuted! ? Icon(Icons.volume_off_rounded) : Icon(Icons.volume_up),
                color: PRIMARY_COLOR,
                onPressed: () {
                  setState(() {
                    _isMuted = !_isMuted!;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
