import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/screens/home.dart';

void main() {
  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'TODO ',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
