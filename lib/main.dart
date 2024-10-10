import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: FlipCard(),
      ),
    );
  }
}

class FlipCard extends StatefulWidget {
  const FlipCard({
    super.key,
  });

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> {
  bool isFront = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFront = !isFront;
        });
      },
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: isFront
              ? const CardItem(
                  color: Colors.blue,
                  content: "Front",
                )
              : const CardItem(
                  color: Colors.green,
                  content: "Back",
                )),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    required this.color,
    required this.content,
    super.key,
  });

  final String content;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      child: Text(
        content,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
