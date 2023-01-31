import 'package:flutter_blackjack_pkg/services/card_service.dart';
import 'package:flutter_blackjack_pkg/services/card_service_impl.dart';
import 'package:flutter_blackjack_pkg/services/game_service.dart';
import 'package:flutter_blackjack_pkg/services/game_service_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupCardService() {
  getIt.registerLazySingleton<CardService>(() => CardServiceImpl());
}

setupGameService() {
  getIt.registerLazySingleton<GameService>(() => GameServiceImpl());
}
