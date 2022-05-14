part of 'ui_state.dart';

class UIState {
  bool canSelectFood;
  bool isFinished;
  Food? selectedFood;
  List<Food> foods;
  bool isAnimating;
  UIState(this.canSelectFood, this.foods, this.isAnimating,
      {this.isFinished = false, this.selectedFood});
  UIState copyWith(
      {bool? canSelectFood,
      List<Food>? foods,
      bool? isAnimating,
      bool? isFinished,
      Food? selectedFood}) {
    return UIState(canSelectFood ?? this.canSelectFood, foods ?? this.foods,
        isAnimating ?? this.isAnimating,
        isFinished: isFinished ?? this.isFinished, selectedFood: selectedFood);
  }
}
