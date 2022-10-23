import 'package:alquran_indonesia/common/failure.dart';
import 'package:alquran_indonesia/domain/entities/detail_surah.dart';
import 'package:alquran_indonesia/domain/repositories/quran_repositories.dart';
import 'package:dartz/dartz.dart';

class GetDetailSurah {
  final QuranRepository repository;
  GetDetailSurah(this.repository);

  Future<Either<Failure, DetailSurah>> execute(int id) {
    return repository.getDetailSurah(id);
  }
}