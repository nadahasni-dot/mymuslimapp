import 'dart:async';
import 'package:intl/intl.dart'; //for date format
import 'package:flutter/material.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';

import '../../../../../constants.dart';

class SholatTimeCard extends StatefulWidget {
  SholatTimeCard({Key? key}) : super(key: key);

  @override
  _SholatTimeCardState createState() => _SholatTimeCardState();
}

class _SholatTimeCardState extends State<SholatTimeCard> {
  late bool _isAlarmOn;
  late String _timeRemainingToNextSholat;
  late Timer _timer;

  void startDisplayCurrentTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemainingToNextSholat =
            DateFormat('kk:mm:ss').format(DateTime.now());
      });
    });
  }

  @override
  void initState() {
    _isAlarmOn = false;
    _timeRemainingToNextSholat = DateFormat('kk:mm:ss').format(DateTime.now());

    startDisplayCurrentTime();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: PRIMARY_GRADIENT_COLOR_TOP_TO_BOTTOM,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: PRIMARY_COLOR_LIGHTER,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.all(4),
                          iconSize: 20,
                          icon: Icon(
                            _isAlarmOn
                                ? Icons.volume_up_rounded
                                : Icons.volume_off_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isAlarmOn = !_isAlarmOn;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      _isAlarmOn ? 'ON' : 'OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _timeRemainingToNextSholat,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Jam Menuju Ashar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Min, 10 Mei 2021',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '15:05 WIB',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Shalat Berikutnya',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            SnackBarHelper.displaySnackBar(
                                context, "Fitur ini sedang dalam pengembangan");
                          },
                          child: Text(
                            'Lihat Kiblat',
                            style: TextStyle(
                              fontSize: 14,
                              color: PRIMARY_COLOR,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.asset('assets/images/mosque-ashar.png'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
