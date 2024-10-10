import 'package:flutter/material.dart';

class FlipCard extends StatelessWidget {
  final String str;
  final bool isFlipped;
  final VoidCallback onTap;

  const FlipCard({
    required this.str,
    required this.isFlipped,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.bounceInOut,
        switchOutCurve: Curves.bounceInOut,
        child: isFlipped
            ? CardItem(
                key: ValueKey(str),
                color: Colors.green,
                content: str,
              )
            : const CardItem(
                key: ValueKey("back"),
                color: Colors.blue,
                content: "Back",
              ),
      ),
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
