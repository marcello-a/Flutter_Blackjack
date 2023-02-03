import 'package:flutter_blackjack_pkg/models/player_model.dart';
import 'package:flutter_blackjack_pkg/services/card_service_impl.dart';
import 'package:flutter_blackjack_pkg/services/game_service.dart';
import 'package:playing_cards/playing_cards.dart';

import 'card_service.dart';

const HIGHES_SCORE_VALUE = 21;
const int DEALER_MIN_SCORE = 17;

class GameServiceImpl extends GameService {
  late Player player;
  late Player dealer;
  GameState gameState = GameState.equal;

  GameServiceImpl() {
    dealer = Player(_cardService.drawCards(2));
    player = Player(_cardService.drawCards(2));
  }

  final CardService _cardService = CardServiceImpl();

  @override
  void startNewGame() {
    player.hand = _cardService.drawCards(2);
    dealer.hand = _cardService.drawCards(2);
    _cardService.new52Deck();
    gameState = GameState.playerActive;
  }

  @override
  PlayingCard drawCard() {
    final drwanCard = _cardService.drawCard();
    player.hand.add(drwanCard);
    if (getScore(player) >= HIGHES_SCORE_VALUE) {
      endTurn();
    }
    return drwanCard;
  }

  @override
  void endTurn() {
    // Dealer turn
    int dealerScore = getScore(dealer);
    while (dealerScore < DEALER_MIN_SCORE) {
      dealer.hand.add(_cardService.drawCard());
      dealerScore = getScore(dealer);
    }

    // Get burnt players
    final playerScore = getScore(player);
    final bool burntDealer = (dealerScore > HIGHES_SCORE_VALUE);
    final bool burntPlayer = (playerScore > HIGHES_SCORE_VALUE);

    // Find game result
    if (burntDealer && burntPlayer) {
      gameState = GameState.equal;
    } else if (dealerScore == playerScore) {
      gameState = GameState.equal;
    } else if (burntDealer && playerScore <= HIGHES_SCORE_VALUE) {
      playerWon();
    } else if (burntPlayer && dealerScore <= HIGHES_SCORE_VALUE) {
      dealerWon();
    } else if (dealerScore < playerScore) {
      playerWon();
    } else if (dealerScore > playerScore) {
      dealerWon();
    }
  }

  void playerWon() {
    gameState = GameState.playerWon;
    player.won += 1;
    dealer.lose += 1;
    player.wonBet();
  }

  void dealerWon() {
    gameState = GameState.dealerWon;
    dealer.won += 1;
    player.lose += 1;
    player.lostBet();
  }

  @override
  Player getPlayer() {
    return player;
  }

  @override
  Player getDealer() {
    return dealer;
  }

  @override
  int getScore(Player player) {
    return mapCardValueRules(player.hand);
  }

  @override
  GameState getGameState() {
    return gameState;
  }

  @override
  String getWinner() {
    if (GameState.dealerWon == gameState) {
      return "Dealer";
    }
    if (GameState.playerWon == gameState) {
      return "You";
    }
    return "Nobody";
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
  if (pointsLeft >= oneAceIsEleven) {
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
