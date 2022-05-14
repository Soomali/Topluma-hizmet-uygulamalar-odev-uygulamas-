part of 'ui_state.dart';

abstract class UIEvent {}

class FoodSelectedEvent extends UIEvent {}

class _AnimationEndedEvent extends UIEvent {}

class AnimationStartedEvent extends UIEvent {
  int animationMillis;
  AnimationStartedEvent(this.animationMillis);
}

class FoodRefreshEvent extends UIEvent {}
