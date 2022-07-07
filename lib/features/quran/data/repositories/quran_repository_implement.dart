import 'package:dartz/dartz.dart';
import 'package:real_quran_app/features/quran/data/data_sources/quran_remote_data_source.dart';
import 'package:real_quran_app/features/quran/domain/repositories/quran_repositories.dart';

import '../../../../core/errors/failure.dart';
import '../models/quran_model.dart';

class QuranRepositoryImplement implements QuranRepository {
  final QuranRemoteDataSource quranRemoteDataSource;
  QuranRepositoryImplement({required this.quranRemoteDataSource});

  @override
  Future<Either<Failure, QuranModel>> getQuran(int pageNumber) async {
    try {
      final quran = await quranRemoteDataSource.getQuranPageFromApi(pageNumber);
      return Right(quran);
    } on ServerFailure {
      return const Left(
        ServerFailure(
          message: 'Server failure occured.',
        ),
      );
    } on ConnectionFailure {
      return const Left(
        ConnectionFailure(
          message: 'Connection failure occured.',
        ),
      );
    } on DatabaseFailure {
      return const Left(
        DatabaseFailure(
          message: 'Database failure occured.',
        ),
      );
    }
  }
}
