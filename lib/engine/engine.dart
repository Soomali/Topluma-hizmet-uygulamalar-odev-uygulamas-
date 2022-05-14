import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thu_yemek_app/engine/food.dart';
import 'package:thu_yemek_app/engine/game_state.dart';

import 'game_event.dart';

abstract class GameEngine extends ChangeNotifier {
  GameState get state;
  void foodSelected(FoodSelectedEvent event);
}

class NormalGameEngine extends GameEngine {
  NormalGameState _state = NormalGameState(0, false);
  @override
  GameState get state => _state;

  @override
  void foodSelected(FoodSelectedEvent event) {
    if (event.change.isHealthy && !state.isFinished) {
      _state = _state.copyWith(points: _state.points + 1);
    }
  }
}

class TimedGameEngine extends GameEngine {
  TimedGameEngine(this.timeLimit)
      : _state = TimedGameState(0, timeLimit, false);

  int timeLimit;
  StreamSubscription<int>? timeStream;
  TimedGameState _state;

  @override
  GameState get state => _state;

  @override
  void foodSelected(FoodSelectedEvent event) {
    if (event.change.isHealthy && !state.isFinished) {
      _state = _state.copyWith(points: _state.points + 1);
    }
  }

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
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }
}
