import 'package:flutter_application_2/core/error/exceptions.dart';
import 'package:flutter_application_2/features/number_trivia/data/models/number_triavia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class  NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString('CACHED_NUMBER_TRIVIA', triviaToCache.toJson() as String);
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString('CACHED_NUMBER_TRIVIA');
    if(jsonString != null){
      return Future.value(NumberTriviaModel.fromJson(jsonString as Map<String, dynamic>));
    }
    else{
      throw CacheException();
    }
  }
}

