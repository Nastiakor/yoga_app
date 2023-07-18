import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final response = await dio.get(
    'https://api.vimeo.com/videos/845311683',
    options: Options(
      headers: {
        "authorization": "Bearer 60c664a2ce9111e2a319cce5943852ce",
      },
    ),
  );
  print(response.data);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Lulu'z Yoga"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(),
    );
  }
}
