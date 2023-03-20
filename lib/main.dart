import 'package:chatgpt_demo/chat_screen.dart';
import 'package:chatgpt_demo/screen/landing_screen.dart';
import 'package:flutter/material.dart';

//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
void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LandingScreen(),
    );
  }
}