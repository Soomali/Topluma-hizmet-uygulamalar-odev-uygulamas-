part of 'ui_state.dart';

class UINotifier extends ChangeNotifier {
  UIState _state = UIState(true, createFoodPair(), false);
  UIState get state => _state;

  void update(UIEvent event) {
    if (event is AnimationStartedEvent) {
      _onAnimationStart(event);
    } else if (event is _AnimationEndedEvent) {
      _onAnimationEnd();
    } else if (event is FoodSelectedEvent) {
      if (!state.isFinished) {
        _onFoodSelected(event);
      }
    } else if (event is FoodRefreshEvent) {
      if (!state.isFinished) {
        _onFoodRefresh();
      }
    } else if (event is GameEndedEvent) {
      _onGameEnded();
    } else if (event is GameRestartEvent) {
      _onGameRestart();
    } else {
      throw 'Unknown event ${event.runtimeType} for UINotifier.';
    }
  }

  void _onGameRestart() {
    _state = _state.copyWith(isFinished: false);
    notifyListeners();
    Future.delayed(Duration(milliseconds: 120))
        .then((value) => update(FoodRefreshEvent()));
  }

  void _onGameEnded() {
    _state = _state.copyWith(isFinished: true);
    notifyListeners();
  }

  void _onFoodRefresh() {
    _state = _state.copyWith(
        foods: createFoodPair(before: _state.foods), selectedFood: null);
    notifyListeners();
    log('food refreshed');
  }

  void _onAnimationStart(AnimationStartedEvent event) {
    _state = _state.copyWith(
        canSelectFood: false,
        isAnimating: true,
        selectedFood: _state.selectedFood);
    notifyListeners();
    Future.delayed(Duration(milliseconds: event.animationMillis))
        .then((_) => update(_AnimationEndedEvent()));
  }

  void _onAnimationEnd() {
    _state = _state.copyWith(
        canSelectFood: true,
        isAnimating: false,
        selectedFood: _state.selectedFood);
    notifyListeners();
    Future.delayed(Duration(milliseconds: 150))
        .then((_) => update(FoodRefreshEvent()));
  }

  void _onFoodSelected(FoodSelectedEvent event) {
    _state = _state.copyWith(canSelectFood: false, selectedFood: event.food);
    notifyListeners();
    log('food selected');
    update(AnimationStartedEvent(300));
  }
}
