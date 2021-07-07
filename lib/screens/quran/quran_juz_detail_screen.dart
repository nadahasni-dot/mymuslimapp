import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/model/surah_juz_item.dart';
import 'package:my_muslim_app/network/api_manager.dart';
import 'package:my_muslim_app/screens/quran/components/ayat_item.dart';

class QuranJuzDetailScreen extends StatefulWidget {
  final int juzNumber;
  final Map<int, List<int>> mapVerse;

  const QuranJuzDetailScreen({
    Key? key,
    required this.juzNumber,
    required this.mapVerse,
  }) : super(key: key);

  @override
  _QuranJuzDetailScreenState createState() => _QuranJuzDetailScreenState();
}

class _QuranJuzDetailScreenState extends State<QuranJuzDetailScreen> {
  int? _selectedVerse;
  int? _playedVerse;
  String? _verseUriSound;

  Future<List<VerseJuzItemModel>>? _listVerses;

  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.STOPPED;

  void _playAudioFromUrl(String url) async {
    try {
      await audioPlayer.play(url);
    } catch (e) {
      setState(() {
        _playedVerse = null;
      });
      SnackBarHelper.displaySnackBar(
          context, "Gagal memutar ayat, harap cek koneksi anda.");
    }

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.COMPLETED) {
        log(state.toString());

        setState(() {
          _playedVerse = null;
        });
      }
    });

    audioPlayer.onPlayerError.listen((error) {
      setState(() {
        _playedVerse = null;
      });
      SnackBarHelper.displaySnackBar(
          context, "Gagal memutar ayat, harap cek koneksi anda.");
    });
  }

  void _stopPlayer() async {
    await audioPlayer.pause();
  }

  @override
  void initState() {
    log('surah id initstate: ${widget.mapVerse.toString()}');
    _listVerses = ApiManager().getSurahInJuzDetail(widget.mapVerse);

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Juz ${widget.juzNumber}",
          style: TextStyle(color: TEXT_COLOR_DARK, fontWeight: FontWeight.w600),
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: PRIMARY_COLOR),
      ),
      body: FutureBuilder<List<VerseJuzItemModel>>(
        future: _listVerses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                );
              },
              itemBuilder: (context, index) {
                return AyatItem(
                  index: index,
                  surahNumber: snapshot.data![index].surahNumber,
                  verse: snapshot.data![index].verse,
                  onBookmark: (selectedIndex) {
                    setState(() {
                      _selectedVerse = selectedIndex;
                    });
                  },
                  onPlayed: (selectedIndex, soundUrl, isPlayed) {
                    setState(() {
                      if (isPlayed && selectedIndex == index) {
                        _playedVerse = null;
                        _stopPlayer();
                        log("stoping audio: $soundUrl");
                      } else {
                        log("playing audio: $soundUrl");
                        _playedVerse = selectedIndex;
                        _verseUriSound = soundUrl;
                        _playAudioFromUrl(_verseUriSound!);
                      }
                    });
                  },
                  isBookmarked: _selectedVerse == index ? true : false,
                  isPlayed: _playedVerse == index ? true : false,
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            log("snapshot error: ${snapshot.error}");
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(PRIMARY_COLOR),
                      ),
                      onPressed: () {
                        setState(() {
                          _listVerses =
                              ApiManager().getSurahInJuzDetail(widget.mapVerse);
                        });
                      },
                      child: Text('Coba Lagi'),
                    )
                  ],
                ),
              ),
            );
          } else {
            log("snapshot: ${snapshot.connectionState.toString()}");
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
