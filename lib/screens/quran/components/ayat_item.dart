import 'package:flutter/material.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/model/surah_item_model.dart';
import 'package:quran/quran.dart' as quran;

class AyatItem extends StatefulWidget {
  final int? surahNumber;
  final int index;
  final Verse verse;
  final Function(int index) onBookmark;
  final Function(int index, String url, bool isPlayed) onPlayed;
  final bool isBookmarked;
  final bool isPlayed;

  AyatItem({
    Key? key,
    this.surahNumber,
    required this.index,
    required this.verse,
    required this.onBookmark,
    required this.isBookmarked,
    required this.onPlayed,
    required this.isPlayed,
  }) : super(key: key);

  @override
  _AyatItemState createState() => _AyatItemState();
}

class _AyatItemState extends State<AyatItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: widget.isBookmarked ? Colors.yellow.shade50 : Colors.grey.shade100,
      duration: Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: widget.isBookmarked
                        ? Colors.yellow.shade100
                        : Colors.grey.shade200,
                    blurRadius: 8,
                  ),
                ],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: TEXT_COLOR_DARK,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.verse.number.inSurah}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  widget.surahNumber != null
                      ? Text(quran.getSurahName(widget.surahNumber!))
                      : SizedBox(width: 0),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      widget.onPlayed(
                        widget.index,
                        widget.verse.audio.primary,
                        widget.isPlayed,
                      );
                    },
                    icon: Icon(
                      widget.isPlayed
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                    ),
                    color: widget.isPlayed ? SECONDARY_COLOR : TEXT_COLOR_LIGHT,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      widget.onBookmark(widget.index);
                    },
                    icon: Icon(widget.isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded),
                    color: widget.isBookmarked
                        ? SECONDARY_COLOR
                        : TEXT_COLOR_LIGHT,
                  ),
                  SizedBox(width: 20)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding:
                  EdgeInsets.only(left: 50, right: 20, top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.verse.text.arab +
                          quran.getVerseEndSymbol(widget.verse.number.inSurah),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: TEXT_COLOR_DARK,
                        fontSize: 30,
                        height: 1.5,
                        fontFamily: 'PDMS-Saleem',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              widget.verse.text.transliteration.en,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: TEXT_COLOR_DARK, fontWeight: FontWeight.w600),
            ),
          ),
          widget.isBookmarked
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Ditandai terakhir dibaca',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                )
              : SizedBox(),
          _isExpanded
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        widget.verse.tafsir.id.short,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              : SizedBox(height: 0),
        ],
      ),
    );
  }
}
