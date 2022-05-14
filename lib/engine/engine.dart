import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thu_yemek_app/engine/game_state.dart';

abstract class GameEngine extends ChangeNotifier {
  GameState get state;
}

class NormalGameEngine extends GameEngine {
  GameState _state = NormalGameState(0, false);
  @override
  GameState get state => _state;
}

class TimedGameEngine extends GameEngine {
  TimedGameEngine(this.timeLimit)
      : _state = TimedGameState(0, timeLimit, false);

  int timeLimit;
  StreamSubscription<int>? timeStream;
  TimedGameState _state;

  @override
  GameState get state => _state;

  void start() {
    if (timeStream != null) {
      return;
    }
    timeStream = timer().listen((event) {
      final remainingTime = timeLimit - event;
      _state = _state.copyWith(
          remainingTime: remainingTime, isFinished: remainingTime <= 0);
      notifyListeners();
    });
  }

  void pause() {
    if (timeStream != null && !timeStream!.isPaused) {
      timeStream!.pause();
    }
  }

  void resume() {
    if (timeStream != null && timeStream!.isPaused) {
      timeStream!.resume();
    }
  }

  void stop() {
    timeStream?.cancel();
    timeStream = null;
  }

  @override
  void dispose() {
    timeStream?.cancel();
    timeStream = null;
    super.dispose();
  }

  Stream<int> timer() async* {
    for (int i = 0; i <= timeLimit; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      yield i;
    }
  }
}
