import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_application_2/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_application_2/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:flutter_application_2/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:flutter_application_2/features/number_trivia/presentation/widgets/trivia_message.dart';
import 'package:flutter_application_2/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Number Trivia',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // BlocBuilder to handle different states
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is NumberTriviaInitial) {
                    return MessageDisplay(message: 'Start searching!');
                  } else if (state is NumberTriviaLoading) {
                    return LoadingWidget();
                  } else if (state is NumberTriviaLoaded) {
                    return TriviaMessage(numberTrivia: state.trivia);
                  } else if (state is NumberTriviaError) {
                    return MessageDisplay(message: state.message);
                  }
                  return MessageDisplay(
                      message: 'Unexpected state. Please try again.');
                },
              ),
              SizedBox(height: 20),
              // Controls at the bottom
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}

class TriviaControls extends StatefulWidget {
  const TriviaControls({Key? key}) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  late String inputStr; // Using late to handle inputStr

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: Text('Search'),
                onPressed: dispatchConcrete,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                child: Text('Get random trivia'),
                onPressed: dispatchRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    if (inputStr.isNotEmpty) {
      // Ensure we have valid input to dispatch
      context.read<NumberTriviaBloc>().add(GetTriviaForConcreteNumber(inputStr));
    }
  }

  void dispatchRandom() {
    controller.clear();
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumber());
  }
}
