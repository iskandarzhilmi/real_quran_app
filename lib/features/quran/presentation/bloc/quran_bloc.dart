import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_quran_app/features/quran/data/data_sources/quran_remote_data_source.dart';

import '../../data/models/quran_model.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranStateModel> {
  QuranBloc() : super(QuranStateModel.initial()) {
    on<QuranPagePicked>(_onQuranPagePicked);
  }

  Future<void> _onQuranPagePicked(QuranPagePicked event, Emitter emit) async {
    try {
      emit(
        state.copyWith(
          quranState: QuranLoading(),
        ),
      );
      QuranModel loadedQuran =
          await QuranRemoteDataSource().getQuranPageFromApi(event.pageNumber);

      emit(
        state.copyWith(
          quranState: QuranLoaded(),
          quran: loadedQuran,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          quranState: QuranError(errorMessage: e.toString()),
        ),
      );
    }
  }
}
