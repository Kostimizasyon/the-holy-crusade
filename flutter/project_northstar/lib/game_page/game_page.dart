import 'package:flutter/material.dart';
import 'package:project_northstar/game_page/game_hand/game_hand.dart';
import 'package:project_northstar/game_page/player_action_row/hit_button/hit_button.dart';
import 'package:project_northstar/game_page/player_action_row/player_action_row.dart';
import 'package:project_northstar/game_page/player_chips/player_chips.dart';
import 'package:project_northstar/game_page/player_rename_button/player_rename_button.dart';
import '../global_variables.dart';
import '../store_page/store_button/store_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await loadPlayerName();
      await loadPlayerChips();
      if (playerName.value == "") {
          playerRename(context);
      }
      gameStart();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/textures/game_assets/game_background.png",
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayerChips(),
              StoreButton(),
            ],
          ),
          SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GameHand(type: GameHandType.dealer),
                  Spacer(),
                  PlayerActionRow(),
                  Spacer(),
                  GameHand(type: GameHandType.player),
                ],
              ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: PlayerRenameButton(),
          )
        ],
      )
    );
  }
}

Future<void> gameStart() async{
  for (int x =0;x<2;x++) {
    await hit(playerHand);
    await hit(dealerHand);
  }
}

