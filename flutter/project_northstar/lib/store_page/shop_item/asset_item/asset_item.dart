import 'package:flutter/material.dart';

class AssetItem extends StatelessWidget {
  final String item;
  const AssetItem({super.key,required this.item});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.1,
      width: width * 0.1,
      child: Image.asset(item),
    );
  }
}