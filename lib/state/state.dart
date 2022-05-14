part of 'ui_state.dart';

class UIState {
  bool canSelectFood;
  List<Food> foods;
  bool isAnimating;
  UIState(this.canSelectFood, this.foods, this.isAnimating);
  UIState copyWith(
      {bool? canSelectFood, List<Food>? foods, bool? isAnimating}) {
    return UIState(canSelectFood ?? this.canSelectFood, foods ?? this.foods,
        isAnimating ?? this.isAnimating);
  }
}
