import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/core/error/exceptions.dart';
import 'package:flutter_application_2/core/error/failuers.dart';
import 'package:flutter_application_2/core/platform/network_info.dart';
import 'package:flutter_application_2/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_application_2/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_application_2/features/number_trivia/data/models/number_triavia_model.dart';
import 'package:flutter_application_2/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_application_2/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
     return await _getTrivia((){
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia((){
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    Future<NumberTrivia> Function() getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom;
        localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia as NumberTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } 
    else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
