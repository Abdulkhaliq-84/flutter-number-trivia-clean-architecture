import 'package:flutter_application_2/core/platform/network_info.dart';
import 'package:flutter_application_2/core/util/input_converter.dart';
import 'package:flutter_application_2/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_application_2/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_application_2/features/number_trivia/data/repositories/number_trivia_repoistory_impl.dart';
import 'package:flutter_application_2/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_application_2/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_application_2/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_application_2/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

   final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

