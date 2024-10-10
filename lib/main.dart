import 'package:card_matching_game/my_card.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Matching Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Card Matching Game'),
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
  late List<String> numList;
  @override
  void initState() {
    super.initState();
    numList = generateList();
  }

  List<String> generateList() {
    List<String> numbers = [];
    for (int i = 1; i <= 8; i++) {
      numbers.add(i.toString());
      numbers.add(i.toString());
    }
    numbers.shuffle(Random());
    return numbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 col
                  crossAxisSpacing: 8.0, // col space
                  mainAxisSpacing: 8.0, // row space
                  childAspectRatio: 1.0,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return FlipCard(
                    str: numList[index],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
