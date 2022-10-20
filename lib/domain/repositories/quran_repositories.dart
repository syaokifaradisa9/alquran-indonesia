import 'package:alquran_indonesia/common/failure.dart';
import 'package:alquran_indonesia/domain/entities/detail_surah.dart';
import 'package:alquran_indonesia/domain/entities/surah.dart';
import 'package:alquran_indonesia/domain/entities/surah_interpretation.dart';
import 'package:dartz/dartz.dart';

abstract class QuranRepository{
  Future<Either<Failure, List<Surah>>> getAllSurah();
  Future<Either<Failure, DetailSurah>> getDetailSurah(int id);
  Future<Either<Failure, SurahInterpretation>> getSurahInterpretation(int id);
}