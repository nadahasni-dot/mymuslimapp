import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import 'location_error.dart';

class CompassQibla extends StatefulWidget {
  CompassQibla({Key? key}) : super(key: key);

  @override
  _CompassQiblaState createState() => _CompassQiblaState();
}

class _CompassQiblaState extends State<CompassQibla> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        if (snapshot.data!.enabled == true) {
          switch (snapshot.data!.status) {
            case LocationPermission.always:
            case LocationPermission.whileInUse:
              return CompassQiblaWidget();
            case LocationPermission.denied:
              return LocationErrorWidget(
                text: "Location service tidak diijinkan",
                callback: () {
                  setState(() {
                    _checkLocationStatus();
                  });
                },
              );
            case LocationPermission.deniedForever:
              return LocationErrorWidget(
                text: "Location service tidak diijinkan",
                callback: () {
                  setState(() {
                    _checkLocationStatus();
                  });
                },
              );
            default:
              return LocationErrorWidget(
                text: "Tidak Dapat Menampilkan Compass",
                callback: () {
                  setState(() {
                    _checkLocationStatus();
                  });
                },
              );
          }
        } else {
          return LocationErrorWidget(
            text: "Please enable Location service",
            callback: () {
              setState(() {
                _checkLocationStatus();
              });
            },
          );
        }
      },
    );
  }
}

class CompassQiblaWidget extends StatelessWidget {
  const CompassQiblaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        final qiblahDirection = snapshot.data!;

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.rotate(
              angle: (qiblahDirection.direction * (pi / 180) * -1),
              child: Center(
                child: SvgPicture.asset('assets/icons/compass-bg.svg'),
              ),
            ),
            Transform.rotate(
              angle: (qiblahDirection.qiblah * (pi / 180) * -1),
              alignment: Alignment.center,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/compass-nedle.svg',
                  height: 150,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
