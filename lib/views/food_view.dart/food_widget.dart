import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thu_yemek_app/engine/engine.dart';
import 'package:thu_yemek_app/engine/game_event.dart' as game;

import '../../state/ui_state.dart';

class FoodWidget extends StatelessWidget {
  final Food food;
  const FoodWidget({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          !Provider.of<UINotifier>(context, listen: false).state.canSelectFood
              ? null
              : () {
                  Provider.of<UINotifier>(context, listen: false)
                      .update(FoodSelectedEvent(food));
                  Provider.of<TimedGameEngine>(context, listen: false)
                      .foodSelected(game.FoodSelectedEvent(food));
                },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(width: 1.6),
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fill,
                    image: AssetImage(food.photoPath))),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * .3,
          ),
          Text(
            food.name,
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
    );
  }
}
