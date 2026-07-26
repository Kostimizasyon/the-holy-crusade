import 'package:flutter/material.dart';
import 'package:project_northstar/game_page/player_chips/player_chips.dart';
import 'package:project_northstar/store_page/shop_item/shop_item.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  State<StorePage> createState() => _StorePage();
}

class _StorePage extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image for the entire page
          Positioned.fill(
            child: Image.asset(
              "assets/textures/shop_assets/shop_background.png",
              fit: BoxFit.cover,
            ),
          ),

          // Foreground content
          Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StoreText(passedWidget: BackButton()),
                    StoreText(passedWidget: PlayerChips()),
                  ],
                ),
              ),

              // GridView content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 30.0,
                    // Remove or adjust this if it crops your content
                    childAspectRatio: 0.7, // Lower value = taller cells; tweak this!
                    children: shopItems,
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class StoreText extends StatelessWidget {
  final Widget passedWidget;
  const StoreText({super.key,required this.passedWidget});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: width * 0.33,
        height: height * 0.1,
    child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/textures/shop_assets/shop_text_background.png",
              fit: BoxFit.cover,
            ),
          ),
          passedWidget
        ],
    ));
  }
}