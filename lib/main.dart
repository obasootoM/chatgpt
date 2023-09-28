import 'package:chatgpt/constant/const.dart';
import 'package:chatgpt/provider/model_provider.dart';
import 'package:chatgpt/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
         ChangeNotifierProvider(create: (_) => ModelProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        scaffoldBackgroundColor: ConstantColor.scaffoldBackgroundcolor,
        appBarTheme: const AppBarTheme(
          color: ConstantColor.cardcolor
        )
        ),
        home: const ChatScreen(),
      ),
    );
  }
}

