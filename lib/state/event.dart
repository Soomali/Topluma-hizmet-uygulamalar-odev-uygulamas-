abstract class UIEvent {}

class FoodSelectedEvent extends UIEvent {}

class AnimationEndedEvent extends UIEvent {}

class AnimationStartedEvent extends UIEvent {
  int animationMillis;
  AnimationStartedEvent(this.animationMillis);
}

class FoodRefreshEvent extends UIEvent {}
