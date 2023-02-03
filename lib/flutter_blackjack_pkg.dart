library flutter_blackjack_pkg;

import 'package:flutter/material.dart';

import 'bj_home.dart';
import 'services/service_locator.dart';
import 'view/bj_game.dart';

class BlackJackApp extends StatelessWidget {
  const BlackJackApp({super.key});

  @override
  Widget build(BuildContext context) {
    setupGameService();
    setupCardService();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlackJackGame(),
    );
  }
}
