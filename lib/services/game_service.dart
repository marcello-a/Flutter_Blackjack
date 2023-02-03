import 'package:playing_cards/playing_cards.dart';

import '../models/player_model.dart';

enum GameState { playerActive, playerWon, dealerWon, equal }

abstract class GameService {
  void startNewGame();
  PlayingCard drawCard();
  void endTurn();
  Player getPlayer();
  Player getDealer();
  int getScore(Player player);
  GameState getGameState();
  String getWinner();
}
