abstract class GameState {
  int points;
  int? get remainingTime;
  bool isFinished;
  GameState(this.points, this.isFinished);
  GameState copyWith();
}

class NormalGameState extends GameState {
  NormalGameState(int points, bool isFinished) : super(points, isFinished);
  @override
  int? get remainingTime => null;

  @override
  NormalGameState copyWith({int? points, bool? isFinished}) {
    return NormalGameState(
        points ?? this.points, isFinished ?? this.isFinished);
  }
}

class TimedGameState extends GameState {
  TimedGameState(int points, this._remainingTime, bool isFinished)
      : super(points, isFinished);

  int _remainingTime;
  @override
  int get remainingTime => _remainingTime;
  @override
  TimedGameState copyWith({int? points, int? remainingTime, bool? isFinished}) {
    return TimedGameState(points ?? this.points,
        remainingTime ?? _remainingTime, isFinished ?? this.isFinished);
  }
}
