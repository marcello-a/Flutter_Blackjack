import '../models/player_model.dart';

enum GameState { playerActive, playerWon, dealerWon, equal }

abstract class GameService {
  void startNewGame();
  void drawCard();
  void endTurn();
  Player getPlayer();
  Player getDealer();
  int getScore(Player player);
  GameState getGameState();
  String getWinner();
}
