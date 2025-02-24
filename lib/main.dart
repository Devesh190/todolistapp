import 'package:flutter/material.dart';
import 'package:todolist/feature/home/provider/task_provider.dart';
import 'package:todolist/feature/home/screen/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
ChangeNotifierProvider(create: (_)=> TaskProvider())
        ],
        child:MyApp() ,
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}


