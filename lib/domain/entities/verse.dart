import 'package:equatable/equatable.dart';

class Verse extends Equatable{
  final int id;
  final int surahNumber;
  final int number;
  final String arabicText;
  final String indonesianText;
  final String indonesianMean;

  const Verse({
    required this.id,
    required this.surahNumber,
    required this.number,
    required this.arabicText,
    required this.indonesianText,
    required this.indonesianMean
  });

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