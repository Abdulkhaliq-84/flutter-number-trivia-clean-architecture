part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  
  @override
  List<Object> get props => [];
}

final class NumberTriviaInitial extends NumberTriviaState {}


class NumberTriviaLoading extends NumberTriviaState {}

class NumberTriviaLoaded extends NumberTriviaState {
  final NumberTrivia trivia;

  NumberTriviaLoaded({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class NumberTriviaError extends NumberTriviaState {
  final String message;
  
  NumberTriviaError({required this.message});

  @override
  List<Object> get props => [message];
}
