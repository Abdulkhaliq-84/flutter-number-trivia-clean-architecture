import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/number_trivia/domain/entities/number_trivia.dart';



class TriviaMessage extends StatelessWidget {
  final NumberTrivia numberTrivia;
  
  const TriviaMessage({
    super.key, required this.numberTrivia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    height: MediaQuery.of(context).size.height / 3,
    child: Column(
      children: [
        Text(
          numberTrivia.number.toString(),
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Text(
                numberTrivia.text,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    ),
     );
  }
}
