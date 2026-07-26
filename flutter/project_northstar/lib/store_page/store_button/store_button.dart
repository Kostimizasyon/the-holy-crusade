import 'package:flutter/material.dart';
import '../store_page.dart';

class StoreButton extends StatelessWidget {
  const StoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        goToShop(context);
      },
      child: SizedBox(
        width: width * 0.2,
        height: height * 0.2,
        child: Image.asset("assets/textures/game_assets/shop_buttonpng.png"),
      ),
    );
  }
}

void goToShop(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => StorePage(),
    ),
  );
}