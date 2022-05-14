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
      _onFoodSelected();
    } else if (event is FoodRefreshEvent) {
      _onFoodRefresh();
    } else {
      throw 'Unknown event ${event.runtimeType} for UINotifier.';
    }
  }

  void _onFoodRefresh() {
    _state = _state.copyWith(foods: createFoodPair());
    notifyListeners();
  }

  void _onAnimationStart(AnimationStartedEvent event) {
    _state = _state.copyWith(canSelectFood: false, isAnimating: true);
    notifyListeners();
    Future.delayed(Duration(milliseconds: event.animationMillis))
        .then((value) => update(_AnimationEndedEvent()));
  }

  void _onAnimationEnd() {
    _state = _state.copyWith(canSelectFood: true, isAnimating: false);
    notifyListeners();
    update(FoodRefreshEvent());
  }

  void _onFoodSelected() {
    _state = _state.copyWith(canSelectFood: false);
    notifyListeners();
  }
}
