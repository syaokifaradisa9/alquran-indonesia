import 'package:alquran_indonesia/common/failure.dart';
import 'package:alquran_indonesia/domain/entities/surah.dart';
import 'package:alquran_indonesia/domain/repositories/quran_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllSurah{
  final QuranRepository repository;

  GetAllSurah(this.repository);

  Future<Either<Failure, List<Surah>>> execute() {
    return repository.getAllSurah();
  }
}