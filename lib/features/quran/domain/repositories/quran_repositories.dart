import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/quran_model.dart';

abstract class QuranRepository {
  Future<Either<Failure,QuranModel>> getQuran(int pageNumber);
}