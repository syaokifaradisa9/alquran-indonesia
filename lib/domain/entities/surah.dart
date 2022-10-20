import 'package:equatable/equatable.dart';

class Surah extends Equatable{
  final int number;
  final String arabicText;
  final String latinName;
  final int verseTotal;
  final String indonesianMean;
  final String releasePlace;
  final String description;
  final String audioUrlPath;

  const Surah({
    required this.number,
    required this.arabicText,
    required this.latinName,
    required this.verseTotal,
    required this.indonesianMean,
    required this.releasePlace,
    required this.description,
    required this.audioUrlPath
  });

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