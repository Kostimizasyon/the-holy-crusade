import 'package:flutter/material.dart';
import 'package:project_northstar/game_page/game_page.dart';
import 'package:project_northstar/game_page/player_action_row/hit_button/hit_button.dart';
import 'package:project_northstar/global_variables.dart';
import 'package:project_northstar/store_page/store_button/store_button.dart';

void gameCheck() {
  int _dealerHand = calculateHandValue(dealerHand);
  int _playerHand = calculateHandValue(playerHand);
  if ((_playerHand > _dealerHand && _playerHand < 22) || (_dealerHand > 21 && _playerHand < 22)) {
    gameResult.value = GameResult.player;
  }
  else if ((_dealerHand > _playerHand && _dealerHand < 22) || (_playerHand > 21 && _dealerHand < 22)) {
    gameResult.value = GameResult.dealer;
  }
  else if (_dealerHand == playerHand.value) {
    gameResult.value = GameResult.draw;
  }
}

Future<void> gameScore(BuildContext context) async{
  gameCheck();
  await betResult();
  showDialog(
      barrierDismissible: false,
      context: context, builder: (BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gameResult.value == GameResult.player ? Text("You Win!",style: TextStyle(color: Colors.green),) : gameResult.value == GameResult.dealer ? Text("You Lose!",style: TextStyle(color: Colors.red),) : Text("Draw"),
          ValueListenableBuilder(valueListenable: playerChips, builder: (_,value,context) {
            return AnimatedText(value: value, color: gameResult.value == GameResult.player ? Colors.green : gameResult.value == GameResult.dealer ? Colors.red : Colors.white);
          }),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  goToShop(context);
                },
                child: Text("Go To Shop"),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  gameRestart(context);
                },
                child: Text("Play Again"),
              )
            ],
          )
        ],
      ),
    );
  });
}

void gameRestart(BuildContext context) {
  deck.value = buildDeck();
  dealerHand.value = [];
  playerHand.value = [];

  Navigator.of(context).pop();
  gameStart();
}


class AnimatedText extends ImplicitlyAnimatedWidget {
  final int value;
  final Color color;

  const AnimatedText({
    super.key,
    required this.value,
    required this.color,
    super.duration = const Duration(milliseconds: 500),
    super.curve = Curves.easeOut,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends AnimatedWidgetBaseState<AnimatedText> {
  IntTween? _counterTween;
  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _counterTween = visitor(
      _counterTween,
      widget.value,
          (dynamic previousValue) {
        print('Previous value: $previousValue, New value: ${widget.value}');
        return IntTween(begin: previousValue as int, end: widget.value);
      },
    ) as IntTween;
  }
  @override
  Widget build(BuildContext context) {
    final animatedValue = _counterTween?.evaluate(animation) ?? widget.value;
    return Text(
      "$animatedValue",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: widget.color,
      ),
    );
  }
}

Future<void> betResult() async {
  previousPlayerChips.value = playerChips.value;
  if (gameResult.value == GameResult.player) {
    playerChips.value += betAmount.value.toInt();
  } else if (gameResult.value == GameResult.dealer) {
    playerChips.value -= betAmount.value.toInt();
  }
  await savePlayerChips();
}
