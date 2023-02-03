import 'package:playing_cards/playing_cards.dart';

class Player {
  List<PlayingCard> hand;
  int won = 0;
  int lose = 0;

  Player(this.hand);
}
