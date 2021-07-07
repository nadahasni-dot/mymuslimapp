import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';
import 'package:my_muslim_app/model/surah_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/network/api_manager.dart';
import 'package:my_muslim_app/screens/quran/components/ayat_item.dart';
import 'package:my_muslim_app/screens/quran/components/surah_detail_item.dart';
import 'package:quran/quran.dart' as quran;

class QuranSuratDetailScreen extends StatefulWidget {
  final int surahId;
  const QuranSuratDetailScreen({Key? key, required this.surahId})
      : super(key: key);

  @override
  _QuranSuratDetailScreenState createState() => _QuranSuratDetailScreenState();
}

class _QuranSuratDetailScreenState extends State<QuranSuratDetailScreen> {
  int? _selectedVerse;
  int? _playedVerse;
  String? _verseUriSound;

  Future<SurahItemModel?>? _surahItemModel;

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
    log('surah id initstate: ${widget.surahId}');
    _surahItemModel = ApiManager().getSurahDetail(widget.surahId);

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
    String surahName = quran.getSurahName(widget.surahId);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          surahName,
          style: TextStyle(color: TEXT_COLOR_DARK, fontWeight: FontWeight.w600),
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: PRIMARY_COLOR),
      ),
      body: FutureBuilder<SurahItemModel?>(
        future: _surahItemModel,
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
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: SurahDetailItem(surahItemModel: snapshot.data!),
                  );
                }

                return AyatItem(
                  index: index,
                  verse: snapshot.data!.data.verses[index - 1],
                  onBookmark: (selectedIndex) {
                    setState(() {
                      _selectedVerse = selectedIndex - 1;
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
                        _playedVerse = selectedIndex - 1;
                        _verseUriSound = soundUrl;
                        _playAudioFromUrl(_verseUriSound!);
                      }
                    });
                  },
                  isBookmarked: _selectedVerse == index - 1 ? true : false,
                  isPlayed: _playedVerse == index - 1 ? true : false,
                );
              },
              itemCount: snapshot.data!.data.numberOfVerses + 1,
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
                          _surahItemModel =
                              ApiManager().getSurahDetail(widget.surahId);
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
