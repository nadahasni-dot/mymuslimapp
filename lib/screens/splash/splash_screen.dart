import 'package:flutter/material.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/screens/get_started/get_started_screen.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    _goToGetStarted(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Image.asset('assets/images/splash.png'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'MUSLIM APP',
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void _goToGetStarted(BuildContext context) {
    try {
      new Future.delayed(const Duration(seconds: 3), () {
        Navigator.popAndPushNamed(context, GetStarted.routeName);
      });
    } catch (e) {
      print('error future delayed');
    }
  }
}
