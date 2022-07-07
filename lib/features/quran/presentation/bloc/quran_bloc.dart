import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_quran_app/features/quran/data/data_sources/quran_remote_data_source.dart';
import 'package:real_quran_app/features/quran/data/repositories/quran_repository_implement.dart';
import 'package:real_quran_app/features/quran/domain/repositories/quran_repositories.dart';
import 'package:real_quran_app/features/quran/domain/usecases/get_quran.dart';

import '../../data/models/quran_model.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranStateModel> {
  QuranBloc() : super(QuranStateModel.initial()) {
    on<QuranPagePicked>(_onQuranPagePicked);
  }

  Future<void> _onQuranPagePicked(QuranPagePicked event, Emitter emit) async {
    try {
      QuranRepositoryImplement quranRepository = QuranRepositoryImplement(
        quranRemoteDataSource: QuranRemoteDataSource(),
      );

      GetQuran getQuran = GetQuran(quranRepository: quranRepository);

      emit(
        state.copyWith(
          quranState: QuranLoading(),
        ),
      );

      final result = await getQuran.execute(event.pageNumber);
      result.fold((failure) {
        emit(
          state.copyWith(
            quranState: QuranError(
              errorMessage: failure.message,
            ),
          ),
        );
      }, (quran) {
        emit(
          state.copyWith(
            quran: quran,
            quranState: QuranLoaded(),
          ),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
          quranState: QuranError(errorMessage: e.toString()),
        ),
      );
    }
  }
}
