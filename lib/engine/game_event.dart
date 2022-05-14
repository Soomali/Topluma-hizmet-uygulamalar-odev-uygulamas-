import 'package:thu_yemek_app/state/food.dart';

import 'game_state.dart';

abstract class GameEvent<T> {
  T change;
  GameEvent(this.change);
}

class FoodSelectedEvent extends GameEvent<Food> {
  FoodSelectedEvent(Food change) : super(change);
}
