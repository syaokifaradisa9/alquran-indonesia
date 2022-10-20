import 'package:alquran_indonesia/domain/entities/surah.dart';
import 'package:alquran_indonesia/domain/entities/verse_interpretation.dart';
import 'package:equatable/equatable.dart';

class SurahInterpretation extends Equatable{
  final Surah surah;
  final List<VerseInterpretation> verseInterpretations;
  final Surah nextSurah;
  final Surah previousSurah;

  const SurahInterpretation({
    required this.surah,
    required this.verseInterpretations,
    required this.nextSurah,
    required this.previousSurah
  });

  @override
  List<Object?> get props => [
    surah,
    verseInterpretations,
    nextSurah,
    previousSurah,
  ];
}