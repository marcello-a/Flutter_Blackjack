library flutter_blackjack_pkg;

import 'package:flutter/material.dart';

import 'view/bj_game.dart';

class BlackJackApp extends StatelessWidget {
  const BlackJackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlackJackGame(),
    );
  }
}
