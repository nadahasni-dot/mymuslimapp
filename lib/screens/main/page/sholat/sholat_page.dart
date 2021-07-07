import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_muslim_app/components/icon_heading_detail.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/model/date_item_model.dart';

import 'components/date_item.dart';
import 'components/sholat_time_section.dart';

class SholatPage extends StatefulWidget {
  const SholatPage({Key? key}) : super(key: key);

  @override
  _SholatPageState createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  List<DateItemModel> _dateList = [
    DateItemModel(index: 0, day: 'SEN', date: '7'),
    DateItemModel(index: 1, day: 'SEL', date: '8'),
    DateItemModel(index: 2, day: 'RAB', date: '9'),
    DateItemModel(index: 3, day: 'KAM', date: '10'),
    DateItemModel(index: 4, day: 'JUM', date: '11'),
    DateItemModel(index: 5, day: 'SAB', date: '12'),
    DateItemModel(index: 6, day: 'MIN', date: '13'),
  ];

  List<Widget> _sholatTimeList = [
    SholatTimeSection(),
    SholatTimeSection(),
    SholatTimeSection(),
    SholatTimeSection(),
    SholatTimeSection(),
    SholatTimeSection(),
    SholatTimeSection(),
  ];

  int? _selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: IconHeadingDetail(
                      icon: Icons.location_on_outlined,
                      title: 'Lokasi Anda',
                      detail: 'Jember',
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          'assets/icons/compass.svg',
                          height: 30,
                          width: 30,
                          color: TEXT_COLOR_LIGHT,
                        ),
                        onPressed: () {
                          SnackBarHelper.displaySnackBar(
                              context, "Fitur ini sedang dalam pengembangan");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _dateList.map((item) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedDateIndex = item.index;
                      _selectedDateIndex = item.index;
                    });
                  },
                  child: DateItem(
                    day: item.day,
                    date: item.date,
                    selected: item.index == _selectedDateIndex ? true : false,
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: PageTransitionSwitcher(
              transitionBuilder:
                  (child, primaryAnimation, secondaryAnimation) =>
                      FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              ),
              child: _sholatTimeList[_selectedDateIndex!],
            ),
          ),
        ],
      ),
    );
  }
}
