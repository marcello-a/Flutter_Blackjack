import '../models/player_model.dart';

abstract class GameService {
  void startNewGame();
  void drawCard();
  void endTurn();
  Player getPlayer();
  Player getBank();
}
