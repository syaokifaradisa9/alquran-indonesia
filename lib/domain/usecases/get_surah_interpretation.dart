import 'package:alquran_indonesia/common/failure.dart';
import 'package:alquran_indonesia/domain/entities/surah_interpretation.dart';
import 'package:alquran_indonesia/domain/repositories/quran_repositories.dart';
import 'package:dartz/dartz.dart';

class GetSurahInterpretation{
  final QuranRepository repository;

  GetSurahInterpretation(this.repository);

  Future<Either<Failure, SurahInterpretation>> execute(int id){
    return repository.getSurahInterpretation(id);
  }
}