import 'package:flutter/material.dart';
import 'package:thu_yemek_app/state/event.dart';
import 'package:thu_yemek_app/state/state.dart';
import 'package:thu_yemek_app/state/utils.dart';

import 'food.dart';

class UINotifier extends ChangeNotifier {
  UIState _state = UIState(true, createFoodPair(), false);
  UIState get state => _state;

  void update(UIEvent event) {
    if (event is AnimationStartedEvent) {
      onAnimationStart();
    } else if (event is AnimationEndedEvent) {
      onAnimationEnd();
    } else if (event is FoodSelectedEvent) {
      onFoodSelected();
    } else if (event is FoodRefreshEvent) {
      onFoodRefresh();
    } else {
      throw 'Unknown event ${event.runtimeType} for UINotifier.';
    }
  }

  void onFoodRefresh() {
    _state = _state.copyWith(foods: createFoodPair());
    notifyListeners();
  }

  void onAnimationStart() {
    _state = _state.copyWith(canSelectFood: false, isAnimating: true);
    notifyListeners();
  }

  void onAnimationEnd() {
    _state = _state.copyWith(
        canSelectFood: true, foods: createFoodPair(), isAnimating: false);
    notifyListeners();
  }

  void onFoodSelected() {
    _state = _state.copyWith(canSelectFood: false);
    notifyListeners();
  }
}
