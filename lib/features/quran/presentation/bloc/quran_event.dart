part of 'quran_bloc.dart';

@immutable
abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object?> get props => [];
}

class QuranPagePicked extends QuranEvent {
  QuranPagePicked({required this.pageNumber});
  int pageNumber;

  @override
  List<Object?> get props => [pageNumber];
}
