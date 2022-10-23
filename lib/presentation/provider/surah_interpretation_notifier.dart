import 'package:alquran_indonesia/common/state_enum.dart';
import 'package:alquran_indonesia/domain/entities/surah_interpretation.dart';
import 'package:alquran_indonesia/domain/usecases/get_surah_interpretation.dart';
import 'package:flutter/material.dart';

class SurahInterpretationNotifier extends ChangeNotifier {
  late SurahInterpretation surahInterpretation;
  final GetSurahInterpretation getSurahInterpretation;

  SurahInterpretationNotifier({required this.getSurahInterpretation});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  late int interpretationIndex;

  Future<void> fetchSurahInterpretation(int number) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getSurahInterpretation.execute(number);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        notifyListeners();
      },
      (surahInterpretationData) {
        surahInterpretation = surahInterpretationData;
        _state = RequestState.Loaded;
        interpretationIndex = 0;
        notifyListeners();
      },
    );
  }

  Future<void> nextInterpretation() async {
    if (interpretationIndex < surahInterpretation.verseInterpretations.length - 1) {
      interpretationIndex++;
      notifyListeners();
    }
  }

  Future<void> previousInterpretation() async {
    if (interpretationIndex > 0) {
      interpretationIndex--;
      notifyListeners();
    }
  }
}