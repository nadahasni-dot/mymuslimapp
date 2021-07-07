import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_muslim_app/components/icon_heading_detail.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/screens/main/page/beranda/components/top_summary_menu.dart';
import 'package:my_muslim_app/screens/qibla/qibla_screen.dart';
import 'package:my_muslim_app/screens/quran/quran_screen.dart';

class TopSummary extends StatelessWidget {
  const TopSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: IconHeadingDetail(
                    icon: Icons.watch_later_outlined,
                    title: 'Sholat Ashar',
                    detail: '15:00 WIB',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 0, right: 10, bottom: 10),
                  child: IconHeadingDetail(
                    icon: Icons.location_on_outlined,
                    title: 'Lokasi Anda',
                    detail: 'Jember',
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Divider(
              thickness: 0.8,
            ),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OpenContainer(
                closedElevation: 0,
                transitionType: ContainerTransitionType.fadeThrough,
                closedBuilder:
                    (BuildContext context, VoidCallback openContainer) {
                  return TopSummaryMenu(
                    text: "Kiblat",
                    icon: SvgPicture.asset(
                      'assets/icons/compass.svg',
                      height: 22,
                      width: 22,
                      color: PRIMARY_COLOR,
                    ),
                    onTap: openContainer,
                  );
                },
                openBuilder:
                    (BuildContext context, VoidCallback closedContainer) {
                  return QiblaScreen(onBackArrowPressed: closedContainer);
                },
              ),
              OpenContainer(
                closedElevation: 0,
                transitionType: ContainerTransitionType.fadeThrough,
                closedBuilder:
                    (BuildContext context, VoidCallback openContainer) {
                  return TopSummaryMenu(
                    text: "Al-Qur'an",
                    icon: Icon(
                      Icons.menu_book_rounded,
                      color: PRIMARY_COLOR,
                    ),
                    onTap: openContainer,
                  );
                },
                openBuilder:
                    (BuildContext context, VoidCallback closedContainer) {
                  return QuranScreen(onBackPressed: closedContainer);
                },
              ),
              TopSummaryMenu(
                text: "Murotal",
                icon: Icon(
                  Icons.surround_sound,
                  color: PRIMARY_COLOR,
                ),
                onTap: () {
                  SnackBarHelper.displaySnackBar(
                      context, "Fitur ini sedang dalam pengembangan");
                },
              ),
              TopSummaryMenu(
                text: "Berita",
                icon: Icon(
                  Icons.article_outlined,
                  color: PRIMARY_COLOR,
                ),
                onTap: () {
                  SnackBarHelper.displaySnackBar(
                      context, "Fitur ini sedang dalam pengembangan");
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
