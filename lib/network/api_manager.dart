import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:my_muslim_app/model/surah_item_model.dart';
import 'package:my_muslim_app/model/surah_juz_item.dart';
import 'api_endpoint.dart';

class ApiManager {
  Future<SurahItemModel?> getSurahDetail(int number) async {
    log('fetching data surat ${ApiEndpoint.BASE_URL}/surah/$number');
    var client = http.Client();
    var url = Uri.parse("${ApiEndpoint.BASE_URL}/surah/$number");
    SurahItemModel? surahItemModel;

    try {
      var response = await client.get(url).timeout(Duration(seconds: 10));
      // log('response data surat ${response.body.toString()}');
      log('response status code: ${response.statusCode.toString()}');

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonResponse = jsonDecode(jsonString);

        surahItemModel = SurahItemModel.fromJson(jsonResponse);
      }

      if (response.statusCode == 404) {
        log('error: fetch ${response.statusCode}');
      }

      if (response.statusCode == 500) {
        log('error: fetch ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      log('error: fetch ${e.toString()}');
      throw Exception('Connection time out. Harap coba lagi.');
    } catch (e) {
      log('error: fetch ${e.toString()}');
      throw Exception('Gagal mengambil detail surah. Harap coba lagi.');
    }

    return surahItemModel;
  }

  Future<List<VerseJuzItemModel>> getSurahInJuzDetail(
      Map<int, List<int>> mapVerse) async {
    var client = http.Client();
    var responses;
    List<Uri> listUriSurah = [];
    List<VerseJuzItemModel> verses = [];

    mapVerse.forEach((key, value) {
      listUriSurah.add(Uri.parse("${ApiEndpoint.BASE_URL}/surah/$key"));
    });

    try {
      responses = await Future.wait(
          listUriSurah.map((url) => client.get(url)).toList());
    } on TimeoutException catch (e) {
      log('error: fetch ${e.toString()}');
      throw Exception('Connection time out. Harap coba lagi.');
    } catch (e) {
      log('error: fetch ${e.toString()}');
      throw Exception('Gagal mengambil detail surah. Harap coba lagi.');
    }

    int i = 0;
    mapVerse.forEach((key, value) async {
      // log("Response indeks ke [$i] ===========");
      var response = responses[i];

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonResponse = jsonDecode(jsonString);

        SurahItemModel.fromJson(jsonResponse).data.verses.forEach((verse) {
          if (verse.number.inSurah >= value[0] &&
              verse.number.inSurah <= value[1]) {
            //? add tiap ayat yang sesuai syarat
            verses.add(VerseJuzItemModel(
              surahNumber: key,
              verse: verse,
            ));

            log("surah-ayat: $key ${verse.number.inSurah.toString()}");
          }
        });
      }
      i++;
    });

    // log("length: ${verses.length}");
    // log("surah: ${verses[7].data.name.translation.id}, ayat: ${verses[7].data.verses[7].number.inSurah}");
    return verses;
  }
}
