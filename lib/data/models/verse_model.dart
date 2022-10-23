import 'package:alquran_indonesia/domain/entities/verse.dart';
import 'package:equatable/equatable.dart';

class VerseModel extends Equatable{
  final int id;
  final int surahNumber;
  final int number;
  final String arabicText;
  final String indonesianText;
  final String indonesianMean;

  const VerseModel({
    required this.id,
    required this.surahNumber,
    required this.number,
    required this.arabicText,
    required this.indonesianText,
    required this.indonesianMean
  });

  factory VerseModel.fromJson(Map<String, dynamic> json){
    return VerseModel(
      id: json["id"],
      surahNumber: json["surah"],
      number: json["nomor"],
      arabicText: json["ar"],
      indonesianText: json["tr"],
      indonesianMean: json["idn"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "surah" : surahNumber,
    "nomor" : number,
    "ar" : arabicText,
    "tr" : indonesianText,
    "idn" : indonesianMean
  };

  Verse toEntity() => Verse(
    id: id,
    surahNumber: surahNumber,
    number: number,
    arabicText: arabicText,
    indonesianText: indonesianText,
    indonesianMean: indonesianMean,
  );

  @override
  List<Object?> get props => [
    id,
    surahNumber,
    number,
    arabicText,
    indonesianText,
    indonesianMean,
  ];
}