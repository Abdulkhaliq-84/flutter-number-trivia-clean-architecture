import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/core/error/failuers.dart';
import 'package:flutter_application_2/core/usecases/usecase.dart';
import 'package:flutter_application_2/core/util/input_converter.dart';
import 'package:flutter_application_2/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_application_2/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_application_2/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : assert(getConcreteNumberTrivia != null),
       assert(getRandomNumberTrivia != null),
       assert(inputConverter != null),
       super(NumberTriviaInitial()) {
    on<NumberTriviaEvent>((event, emit) {
      // Handle events here
    });
  }

 NumberTriviaState get initialState => NumberTriviaInitial();

  
 @override
Stream<NumberTriviaState> mapEventToState(
  NumberTriviaEvent event,
) async* {
  if (event is GetTriviaForConcreteNumber) {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);

    yield* inputEither.fold(
      (failure) async* {
        yield NumberTriviaError(message: INVALID_INPUT_FAILURE_MESSAGE);
      },
      (integer) async* {
        yield NumberTriviaLoading();
        final failureOrTrivia = await getConcreteNumberTrivia(
          Params(number: integer),
        );
        yield* _eitherLoadedOrErrorState(failureOrTrivia);
      },
    );
  } else if (event is GetTriviaForRandomNumber) {
    yield NumberTriviaLoading();
    final failureOrTrivia = await getRandomNumberTrivia(
      NoParams(),
    );
    yield* _eitherLoadedOrErrorState(failureOrTrivia);
  }
}

Stream<NumberTriviaState> _eitherLoadedOrErrorState(
  Either<Failure, NumberTrivia> either,
) async* {
  yield either.fold(
    (failure) => NumberTriviaError(message: _mapFailureToMessage(failure)),
    (trivia) => NumberTriviaLoaded(trivia: trivia),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}
}
