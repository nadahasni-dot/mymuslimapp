import 'package:flutter/material.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/screens/main/page/beranda/components/article_item.dart';
import 'package:my_muslim_app/screens/main/page/beranda/components/top_beranda.dart';
import 'package:my_muslim_app/screens/main/page/beranda/components/top_summary.dart';

import 'components/last_read_quran.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    image: DecorationImage(
                        image:
                            ExactAssetImage('assets/images/mosque-vector.png'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16),
                        TopBeranda(),
                        SizedBox(height: 24),
                        TopSummary(),
                        SizedBox(height: 24),
                        LastReadQuran(
                          onTap: () {
                            SnackBarHelper.displaySnackBar(
                                context, "Fitur ini sedang dalam pengembangan");
                          },
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Artikel Terbaru",
                              style: TextStyle(
                                color: TEXT_COLOR_DARK,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                SnackBarHelper.displaySnackBar(context,
                                    "Fitur ini sedang dalam pengembangan");
                              },
                              child: Text(
                                "Lihat Semua",
                                style: TextStyle(color: PRIMARY_COLOR),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        ArticleItem(
                          onTap: () {
                            SnackBarHelper.displaySnackBar(
                                context, "Fitur ini sedang dalam pengembangan");
                          },
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
