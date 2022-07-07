import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/quran_model.dart';
import '../repositories/quran_repositories.dart';

class GetQuran {
  final QuranRepository quranRepository;

  GetQuran({required this.quranRepository});

  Future<Either<Failure, QuranModel>> execute(int pageNumber) async {
    return await quranRepository.getQuran(pageNumber);
  }
}
