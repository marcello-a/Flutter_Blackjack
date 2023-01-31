import 'package:flutter/material.dart';
import 'package:flutter_blackjack_pkg/flutter_blackjack_pkg.dart';
import 'package:flutter_blackjack_pkg/services/service_locator.dart';

void main() {
  // TODO: Später verschieben
  setupGameService();
  setupCardService();
  runApp(const MyApp());
  // runApp(MaterialApp(home: CardHomeView()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlackJackApp();
  }
}
