import 'package:flutter/material.dart';
import 'package:project_northstar/global_variables.dart';
import 'package:project_northstar/main.dart';

class PlayerRenameButton extends StatelessWidget {
  const PlayerRenameButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
          playerRename(context);
      },
      child: SizedBox(
        width: width * 0.3,
        height: height * 0.1,
        child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/textures/eminem.png'),
          Center(
            child: ValueListenableBuilder(valueListenable: playerName, builder: (_,value,context) {return Text(playerName.value,style: TextStyle(color: getPlayerNameColor()));}),
          )
        ],
      ),
    )
    );
  }
}

TextEditingController _controller = TextEditingController(text: playerName.value);

void playerRename(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Rename Player"),
          Container(height: 1,color: Colors.grey,)
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(border: OutlineInputBorder()),
            onSubmitted: (value) async{
              playerName.value = _controller.text;
              await savePlayerName();
            },
          ),
          Container(height: 15,),
          Row(
            children: [
              if (playerName.value != "")
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close",style: TextStyle(color: Colors.black)),
                ),
              Spacer(),
              GestureDetector(
                onTap: () async{
                  if (_controller.text == "") {
                    proteinBar(context, "Please properly name yourself");
                  }
                  else {
                    playerName.value = _controller.text;
                    await savePlayerName();
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  }
                },
                child: Text("Rename",style: TextStyle(color: Colors.black),),
              )
            ],
          )
        ],
      ),
    );
  });
}