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
      duration: Duration(milliseconds: 150),
      color: state.isAnimating
          ? state.selectedFood!.isHealthy
              ? Colors.green
              : Colors.red
          : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimerWidget(),
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
                  ? MediaQuery.of(context).size.height * 1
                  : 10,
              duration: Duration(milliseconds: 250),
              child: FoodWidget(food: value.state.foods.first)),
          AnimatedPositioned(
              left: MediaQuery.of(context).size.width * .5,
              top: value.state.isAnimating
                  ? MediaQuery.of(context).size.height * -1
                  : 10,
              duration: Duration(milliseconds: 250),
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
      return Text(
          'kalan zaman:${value.state.remainingTime} sn, puan ${value.state.points}');
    });
  }
}
