import 'package:flutter/material.dart';
import 'package:project_northstar/global_variables.dart';

class PlayerChips extends StatelessWidget {
  const PlayerChips({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(valueListenable: playerChips, builder: (_,value,context) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width:  width * 0.1,
            height: height * 0.1,
            child: Image.asset(chipAsset.value),
          ),
          Text(value.toString()),
        ],
      );
    });
  }
}
