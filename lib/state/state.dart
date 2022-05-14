import 'food.dart';

class UIState {
  bool canSelectFood;
  List<Food> foods;
  UIState(this.canSelectFood, this.foods);
  UIState copyWith({bool? canSelectFood, List<Food>? foods}) {
    return UIState(canSelectFood ?? this.canSelectFood, foods ?? this.foods);
  }
}
