import 'package:equatable/equatable.dart';

class VerseInterpretation extends Equatable{
  final int id;
  final int surahNumber;
  final int number;
  final String interpretation;

  const VerseInterpretation({
    required this.id,
    required this.surahNumber,
    required this.number,
    required this.interpretation
  });

  @override
  List<Object?> get props => [
    id,
    surahNumber,
    number,
    interpretation,
  ];
}