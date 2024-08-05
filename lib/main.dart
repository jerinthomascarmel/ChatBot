import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/bloc/chat_bloc.dart';
import 'package:gemini_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat Bot',
        theme: ThemeData(
            fontFamily: "GamjaFlower",
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 30.0),
              bodyMedium: TextStyle(fontSize: 25.0),
            ),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey.shade900,
            primaryColor: Colors.grey.shade900),
        home: HomeScreen(),
      ),
    );
  }
}
