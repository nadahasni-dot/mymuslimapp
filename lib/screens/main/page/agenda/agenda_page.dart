import 'package:flutter/material.dart';
import 'package:my_muslim_app/components/icon_heading_detail.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';
import 'package:my_muslim_app/model/date_item_model.dart';
import 'package:my_muslim_app/screens/main/page/agenda/components/AgendaItem.dart';
import 'package:my_muslim_app/screens/main/page/sholat/components/date_item.dart';

import '../../../../constants.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  List<DateItemModel> _dateList = [
    DateItemModel(index: 0, day: 'SEN', date: '7'),
    DateItemModel(index: 1, day: 'SEL', date: '8'),
    DateItemModel(index: 2, day: 'RAB', date: '9'),
    DateItemModel(index: 3, day: 'KAM', date: '10'),
    DateItemModel(index: 4, day: 'JUM', date: '11'),
    DateItemModel(index: 5, day: 'SAB', date: '12'),
    DateItemModel(index: 6, day: 'MIN', date: '13'),
  ];

  List<List> _agendaList = [
    ['Subuh', '05:00'],
    ['Duhur', '12:00'],
    ['Ashar', '15:00'],
    ['Maghrib', '18:00'],
    ['Isya', '17:00'],
  ];

  int? _selectedDateIndex = 0;
  double _percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IconHeadingDetail(
                    icon: Icons.calendar_today_rounded,
                    title: 'Senin',
                    detail: '07 Juni 2021',
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        SnackBarHelper.displaySnackBar(
                            context, "Fitur ini sedang dalam pengembangan");
                      },
                      child: Text(
                        'Tambah Agenda',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(PRIMARY_COLOR),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
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
          SizedBox(height: 20),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.grey.shade200,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Pencapaian:',
                        style: TextStyle(color: TEXT_COLOR_DARK),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${(_percentage * 100).toStringAsFixed(0)} %',
                        style: TextStyle(
                          color: TEXT_COLOR_DARK,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: 10,
                        width: (MediaQuery.of(context).size.width - 40) *
                            _percentage,
                        decoration: BoxDecoration(
                          color: SECONDARY_COLOR,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: _agendaList.length,
              itemBuilder: (BuildContext context, int index) {
                return AgendaItem(
                  sholat: _agendaList[index][0],
                  waktu: _agendaList[index][1],
                  isCompleted: false,
                  onClick: (isChecked) {
                    if (isChecked!) {
                      setState(() {
                        _percentage += (1 / _agendaList.length);
                      });
                    } else {
                      setState(() {
                        _percentage -= (1 / _agendaList.length);
                      });
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
