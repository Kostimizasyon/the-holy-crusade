import 'package:flutter/material.dart';
import '../../global_variables.dart';

class SelectBet extends StatelessWidget {
  const SelectBet({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
              title: ValueListenableBuilder(valueListenable: betAmount, builder: (_,value,context) {
                return Text("Currently Betting: ${betAmount.value.toInt()}");
              }),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BetSlider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Confirm"),
                  )
                ],
              )
          );
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BettingChip(),
          ValueListenableBuilder(valueListenable: betAmount, builder: (_,value,context) {
            return Text("Current Bet Amount: ${betAmount.value.toInt()}");
          })
        ],
      ),
    );
  }
}


class BetSlider extends StatefulWidget {
  const BetSlider({super.key});
  @override
  State<BetSlider> createState() => _BetSlider();
}

class _BetSlider extends State<BetSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: betAmount.value,
      max: 1000,
      divisions: 10,
      label: betAmount.value.round().toString(),
      onChanged: (value) {
        setState(() {
          betAmount.value = value;
        });
      },
    );
  }
}

class BettingChip extends StatelessWidget {
  const BettingChip({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: betAmount,
      builder: (_, value, __) {
        // Calculate how many chips to show based on betAmount
        // For example, 1 chip per 100 units of betAmount:
        int chipCount = (value / 200).clamp(0, 10).toInt(); // max 10 chips to avoid overflow

        if (chipCount == 0) chipCount = 1; // Always show at least one chip

        return SafeArea(
            child: SizedBox(
              width: 60, // width of stack container, adjust as needed
              height: 80, // height of stack container, adjust as needed
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: List.generate(chipCount, (index) {
                  return Positioned(
                    bottom: index * 8.0, // vertical offset between chips (overlap)
                    child: ValueListenableBuilder(valueListenable: chipAsset, builder: (_,value,context) {
                      return Image.asset(
                        value,
                        width: 50,
                        height: 50,
                      );
                    }
                ));
               },
              ),
            )
        ));
      },
    );
  }
}
