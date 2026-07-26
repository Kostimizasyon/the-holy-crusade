import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_page/game_hand/playing_card/playing_card.dart';

ValueNotifier<int> previousPlayerChips = ValueNotifier(0);

ValueNotifier<List<CardData>> deck = ValueNotifier(buildDeck());

List<CardData> buildDeck() {
  final List<CardData> cards = [];

  for (int row = 0; row < 4; row++) { // 4 suits
    print("row: $row");
    for (int col = 0; col < 13; col++) { // 13 ranks
      print("col: $col");
      int cardValue;

      if (col == 0) {
        cardValue = 11; // Ace
      } else if (col >= 10) {
        cardValue = 10; // J, Q, K
      } else {
        cardValue = col + 1;
      }

      cards.add(
        CardData(
          value: cardValue,
          widget: PlayingCard(row: row, col: col),
        ),
      );
    }
  }

  return cards;
}

ValueNotifier<String> cardAsset = ValueNotifier("assets/textures/game_assets/default_card_background.png");

ValueNotifier<String> chipAsset = ValueNotifier("assets/textures/game_assets/standart_chip.png");

List<String> boughtItems = [];

ValueNotifier<double> betAmount = ValueNotifier(100);

ValueNotifier<String> playerName = ValueNotifier("");

ValueNotifier<List<CardData>> playerHand = ValueNotifier([]);

ValueNotifier<int> playerChips = ValueNotifier(0);

ValueNotifier<List<CardData>> dealerHand = ValueNotifier([]);

ValueNotifier<GameResult> gameResult = ValueNotifier(GameResult.ongoing);

PlayerNameColor playerNameColor = PlayerNameColor.standard;

enum PlayerNameColor{
  standard,
  black,
  darkRed,
  gold
}

enum PlayerChipAsset {
  standard,
  casino,
  gold
}

enum PlayerDeckAsset{
  standard,
  gold
}

enum GameHandType{
  player,
  dealer
}

enum GameResult{
  dealer,
  player,
  draw,
  ongoing
}

class CardData {
  final int value; // e.g. 2–10, J/Q/K = 10, Ace = 11
  final Widget widget;

  CardData({required this.value, required this.widget});
}


Future<void> saveItems() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList("boughtItems", boughtItems);
}

Future<List<String>> loadItems() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> result = prefs.getStringList("boughtItems") ?? [];
  return result;
}

Future<void> savePlayerChips() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt("playerChips", playerChips.value);
}

Future<void> loadPlayerChips() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int result = prefs.getInt("playerChips") ?? 0;
  playerChips.value = result;
}

Future<void> savePlayerName() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("playerName", playerName.value);
}

Future<void> loadPlayerName() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String result = prefs.getString("playerName") ?? '""';
  playerName.value = result;
}

Color getPlayerNameColor() {
   if (playerNameColor == PlayerNameColor.black) {
     return Colors.black;
   }
   else if (playerNameColor == PlayerNameColor.darkRed) {
    return Color(0xFF8B0000);
   }
   else if (playerNameColor == PlayerNameColor.gold){
     return Color(0xFFD4AF37);
   }
   else {
     return Colors.purpleAccent;
   }
}