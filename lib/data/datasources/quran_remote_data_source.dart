import 'dart:convert';
import 'package:alquran_indonesia/common/exception.dart';
import 'package:alquran_indonesia/data/models/detail_surah_model.dart';
import 'package:alquran_indonesia/data/models/surah_interpretation_model.dart';
import 'package:alquran_indonesia/data/models/surah_model.dart';
import 'package:http/http.dart' as http;

abstract class QuranRemoteDataSource{
  Future<List<SurahModel>> getAllSurah();
  Future<DetailSurahModel> getDetailSurah(int number);
  Future<SurahInterpretationModel> getSurahInterpretation(int number);
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource{
  final http.Client client;
  final BASE_URL = "https://equran.id/api";

  QuranRemoteDataSourceImpl({ required this.client });

  @override
  Future<List<SurahModel>> getAllSurah() async {
    final response = await client.get(Uri.parse('$BASE_URL/surat'));
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body) as List;
      return List<SurahModel>.from(jsonData.map((x) => SurahModel.fromJson(x)));
    }else{
      throw ServerException();
    }
  }

  @override
  Future<DetailSurahModel> getDetailSurah(int number) async {
    final response = await client.get(Uri.parse('$BASE_URL/surat/$number'));
    if(response.statusCode == 200) {
      return DetailSurahModel.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    }
  }

  @override
  Future<SurahInterpretationModel> getSurahInterpretation(int number) async {
    final response = await client.get(Uri.parse('$BASE_URL/tafsir/$number'));
    if(response.statusCode == 200) {
      return SurahInterpretationModel.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    }
  }
}