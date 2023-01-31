import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

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
