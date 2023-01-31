import 'package:flutter_blackjack_pkg/models/player_model.dart';
import 'package:flutter_blackjack_pkg/services/game_service.dart';

import 'card_service.dart';
import 'service_locator.dart';

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
  }

  @override
  void endTurn() {}

  @override
  Player getPlayer() {
    return player;
  }

  @override
  Player getBank() {
    return bank;
  }
}
