import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_yemek_app/engine/engine.dart';
import 'package:thu_yemek_app/state/ui_state.dart';
import 'package:thu_yemek_app/views/food_view.dart/food_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engine = TimedGameEngine(60);
    final uINotifier = UINotifier();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: engine),
            ChangeNotifierProxyProvider<TimedGameEngine, UINotifier>(
              create: (_) => uINotifier,
              update: (context, value, notifier) {
                if (value.state.isFinished) {
                  uINotifier.update(GameEndedEvent());
                }
                return uINotifier;
              },
            )
          ],
          child: Scaffold(
            body: MainBody(),
          ),
        ),
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UINotifier>().state;
    return AnimatedContainer(
      duration: Duration(milliseconds: UINotifier.animationMillis),
      color: state.isAnimating
          ? state.selectedFood!.isHealthy
              ? Colors.green
              : Colors.red
          : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: TimerWidget()),
          FoodRow(),
        ],
      ),
    );
  }
}

class FoodRow extends StatelessWidget {
  const FoodRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UINotifier>(
      builder: (context, value, _) => SizedBox(
        height: MediaQuery.of(context).size.height * .6,
        child: Stack(children: [
          AnimatedPositioned(
              left: MediaQuery.of(context).size.width * .05,
              top: value.state.isAnimating
                  ? MediaQuery.of(context).size.height * .8
                  : MediaQuery.of(context).size.height * .15,
              duration: Duration(milliseconds: UINotifier.animationMillis),
              child: FoodWidget(food: value.state.foods.first)),
          AnimatedPositioned(
              left: MediaQuery.of(context).size.width * .5,
              top: value.state.isAnimating
                  ? MediaQuery.of(context).size.height * -.8
                  : MediaQuery.of(context).size.height * .15,
              duration: Duration(milliseconds: UINotifier.animationMillis),
              child: FoodWidget(food: value.state.foods.last)),
        ]),
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TimedGameEngine>(builder: (context, value, child) {
      final val = ((60 - (value.state.remainingTime ?? 0)) / 60);
      log('$val');
      return Column(
        children: [
          Expanded(
            child: Stack(children: [
              Positioned(
                top: MediaQuery.of(context).size.height * .05,
                left: MediaQuery.of(context).size.width * .35,
                height: MediaQuery.of(context).size.width * .3,
                width: MediaQuery.of(context).size.width * .3,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  value: 1 - val,
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * .05 +
                      MediaQuery.of(context).size.width * .15 -
                      14,
                  left: MediaQuery.of(context).size.width * .5 - 14,
                  child: Text(
                    '${value.state.remainingTime}',
                    style: TextStyle(fontSize: 24),
                  )),
            ]),
          ),
          Text(
            '${value.state.points}',
            style: TextStyle(color: Colors.greenAccent, fontSize: 20),
          )
        ],
      );
    });
  }
}
