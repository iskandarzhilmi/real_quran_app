import 'dart:convert';

class QuranModel {
  QuranModel({required this.pageNumber, required this.pageText});

  final int pageNumber;
  final String pageText;

  factory QuranModel.fromStringJsonAndPageNumber(
      String stringJson, int pageNumber) {
    var json = jsonDecode(stringJson);
    var data = json['result'];
    String pageText = '';
    for (int lineIndex = 0; lineIndex < data.length; lineIndex++) {
      String lineText = '';
      var lineType = data[lineIndex]['detail']['line_type'];
      if (lineType == 'start_sura') {
        lineText = data[lineIndex]['detail']['name'];
      } else if (lineType == 'besmellah') {
        lineText = 'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
      } else {
        lineText = '';
        for (int kalimahIndex = 0;
            kalimahIndex < (data[lineIndex]['word']).length;
            kalimahIndex++,) {
          var wordMap = data[lineIndex]['word'][kalimahIndex];
          if (wordMap['char_type'] == 'end') {
            lineText = lineText + ' ${wordMap['aya']} ';
          } else {
            lineText = lineText + ' ${wordMap['text']}';
          }
        }
      }
      if (lineIndex != 0) {
        pageText = pageText + '\n$lineText';
      } else {
        pageText = pageText + lineText;
      }
    }

    print('pageText: $pageText');
    return QuranModel(
      pageText: pageText,
      pageNumber: pageNumber,
    );
  }
}
