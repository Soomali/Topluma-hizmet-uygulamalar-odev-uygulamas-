import 'package:flutter/material.dart';
import 'package:thu_yemek_app/state/state.dart';

class UINotifier extends ChangeNotifier {
  UIState _state = UIState(true, []);
}
