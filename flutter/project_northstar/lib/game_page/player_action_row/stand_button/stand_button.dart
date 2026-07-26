import 'package:flutter/material.dart';
import 'package:project_northstar/game_page/player_action_row/hit_button/hit_button.dart';
import 'package:project_northstar/global_variables.dart';

import '../../game_score.dart';

class StandButton extends StatelessWidget {
  const StandButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.25; // 25% of screen width
    final buttonHeight = buttonWidth * 0.5; // keep aspect ratio 2:1 for example

    return GestureDetector(
      onTap: () async {
        await stand(context);
      },
      child: Image.asset(
        "assets/textures/game_assets/stand_button.png",
        width: buttonWidth,
        height: buttonHeight,
      ),
    );
  }
}

Future<void> stand(BuildContext context) async {
  int _playerHand = calculateHandValue(playerHand);
  int _dealerHand = calculateHandValue(dealerHand);

  while (_dealerHand < _playerHand && _dealerHand < 19) {
    await hit(dealerHand);
    _dealerHand = calculateHandValue(dealerHand); // ✅ Recalculate dealer hand
  }

  await gameScore(context);
}
