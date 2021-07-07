import 'package:flutter/material.dart';
import 'package:my_muslim_app/screens/get_started/get_started_screen.dart';
import 'package:my_muslim_app/screens/main/main_screen.dart';
import 'package:my_muslim_app/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  GetStarted.routeName: (context) => GetStarted(),
  MainScreen.routeName: (context) => MainScreen(),
};
