import 'package:flutter/material.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/model/surah_item_model.dart';

class SurahDetailItem extends StatefulWidget {
  final SurahItemModel surahItemModel;

  SurahDetailItem({Key? key, required this.surahItemModel}) : super(key: key);

  @override
  _SurahDetailItemState createState() => _SurahDetailItemState();
}

class _SurahDetailItemState extends State<SurahDetailItem> {
  bool _isDescriptionExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          gradient: PRIMARY_GRADIENT_COLOR_BOTTOM_TO_TOP,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 14,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 4),
            Text(
              widget.surahItemModel.data.name.short,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'PDMS-Saleem',
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.surahItemModel.data.name.transliteration.id,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${widget.surahItemModel.data.name.translation.id} / ${widget.surahItemModel.data.name.translation.en}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "(${widget.surahItemModel.data.revelation.id})",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            TextButton(
              onPressed: () {
                setState(() {
                  _isDescriptionExpanded = !_isDescriptionExpanded;
                });
              },
              child: Text(
                _isDescriptionExpanded
                    ? 'Sembunyikan Deskripsi'
                    : 'Lihat Deskripsi',
                style: TextStyle(color: Colors.white),
              ),
            ),
            _isDescriptionExpanded
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      widget.surahItemModel.data.tafsir.id,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : SizedBox(height: 0),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
