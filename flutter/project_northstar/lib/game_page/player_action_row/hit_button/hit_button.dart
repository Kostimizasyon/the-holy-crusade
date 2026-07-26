import 'package:flutter/material.dart';
import 'package:project_northstar/game_page/game_hand/playing_card/playing_card.dart';
import 'dart:math';
import 'package:project_northstar/global_variables.dart';
import '../../game_score.dart';
import 'dart:math' as math;

class HitButton extends StatelessWidget {
  const HitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final buttonWidth = screenWidth * 0.35;
    final buttonHeight = buttonWidth * 0.75;

    return GestureDetector(
      onTap: () async {
        await hit(playerHand);
        if (calculateHandValue(playerHand) > 21) {
          await gameScore(context);
        } else {
          gameResult.value = GameResult.ongoing;
        }
      },
      child: SizedBox(
        height: buttonHeight + (10 * 3.0), // Add stack height
        width: buttonWidth,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: List.generate(10, (index) {
            return Positioned(
              bottom: index * 3.0, // Space between cards
              child: Transform.rotate(
                angle: 90 * math.pi / 180, // 90 degrees in radians
                child: Image.asset(
                  cardAsset.value,
                  width: buttonWidth,
                  height: buttonHeight,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
        ),
      )
    );
  }
}



Future<void> hit(ValueNotifier<List<CardData>> hand) async {

  int randomIndex = Random().nextInt(deck.value.length); // ✅ not -1
  DealAnimation();
  await Future.delayed(Duration(seconds: 2));
  CardData pulledCard = deck.value[randomIndex];
  int cardValue = pulledCard.value;
  if (cardValue == 11 && calculateHandValue(hand) + cardValue > 21) {
    cardValue = 1;
  }

  hand.value = [...hand.value,pulledCard];
  deck.value.removeAt(randomIndex);
}

int calculateHandValue(ValueNotifier<List<CardData>> hand) {
  int result = 0;
  for (var x in hand.value) {
    result += x.value;
  }
  return result;
}