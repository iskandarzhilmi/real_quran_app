part of 'quran_bloc.dart';

class QuranStateModel extends Equatable {
  final QuranModel? quran;
  final int? pageNumber;
  final QuranState quranState;

  const QuranStateModel({
    this.quran,
    required this.quranState,
    this.pageNumber,
  });

  @override
  List<Object?> get props => [quran, quranState];

  factory QuranStateModel.initial() {
    return QuranStateModel(
      quran: QuranModel(
        pageNumber: 0,
        pageText: '',
      ),
      quranState: QuranInitial(),
    );
  }

  QuranStateModel copyWith({
    QuranModel? quran,
    QuranState? quranState,
    int? pageNumber,
  }) {
    return QuranStateModel(
      quran: quran ?? this.quran,
      quranState: quranState ?? this.quranState,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}

@immutable
abstract class QuranState {}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {}

class QuranError extends QuranState {
  final String errorMessage;

  QuranError({required this.errorMessage});
}
