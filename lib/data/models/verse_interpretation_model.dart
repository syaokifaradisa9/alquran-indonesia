import 'package:alquran_indonesia/domain/entities/verse_interpretation.dart';
import 'package:equatable/equatable.dart';

class VerseInterpretationModel extends Equatable{
  final int id;
  final int surahNumber;
  final int verseNumber;
  final String interpretation;

  const VerseInterpretationModel({
    required this.id,
    required this.surahNumber,
    required this.verseNumber,
    required this.interpretation
  });

  factory VerseInterpretationModel.fromJson(Map<String, dynamic> json) {
    return VerseInterpretationModel(
      id: json['id'],
      surahNumber: json['surah'],
      verseNumber: json['ayat'],
      interpretation: json['tafsir'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "surah" : surahNumber,
    "ayat" : verseNumber,
    "tafsir" : interpretation
  };

  VerseInterpretation toEntity() => VerseInterpretation(
    id: id,
    surahNumber: surahNumber,
    verseNumber: verseNumber,
    interpretation: interpretation,
  );

  @override
  List<Object?> get props => [
    id,
    surahNumber,
    verseNumber,
    interpretation,
  ];
}