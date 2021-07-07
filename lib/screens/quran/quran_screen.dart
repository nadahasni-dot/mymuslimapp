import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/screens/quran/quran_juz_detail_screen.dart';
import 'package:my_muslim_app/screens/quran/quran_surat_detail_screen.dart';
import 'package:quran/quran.dart' as quran;

class QuranScreen extends StatelessWidget {
  final Function onBackPressed;
  const QuranScreen({Key? key, required this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          elevation: 1,
          actions: [
            IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {},
            ),
          ],
          centerTitle: true,
          title: Text(
            "Al-Qur'an",
            style:
                TextStyle(color: TEXT_COLOR_DARK, fontWeight: FontWeight.w600),
          ),
          backwardsCompatibility: false,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: PRIMARY_COLOR),
          bottom: TabBar(
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            labelColor: PRIMARY_COLOR,
            tabs: [
              Tab(text: "Surat"),
              Tab(text: "Juz"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              itemCount: quran.getTotalSurahCount(),
              itemBuilder: (BuildContext context, int index) {
                return OpenContainer(
                  closedElevation: 0,
                  closedColor: Colors.grey.shade50,
                  closedBuilder: (_, openContainer) {
                    return ListTile(
                      onTap: openContainer,
                      title: Text(quran.getSurahName(index + 1)),
                      subtitle: Text(quran.getSurahNameEnglish(index + 1)),
                      leading: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: TEXT_COLOR_DARK,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                  openBuilder: (_, closeContainer) {
                    return QuranSuratDetailScreen(surahId: index + 1);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                );
              },
            ),
            ListView.separated(
              itemCount: quran.getTotalJuzCount(),
              itemBuilder: (BuildContext context, int index) {
                String surahName = "";

                int i = 1;
                quran.getSurahAndVersesFromJuz(index + 1).forEach((key, value) {
                  if (i <= 1) {
                    surahName = quran.getSurahName(key);
                  } else {
                    surahName += ", ${quran.getSurahName(key)}";
                  }

                  i++;
                });

                return OpenContainer(
                  closedColor: Colors.grey.shade50,
                  closedElevation: 0,
                  closedBuilder: (context, openContainer) {
                    return ListTile(
                      title: Text("Juz ${index + 1}"),
                      subtitle: Text(surahName),
                      leading: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: TEXT_COLOR_DARK,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                  openBuilder: (context, closeContainer) {
                    return QuranJuzDetailScreen(
                      juzNumber: index + 1,
                      mapVerse: quran.getSurahAndVersesFromJuz(index + 1),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
