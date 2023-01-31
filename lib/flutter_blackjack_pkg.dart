library flutter_blackjack_pkg;

import 'package:flutter/material.dart';

import 'bj_home.dart';

class BlackJackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlackJackHomePage(),
    );
  }
}
