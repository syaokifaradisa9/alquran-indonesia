import 'package:alquran_indonesia/common/state_enum.dart';
import 'package:alquran_indonesia/domain/entities/detail_surah.dart';
import 'package:alquran_indonesia/domain/usecases/get_detail_surah.dart';
import 'package:flutter/material.dart';

class SurahDetailNotifier extends ChangeNotifier {
  late DetailSurah detailSurah;
  final GetDetailSurah getDetailSurah;

  SurahDetailNotifier({required this.getDetailSurah});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> fetchDetailSurah(int number) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getDetailSurah.execute(number);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        notifyListeners();
      },
      (detailSurahData) {
        detailSurah = detailSurahData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}