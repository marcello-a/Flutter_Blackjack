import 'package:flutter/material.dart';
import 'package:flutter_blackjack_pkg/widgets/card.dart';
import 'package:flutter_blackjack_pkg/services/game_service.dart';
import 'package:flutter_blackjack_pkg/services/game_service_impl.dart';
import 'package:playing_cards/playing_cards.dart';

GameService _gameService = GameServiceImpl();

class BlackJackGame extends StatefulWidget {
  const BlackJackGame({super.key});

  @override
  State<BlackJackGame> createState() => _BlackJackGameState();
}

class _BlackJackGameState extends State<BlackJackGame> {
  PlayingCard deckTopCard = PlayingCard(Suit.joker, CardValue.joker_1);
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
                    child: SizedBox(
                      width: 150,
                      child: FlatCardFan(
                        children: [
                          cardWidget(
                              PlayingCard(Suit.joker, CardValue.joker_1), true),
                          cardWidget(
                              PlayingCard(Suit.joker, CardValue.joker_2), true),
                          cardWidget(
                              PlayingCard(Suit.joker, CardValue.joker_2), true),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(139, 0, 0, 1),
                              textStyle: const TextStyle(fontSize: 20)),
                          onPressed: () {
                            if (_gameService.getGameState() ==
                                GameState.playerActive) {
                              _gameService.endTurn();
                            } else {
                              _gameService.startNewGame();
                            }
                            setState(() {});
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
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    Text(
                      "Won: ${_gameService.getPlayer().won}",
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Lost: ${_gameService.getPlayer().lose}",
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: Center(
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 45,
                        onPressed: () {
                          _gameService.getPlayer().setBeLower();
                          setState(() {});
                        },
                        icon: const Icon(Icons.arrow_left),
                      ),
                      Text(
                        _gameService.getPlayer().bet.toString(),
                        style: const TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        iconSize: 45,
                        onPressed: () {
                          _gameService.getPlayer().setBetHigher();
                          setState(() {});
                        },
                        icon: const Icon(Icons.arrow_right),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wallet),
              const SizedBox(width: 7.5),
              Text(
                _gameService.getPlayer().wallet.toString(),
                style: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
