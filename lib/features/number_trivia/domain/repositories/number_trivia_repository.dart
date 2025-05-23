import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/core/error/failuers.dart';
import 'package:flutter_application_2/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}