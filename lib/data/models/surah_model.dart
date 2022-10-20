import 'package:alquran_indonesia/domain/entities/surah.dart';
import 'package:equatable/equatable.dart';

class SurahModel extends Equatable{
  final int number;
  final String arabicText;
  final String latinName;
  final int verseTotal;
  final String indonesianMean;
  final String releasePlace;
  final String description;
  final String audioUrlPath;

  const SurahModel({
    required this.number,
    required this.arabicText,
    required this.latinName,
    required this.verseTotal,
    required this.indonesianMean,
    required this.releasePlace,
    required this.description,
    required this.audioUrlPath
  });

  factory SurahModel.fromJson(Map<String, dynamic> json){
    return SurahModel(
      number: json['nomor'],
      arabicText: json['nama'],
      latinName: json['nama_latin'],
      verseTotal: json['jumlah_ayat'],
      indonesianMean: json['arti'],
      releasePlace: json['tempat_turun'],
      description: json['deskripsi'],
      audioUrlPath: json['audio'],
    );
  }

  Map<String, dynamic> toJson() => {
    "nomor" : number,
    "nama" : arabicText,
    "nama_latin" : latinName,
    "jumlah_ayat" : verseTotal,
    "tempat_turun" : releasePlace,
    "arti" : indonesianMean,
    "deskripsi" : description,
    "audio" : audioUrlPath
  };

  Surah toEntity() => Surah(
      number: number,
      arabicText: arabicText,
      latinName: latinName,
      verseTotal: verseTotal,
      indonesianMean: indonesianMean,
      releasePlace: releasePlace,
      description: description,
      audioUrlPath: audioUrlPath
  );

  @override
  List<Object?> get props => [
    number,
    arabicText,
    latinName,
    verseTotal,
    indonesianMean,
    releasePlace,
    description,
    audioUrlPath,
  ];
}