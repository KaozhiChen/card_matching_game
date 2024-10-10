import 'package:flutter/material.dart';
import 'dart:math';

class FlipCard extends StatefulWidget {
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
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final isFront = _flipAnimation.value < pi / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateY(_flipAnimation.value)
              ..scale(_scaleAnimation.value),
            child: isFront
                ? const CardItem(
                    key: ValueKey("back"),
                    color: Colors.blue,
                    content: "Back",
                  )
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: CardItem(
                      key: ValueKey(widget.str),
                      color: Colors.green,
                      content: widget.str,
                    ),
                  ),
          );
        },
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
