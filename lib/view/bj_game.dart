import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_blackjack_pkg/card.dart';
import 'package:flutter_blackjack_pkg/services/game_service.dart';
import 'package:playing_cards/playing_cards.dart';

import '../services/service_locator.dart';

GameService _gameService = getIt<GameService>();

class BlackJackGame extends StatefulWidget {
  const BlackJackGame({super.key});

  @override
  State<BlackJackGame> createState() => _BlackJackGameState();
}

class _BlackJackGameState extends State<BlackJackGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            height: 180,
            width: _gameService.getDealer().hand.length * 90,
            child: FlatCardFan(
              children: [
                for (var card in _gameService.getDealer().hand) ...[
                  CardAnimatedWidget(
                      card,
                      (_gameService.getGameState() == GameState.playerActive),
                      3.0)
                ]
              ],
            ),
          ),
          const SizedBox(height: 12.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Won: ${_gameService.getDealer().won}"),
                  Text("Lost: ${_gameService.getDealer().lose}"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_gameService.getGameState() ==
                          GameState.playerActive) {
                        _gameService.drawCard();
                        setState(() {});
                      }
                    },
                    child: cardWidget(
                        PlayingCard(Suit.joker, CardValue.joker_1), true),
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20)),
                          onPressed: () {
                            if (_gameService.getGameState() ==
                                GameState.playerActive) {
                              _gameService.endTurn();
                            } else {
                              _gameService.startNewGame();
                            }
                            setState(() {
                              print(_gameService.getGameState());
                            });
                          },
                          child: Text((() {
                            if (_gameService.getGameState() !=
                                GameState.playerActive) {
                              return "New Game";
                            }
                            return 'Finish';
                          })()),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                if (_gameService.getGameState() !=
                                    GameState.playerActive) ...[
                                  Text("Winner: ${_gameService.getWinner()}"),
                                  Text(
                                      "Dealer score: ${_gameService.getScore(_gameService.getDealer())}"),
                                  Text(
                                      "Player  score: ${_gameService.getScore(_gameService.getPlayer())}"),
                                ],
                              ],
                            )),
                      ]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Won: ${_gameService.getPlayer().won}"),
                  Text("Lost: ${_gameService.getPlayer().lose}"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.5),
          SizedBox(
            height: 180,
            width: _gameService.getPlayer().hand.length * 90,
            child: FlatCardFan(
              children: [
                for (var card in _gameService.getPlayer().hand) ...[
                  CardAnimatedWidget(card, false, 3.0)
                ]
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
