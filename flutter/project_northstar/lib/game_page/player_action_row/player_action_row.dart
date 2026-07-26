import 'package:flutter/material.dart';
import 'package:project_northstar/game_page/player_action_row/stand_button/stand_button.dart';
import 'package:project_northstar/game_page/select_bet/select_bet.dart';
import 'hit_button/hit_button.dart';

class PlayerActionRow extends StatelessWidget{
  const PlayerActionRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StandButton(),
        SelectBet(),
        HitButton(),
      ],
    );
  }
}