import 'package:shared_preferences/shared_preferences.dart';

import '../models/quran_model.dart';

class QuranLocalDataSources {
  QuranLocalDataSources();

  Future<void> cacheQuranPage(QuranModel quran) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
        'quran_page_${quran.pageNumber}',
        quran.pageText,
      );
    } catch (e) {
      throw Exception();
    }
  }
}
