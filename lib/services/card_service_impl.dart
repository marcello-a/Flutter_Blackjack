import 'package:flutter_blackjack_pkg/services/card_service.dart';
import 'package:playing_cards/playing_cards.dart';

/// The idea for the cards:
/// @deck contains the rest of the deck
/// @discardPile contains the discarded cards
/// the rest is on the hand of each player
class CardServiceImpl extends CardService {
  List<PlayingCard> deck = [];
  List<PlayingCard> discardPile = [];

  CardServiceImpl() {
    new52Deck();
  }

// start a new game
  @override
  void new52Deck() {
    discardPile = [];
    deck = shuffleCards(standardFiftyTwoCardDeck());
  }

  @override
  List<PlayingCard> shuffleCards(List<PlayingCard> deck) {
    deck.shuffle();
    return deck;
  }

  int getDeckSize() {
    return deck.length - 1;
  }

  @override
  void discardCard(PlayingCard card) {
    discardPile.add(card);
  }

  @override
  void discardCards(List<PlayingCard> cards) {
    discardPile.addAll(cards);
  }

  List<PlayingCard> _handleDrawCard(int amount) {
    int deckSize = getDeckSize();
    int cardsLeft = deckSize - amount;

    // Not enoght cards left in deck?
    // Remember to discard old cards
    if (cardsLeft < 0) {
      deck = [...shuffleCards(discardPile), ...deck];

      discardPile = [];
      deckSize = getDeckSize();
      cardsLeft = deckSize - amount;
    }

    List<PlayingCard> drawnCards = deck.getRange(cardsLeft, deckSize).toList();
    deck.removeRange(cardsLeft, deckSize);

    return drawnCards;
  }

  @override
  PlayingCard drawCard() {
    return _handleDrawCard(1).first;
  }

  @override
  List<PlayingCard> drawCards(int amount) {
    return _handleDrawCard(amount);
  }
}
