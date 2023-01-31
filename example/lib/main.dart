import 'package:flutter/material.dart';
import 'package:flutter_blackjack_pkg/flutter_blackjack_pkg.dart';
import 'package:flutter_blackjack_pkg/services/service_locator.dart';

void main() {
  setupCardService();
  runApp(MyApp());
  // runApp(MaterialApp(home: CardHomeView()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlackJackApp();
  }
}
