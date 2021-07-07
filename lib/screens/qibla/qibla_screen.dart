import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:intl/intl.dart';
import 'package:my_muslim_app/screens/qibla/components/compass_qibla.dart';

import '../../constants.dart';

class QiblaScreen extends StatefulWidget {
  final Function onBackArrowPressed;
  const QiblaScreen({Key? key, required this.onBackArrowPressed})
      : super(key: key);

  @override
  _QiblaScreenState createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  late String _currentTimeString;
  late Timer _timer;
  late FutureBuilder _compassBuilder;

  void startDisplayCurrentTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTimeString = DateFormat('kk:mm').format(DateTime.now());
      });
    });
  }

  @override
  void initState() {
    _currentTimeString = DateFormat('kk:mm').format(DateTime.now());
    _compassBuilder = loadCompass();

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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: PRIMARY_COLOR),
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height / 2.5),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  image: DecorationImage(
                      image: ExactAssetImage('assets/images/mosque-vector.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: PRIMARY_COLOR_LIGHTER,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.all(4),
                                iconSize: 25,
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: widget.onBackArrowPressed as void
                                    Function(),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            'Arah Kiblat',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: PRIMARY_COLOR_LIGHTER,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.all(4),
                                iconSize: 25,
                                icon: Icon(
                                  Icons.refresh_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _compassBuilder = loadCompass();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Dzuhur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _currentTimeString,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Jember, Kecamatan Kaliwates',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: _compassBuilder,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder loadCompass() {
    return FutureBuilder(
      future: _deviceSupport,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
            child: Text("Error: ${snapshot.error.toString()}"),
          );

        if (snapshot.data!)
          return Padding(
            padding: const EdgeInsets.all(40),
            child: CompassQibla(),
          );
        else
          return Center(
            child: Text('Tidak dapat menampilkan kompas'),
          );
      },
    );
  }
}
