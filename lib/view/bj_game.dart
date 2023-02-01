import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_blackjack_pkg/card.dart';
import 'package:flutter_blackjack_pkg/services/game_service.dart';
import 'package:playing_cards/playing_cards.dart';

import '../services/service_locator.dart';

GameService _gameService = getIt<GameService>();

class BlackJoackGame extends StatefulWidget {
  const BlackJoackGame({super.key});

  @override
  State<BlackJoackGame> createState() => _BlackJoackGameState();
}

class _BlackJoackGameState extends State<BlackJoackGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var card in _gameService.getPlayer().hand) ...[
                  cardWidget(card, false)
                ]
              ],
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _gameService.drawCard();
                    setState(() {});
                  },
                  child:
                      cardWidget(PlayingCard(Suit.clubs, CardValue.ace), true),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    _gameService.endTurn();
                  },
                  child: const Text('Finish'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var card in _gameService.getBank().hand) ...[
                  cardWidget(card, false)
                  // CardAnimatedWidget(card) // TODO
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget cardWidget(PlayingCard card, bool showBack) {
  return ClipRRect(
      child: SizedBox(
          height: 180,
          child: PlayingCardView(
            card: card,
            showBack: showBack,
          )));
}
