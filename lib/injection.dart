import 'package:alquran_indonesia/data/datasources/quran_remote_data_source.dart';
import 'package:alquran_indonesia/data/repositories/quran_repositoy_impl.dart';
import 'package:alquran_indonesia/domain/repositories/quran_repositories.dart';
import 'package:alquran_indonesia/domain/usecases/get_all_surah.dart';
import 'package:alquran_indonesia/presentation/provider/surah_list_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

final locator = GetIt.instance;

void init(){
  locator.registerFactory(() => SurahListNotifier(
    getAllSurah: locator(),
    player: locator(),
  ));

  locator.registerLazySingleton(() => GetAllSurah(locator()));

  locator.registerLazySingleton<QuranRepository>(() => QuranRepositoryImpl(
    remoteDataSource: locator()
  ));

  locator.registerLazySingleton<QuranRemoteDataSource>(() => QuranRemoteDataSourceImpl(
    client: locator()
  ));

  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => AudioPlayer());
}