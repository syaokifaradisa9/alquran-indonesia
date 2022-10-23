import 'package:alquran_indonesia/data/models/surah_model.dart';
import 'package:alquran_indonesia/data/models/verse_model.dart';
import 'package:alquran_indonesia/domain/entities/detail_surah.dart';
import 'package:equatable/equatable.dart';

class DetailSurahModel extends Equatable{
  final SurahModel surah;
  final List<VerseModel> verses;
  final SurahModel nextSurah;
  final SurahModel previousSurah;

  const DetailSurahModel({
    required this.surah,
    required this.verses,
    required this.nextSurah,
    required this.previousSurah
  });

  factory DetailSurahModel.fromJson(Map<String, dynamic> json){
    return DetailSurahModel(
      surah: SurahModel.fromJson(json),
      verses: List<VerseModel>.from(json['ayat'].map((x) => VerseModel.fromJson(x))),
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
    "ayat" : List<dynamic>.from(verses.map((x) => x.toJson())),
    "surat_selanjutnya" : nextSurah.toJson(),
    "surat_sebelumnya" : previousSurah.toJson()
  };

  DetailSurah toEntity() => DetailSurah(
    surah: surah.toEntity(),
    verses: verses.map((e) => e.toEntity()).toList(),
    nextSurah: nextSurah.toEntity(),
    previousSurah: previousSurah.toEntity()
  );

  @override
  List<Object?> get props => [
    surah,
    verses,
    nextSurah,
    previousSurah,
  ];
}