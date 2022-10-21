import 'package:alquran_indonesia/common/state_enum.dart';
import 'package:alquran_indonesia/domain/entities/surah.dart';
import 'package:alquran_indonesia/domain/usecases/get_all_surah.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SurahListNotifier extends ChangeNotifier{
  final GetAllSurah getAllSurah;
  final AudioPlayer player;

  SurahListNotifier({required this.getAllSurah, required this.player});

  // Menyimpan Data Surah
  var _surahListMaster = <Surah>[];
  var _surahList = <Surah>[];
  List<Surah> get surahList => _surahList;

  // Penyimpanan State
  RequestState _surahListState = RequestState.Empty;
  RequestState get surahListState => _surahListState;
  AudioPlayerState _playerState = AudioPlayerState.Empty;
  AudioPlayerState get playerState => _playerState;

  // Menyimpan pesan error
  String _message = '';
  String get message => _message;

  // Penyimpanan Surah yang sedang diputar
  int _playedSurahNumber = 0;
  int get playedSurahNumber => _playedSurahNumber;

  Future<void> fetchSurahList() async {
    _surahListState = RequestState.Loading;
    notifyListeners();

    final result = await getAllSurah.execute();
    result.fold(
      (failure) {
        _surahListState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (surahListData) {
        _surahListState = RequestState.Loaded;
        _surahList = surahListData;
        _surahListMaster = surahListData;
        notifyListeners();
      },
    );
  }

  Future<void> searchSurah(String name) async{
    _surahListState = RequestState.Loading;
    _surahList = name.isEmpty ? _surahListMaster : _surahListMaster.where(
      (element) => element.latinName.toLowerCase().contains(name.toLowerCase())
    ).toList();
    _surahListState = RequestState.Loaded;
    notifyListeners();
  }

  Future<void> playSurahByNumber(int number) async{
    int lastPlayedSurah = _playedSurahNumber;

    _playedSurahNumber = number;
    notifyListeners();

    if(lastPlayedSurah == number){
      if(player.playing){
        player.stop();
        _playerState = AudioPlayerState.Paused;
      } else {
        player.play();
        _playerState = AudioPlayerState.Playing;
      }
    }else{
      player.setUrl(_surahListMaster[number - 1].audioUrlPath);
      player.play();
      _playerState = AudioPlayerState.Playing;
    }

    notifyListeners();
  }
}