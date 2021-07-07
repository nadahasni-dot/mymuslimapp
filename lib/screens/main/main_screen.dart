import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/screens/main/page/agenda/agenda_page.dart';
import 'package:my_muslim_app/screens/main/page/beranda/beranda_page.dart';
import 'package:my_muslim_app/screens/main/page/pengaturan/pengaturan.dart';
import 'package:my_muslim_app/screens/main/page/sholat/sholat_page.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/main_screen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  List<Widget> pageList = [
    BerandaPage(),
    SholatPage(),
    AgendaPage(),
    PengaturanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: PRIMARY_COLOR),
      ),
      body: SafeArea(
        child: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
          child: pageList[pageIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Color(0xFFC0C0C0),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_rounded),
            label: "Sholat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: "Agenda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
