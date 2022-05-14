part of 'ui_state.dart';

abstract class UIEvent {}

class FoodSelectedEvent extends UIEvent {
  final Food food;
  FoodSelectedEvent(this.food);
}

class _AnimationEndedEvent extends UIEvent {}

class AnimationStartedEvent extends UIEvent {
  final int animationMillis;
  AnimationStartedEvent(this.animationMillis);
}

class GameEndedEvent extends UIEvent {}

class GameRestartEvent extends UIEvent {}

class FoodRefreshEvent extends UIEvent {}
