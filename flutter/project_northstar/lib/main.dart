import 'package:flutter/material.dart';

import 'game_page/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey,
        ),
        iconTheme: IconThemeData(color: Colors.blueGrey),
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey),
        scaffoldBackgroundColor: Colors.black12,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        )
      ),
      home: GamePage()
    );
  }
}
bait() {}

void proteinBar(BuildContext context, String message, {int duration = 3,String buttonText = "",void Function() onPressFunction = bait}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
        // ignore: deprecated_member_use
        bottom: WidgetsBinding.instance.window.viewInsets.bottom > 0.0 ? MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).size.height * 0.05 : MediaQuery.of(context).size.height * 0.125,
        left: MediaQuery.of(context).size.width * 0.23,
        right: MediaQuery.of(context).size.width * 0.23,
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy > 0) {
              overlayEntry.remove();
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                      Spacer(),
                      if (buttonText.isNotEmpty)
                        TextButton(onPressed: () {
                          onPressFunction();
                          overlayEntry.remove();
                        }, child: Text(buttonText,style: TextStyle(color: Colors.white, fontSize: 14),))
                    ],
                  )
              ),
            ),
          ),
        )
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: duration), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}