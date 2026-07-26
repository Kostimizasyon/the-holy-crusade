import 'package:flutter/material.dart';

import '../../global_variables.dart';
import '../player_action_row/hit_button/hit_button.dart';

class GameHand extends StatelessWidget {
  final GameHandType type;
  const GameHand({super.key, required this.type});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder<List<CardData>>(
          valueListenable: type == GameHandType.dealer ? dealerHand : playerHand,
          builder: (_, value, __) {
            int handValue = calculateHandValue(
              type == GameHandType.dealer ? dealerHand : playerHand,
            );
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (type == GameHandType.dealer ? dealerHand.value : playerHand.value)
                      .map((card) => card.widget)
                      .toList(),
                ),
                const SizedBox(height: 10),
                Text(
                  handValue > 21 ? "BUST" : handValue.toString(),
                  style: TextStyle(
                    color: handValue > 21 ? Colors.red : Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          },
        ),
      ],
    );

  }
}
