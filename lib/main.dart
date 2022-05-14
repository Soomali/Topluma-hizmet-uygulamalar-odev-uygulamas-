import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_yemek_app/engine/engine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engine = TimedGameEngine(60);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ChangeNotifierProvider.value(
          value: engine,
          child: MainPage(),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<TimedGameEngine>(
            builder: ((context, value, child) => Text(
                'kalan zaman:${value.state.remainingTime},oyun bitti mi: ${value.state.isFinished}'))),
        TextButton(
            onPressed: () {
              Provider.of<TimedGameEngine>(context, listen: false).start();
            },
            child: Text('Başlat')),
        TextButton(
            onPressed: () {
              Provider.of<TimedGameEngine>(context, listen: false).pause();
            },
            child: Text('durdur')),
        TextButton(
            onPressed: () {
              Provider.of<TimedGameEngine>(context, listen: false).resume();
            },
            child: Text('devam ettir')),
      ],
    );
  }
}
