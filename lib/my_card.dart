import 'package:flutter/material.dart';
import 'dart:math';

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
    Widget _transitionBuilder(Widget child, Animation<double> animation) {
      final flip = Tween(begin: pi, end: 0).animate(animation);
      return AnimatedBuilder(
          animation: flip,
          builder: (context, widget) {
            return Transform(
              transform: Matrix4.rotationY(flip.value.toDouble()),
              alignment: Alignment.center,
              child: child,
            );
          });
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          isFront = !isFront;
        });
      },
      child: AnimatedSwitcher(
          transitionBuilder: _transitionBuilder,
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.bounceInOut,
          switchOutCurve: Curves.bounceInOut,
          child: isFront
              ? const CardItem(
                  key: ValueKey(true),
                  color: Colors.blue,
                  content: "Front",
                )
              : const CardItem(
                  key: ValueKey(false),
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
      key: key,
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
