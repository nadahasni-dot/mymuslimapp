import 'package:flutter/material.dart';
import 'package:my_muslim_app/model/sholat_time_item_model.dart';
import 'package:my_muslim_app/screens/main/page/sholat/components/sholat_item.dart';
import 'package:my_muslim_app/screens/main/page/sholat/components/sholat_time_card.dart';

class SholatTimeSection extends StatefulWidget {
  const SholatTimeSection({Key? key}) : super(key: key);

  @override
  _SholatTimeSectionState createState() => _SholatTimeSectionState();
}

class _SholatTimeSectionState extends State<SholatTimeSection> {
  List<SholatTimeItemModel> _sholatTimeList = [
    SholatTimeItemModel(
        index: 0,
        isMuted: false,
        selected: false,
        sholat: 'Subuh',
        time: '05:00'),
    SholatTimeItemModel(
        index: 0,
        isMuted: false,
        selected: false,
        sholat: 'Duhur',
        time: '12:00'),
    SholatTimeItemModel(
        index: 0,
        isMuted: false,
        selected: true,
        sholat: 'Ashar',
        time: '15:00'),
    SholatTimeItemModel(
        index: 0,
        isMuted: false,
        selected: false,
        sholat: 'Maghrib',
        time: '18:00'),
    SholatTimeItemModel(
        index: 0,
        isMuted: false,
        selected: false,
        sholat: 'Isya',
        time: '17:00'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SholatTimeCard(),
            ),
            SizedBox(height: 14),
            ...List.generate(
              _sholatTimeList.length,
              (index) => SholatItem(
                sholat: _sholatTimeList[index].sholat,
                time: _sholatTimeList[index].time,
                isMuted: _sholatTimeList[index].isMuted,
                selected: _sholatTimeList[index].selected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
