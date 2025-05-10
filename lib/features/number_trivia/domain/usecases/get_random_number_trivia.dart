import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/core/error/failuers.dart';
import 'package:flutter_application_2/core/usecases/usecase.dart';
import 'package:flutter_application_2/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_application_2/features/number_trivia/domain/repositories/number_trivia_repository.dart';


class GetRandomNumberTrivia extends Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}