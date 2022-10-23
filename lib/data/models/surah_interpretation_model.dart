import 'package:alquran_indonesia/data/models/surah_model.dart';
import 'package:alquran_indonesia/data/models/verse_interpretation_model.dart';
import 'package:alquran_indonesia/domain/entities/surah_interpretation.dart';
import 'package:equatable/equatable.dart';

class SurahInterpretationModel extends Equatable{
  final SurahModel surah;
  final List<VerseInterpretationModel> verseInterpretations;
  final SurahModel nextSurah;
  final SurahModel previousSurah;

  const SurahInterpretationModel({
    required this.surah,
    required this.verseInterpretations,
    required this.nextSurah,
    required this.previousSurah
  });

  factory SurahInterpretationModel.fromJson(Map<String, dynamic> json) {
    return SurahInterpretationModel(
      surah: SurahModel.fromJson(json),
      verseInterpretations: List<VerseInterpretationModel>.from(
        json['tafsir'].map((x) => VerseInterpretationModel.fromJson(x))
      ),
      nextSurah: json['nomor'] != 114 ? SurahModel.fromJson(json['surat_selanjutnya']) : SurahModel.fromJson(json),
      previousSurah: json['nomor'] != 1 ? SurahModel.fromJson(json['surat_sebelumnya']) : SurahModel.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => {
    "nomor" : surah.number,
    "nama" : surah.arabicText,
    "nama_latin" : surah.latinName,
    "jumlah_ayat" : surah.verseTotal,
    "tempat_turun" : surah.releasePlace,
    "arti" : surah.indonesianMean,
    "deskripsi" : surah.description,
    "audio" : surah.audioUrlPath,
    "tafsir" : List<dynamic>.from(verseInterpretations.map((x) => x.toJson())),
    "surat_selanjutnya" : nextSurah.toJson(),
    "surat_sebelumnya" : previousSurah.toJson()
  };

  SurahInterpretation toEntity() => SurahInterpretation(
    surah: surah.toEntity(),
    verseInterpretations: verseInterpretations.map((e) => e.toEntity()).toList(),
    nextSurah: nextSurah.toEntity(),
    previousSurah: previousSurah.toEntity()
  );

  @override
  List<Object?> get props => [
    surah,
    verseInterpretations,
    nextSurah,
    previousSurah,
  ];
}