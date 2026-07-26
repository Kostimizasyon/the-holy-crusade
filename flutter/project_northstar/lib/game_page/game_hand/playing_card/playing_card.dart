import 'package:flutter/material.dart';

import '../../../global_variables.dart';

// The PlayingCard widget (from earlier)
class PlayingCard extends StatelessWidget {
  final int row; // suit index: 0–3
  final int col; // rank index: 0–12
  final double cardWidth;
  final double cardHeight;

  const PlayingCard({
    super.key,
    required this.row,
    required this.col,
    this.cardWidth = 90,
    this.cardHeight = 120,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        widthFactor: 1 / 13, // 13 cards per row
        heightFactor: 1 / 4, // 4 suits
        child: Container(
          width: cardWidth * 13,
          height: cardHeight * 4,
          color: Colors.white,
          child: Image.asset(
            'assets/textures/game_assets/card_assets.png',
            fit: BoxFit.fill,
          ),
        )
      ),
    );
  }
}

class DealAnimation extends StatefulWidget {
  const DealAnimation({super.key});

  @override
  State<DealAnimation> createState() => _DealAnimationState();
}

class _DealAnimationState extends State<DealAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  void startAnimation() {
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.35;
    final buttonHeight = buttonWidth * 0.75;

    return Center(
      child: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            cardAsset.value,
            width: buttonWidth,
            height: buttonHeight,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
