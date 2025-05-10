import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter_application_2/injection_container.dart' as di;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Number Trivia",
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        hintColor: Colors.green.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}
