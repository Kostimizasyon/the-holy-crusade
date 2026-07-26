import 'package:flutter/material.dart';
import 'package:project_northstar/global_variables.dart';
import 'package:project_northstar/main.dart';
import 'package:project_northstar/store_page/shop_item/asset_item/asset_item.dart';
import 'package:project_northstar/store_page/store_page.dart';

List<Widget> shopItems = [
  ShopItem(itemName: "Black Player Name",item: AssetItem(item: "assets/textures/shop_assets/items/black_name.png"), itemValue: 1000),
  ShopItem(itemName: "Dark Red Player Name",item: AssetItem(item: "assets/textures/shop_assets/items/darkRed_name.png"), itemValue: 3000),
  ShopItem(itemName: "Golden Player Name",item: AssetItem(item: "assets/textures/shop_assets/items/gold_name.png"), itemValue: 10000),
  ShopItem(itemName: "Black Chips",item: AssetItem(item: "assets/textures/shop_assets/items/black_chips.png"), itemValue: 5000),
  ShopItem(itemName: "Golden Chips",item: AssetItem(item: "assets/textures/shop_assets/items/golden_chips.png"), itemValue: 50000),
  ShopItem(itemName: "Cool Card Background",item: AssetItem(item: "assets/textures/shop_assets/items/cool_card_background.png"), itemValue: 100000),
];

class ShopItem extends StatefulWidget {
  final int itemValue;
  final String itemName;
  final Widget item;

  const ShopItem({
    super.key,
    required this.itemName,
    required this.item,
    required this.itemValue,
  });

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {
    bool equipStatus = false;
    return GestureDetector(
      onTap: () {
          setState(() {
            buyItem(context,widget.item, widget.itemValue);
          });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🧩 Expanded image section
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/textures/shop_assets/item_background.png",
                    fit: BoxFit.contain,
                  ),
                ),
                widget.item,
              ],
            ),
          ),
          // 🧩 Expanded or fixed text section
          Expanded(
            flex: 1,
            child: Center(
              child: StoreText(
                  passedWidget: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.itemName}\n',
                        ),
                        TextSpan(
                          text: boughtItems.contains(shopItems.indexOf(widget.item).toString()) ? equipStatus ? "Equipped" : "Owned" : '${widget.itemValue}' ,
                          style: TextStyle(
                            color: boughtItems.contains(shopItems.indexOf(widget.item).toString()) ? equipStatus ? Colors.green : Colors.white  : Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void buyItem(context,item,int itemValue) {
  itemValue < playerChips.value ? playerChips.value -= itemValue : proteinBar(context, "You cant afford this");
}

void triggerNameReBuild() {
  String old = playerName.value;
  playerName.value = "";
  playerName.value = old;
}