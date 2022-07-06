import 'package:dio/dio.dart';

import '../models/quran_model.dart';

class QuranRemoteDataSource {
  QuranRemoteDataSource();

  Future<QuranModel> getQuranPage(int pageNumber) async {
    Response response = await Dio()
        .get('https://salamquran.com/en/api/v6/page/wbw?index=$pageNumber');

    if (response.statusCode == 200) {
      return QuranModel.fromStringJsonAndPageNumber(response.data, pageNumber);
    } else {
      throw Exception('Failed to load Quran page');
    }
  }
}
