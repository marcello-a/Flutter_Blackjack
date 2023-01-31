import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack_pkg/card.dart';
import 'package:flutter_blackjack_pkg/services/card_service.dart';
import 'package:playing_cards/playing_cards.dart';

import 'services/service_locator.dart';

/// Idea: show a stack of cards in different hights to show how much are left
class BlackJackHomePage extends StatefulWidget {
  const BlackJackHomePage({super.key});
  @override
  State<BlackJackHomePage> createState() => _BlackJackHomePageState();
}

class _BlackJackHomePageState extends State<BlackJackHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  final CardService _cardService = getIt<CardService>();
  List<PlayingCard> currentHands = [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });

    newGame();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getFilppendCard(currentHands[1]),
              getFilppendCard(currentHands[2]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  newGame();
                },
                child: card(Suit.clubs, CardValue.ace),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getFilppendCard(currentHands[2]),
              getFilppendCard(currentHands[3]),
            ],
          ),
        ]),
      ),
    );
  }

  Widget getFilppendCard(PlayingCard playingCard) {
    return SizedBox(
      height: 180,
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(pi * _animation.value),
        child: GestureDetector(
          onTap: () {
            if (_animationStatus == AnimationStatus.dismissed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
          child: _animation.value > 0.5
              ? PlayingCardView(
                  showBack: true,
                  card: playingCard,
                )
              : PlayingCardView(
                  showBack: false,
                  card: playingCard,
                ),
        ),
      ),
    );
  }

  void newGame() {
    _animationController.reset(); // .forward();

    if (currentHands.isNotEmpty) {
      _cardService.discardCards(currentHands);
    }
    currentHands = _cardService.drawCards(4);
  }
}

Widget card(Suit suit, CardValue cardValue) {
  return ClipRRect(
      child: SizedBox(
          height: 180,
          child: PlayingCardView(
            card: PlayingCard(
              suit,
              cardValue,
            ),
            showBack: true,
          )));
}
