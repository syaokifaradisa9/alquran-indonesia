import 'dart:io';
import 'package:alquran_indonesia/common/exception.dart';
import 'package:alquran_indonesia/common/failure.dart';
import 'package:alquran_indonesia/data/datasources/quran_remote_data_source.dart';
import 'package:alquran_indonesia/domain/entities/detail_surah.dart';
import 'package:alquran_indonesia/domain/entities/surah.dart';
import 'package:alquran_indonesia/domain/entities/surah_interpretation.dart';
import 'package:alquran_indonesia/domain/repositories/quran_repositories.dart';
import 'package:dartz/dartz.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;

  const QuranRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Surah>>> getAllSurah() async {
    try{
      final result = await remoteDataSource.getAllSurah();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, DetailSurah>> getDetailSurah(int id) async {
    try{
      final result = await remoteDataSource.getDetailSurah(id);
      return Right(result.toEntity());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SurahInterpretation>> getSurahInterpretation(int id) async {
    try{
      final result = await remoteDataSource.getSurahInterpretation(id);
      return Right(result.toEntity());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}