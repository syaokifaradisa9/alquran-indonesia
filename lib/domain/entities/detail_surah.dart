import 'package:alquran_indonesia/domain/entities/surah.dart';
import 'package:alquran_indonesia/domain/entities/verse.dart';
import 'package:equatable/equatable.dart';

class DetailSurah extends Equatable{
  final Surah surah;
  final List<Verse> verses;
  final Surah nextSurah;
  final Surah previousSurah;

  const DetailSurah({
    required this.surah,
    required this.verses,
    required this.nextSurah,
    required this.previousSurah
  });

  @override
  List<Object?> get props => [
    surah,
    verses,
    nextSurah,
    previousSurah,
  ];
}