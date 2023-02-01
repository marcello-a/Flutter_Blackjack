import 'package:flutter_blackjack_pkg/models/player_model.dart';
import 'package:flutter_blackjack_pkg/services/game_service.dart';
import 'package:playing_cards/playing_cards.dart';

import 'card_service.dart';
import 'service_locator.dart';

const HIGHES_SCORE_VALUE = 21;

class GameServiceImpl extends GameService {
  late Player player;
  late Player bank;

  GameServiceImpl() {
    player = Player(_cardService.drawCards(2));
    bank = Player(_cardService.drawCards(2));
  }

  final CardService _cardService = getIt<CardService>();

  @override
  void startNewGame() {
    // if (currentHands.isNotEmpty) {
    //   _cardService.discardCards(currentHands);
    // }
  }
  @override
  void drawCard() {
    player.hand.add(_cardService.drawCard());
    getScore(player); // Bring to view
  }

  @override
  void endTurn() {
    // decke karten auf von bank
    // checke score
    const int DEALER_MIN_SCORE = 17;
    // show winner
    // change button to new game
  }

  @override
  Player getPlayer() {
    return player;
  }

  @override
  Player getBank() {
    return bank;
  }

  int getScore(Player player) {
    final total = mapCardValueRules(player.hand);
    // final total = player.hand
    //     .fold<int>(0, (sum, card) => sum + mapCardValueForBlackjack(card, sum));
    print(total);
    return total;
  }
}

/// Map blackjack rules for card values to the PlayingCard enum
int mapCardValueRules(List<PlayingCard> cards) {
  List<PlayingCard> standardCards = cards
      .where((card) => (0 <= card.value.index && card.value.index <= 11))
      .toList();

  final sumStandardCards = getSumOfStandardCards(standardCards);

  int acesAmount = cards.length - standardCards.length;
  if (acesAmount == 0) {
    return sumStandardCards;
  }

  // Special case: Ace could be value 1 or 11
  final pointsLeft = HIGHES_SCORE_VALUE - sumStandardCards;
  final oneAceIsEleven = 11 + (acesAmount - 1);

  // One Ace with value 11 fits
  if (pointsLeft > oneAceIsEleven) {
    return sumStandardCards + oneAceIsEleven;
  }

  return sumStandardCards + acesAmount;
}

int getSumOfStandardCards(List<PlayingCard> standardCards) {
  return standardCards.fold<int>(
      0, (sum, card) => sum + mapStandardCardValue(card.value.index));
}

int mapStandardCardValue(int cardEnumIdex) {
  // ignore: constant_identifier_names
  const GAP_BETWEEN_INDEX_AND_VALUE = 2;

  // Card value 2-10 -> index between 0 and 8
  if (0 <= cardEnumIdex && cardEnumIdex <= 8) {
    return cardEnumIdex + GAP_BETWEEN_INDEX_AND_VALUE;
  }

  // Card is jack, queen, king -> index between90 and 11
  if (9 <= cardEnumIdex && cardEnumIdex <= 11) {
    return 10;
  }

  return 0;
}
